#!/usr/bin/env python3
"""
Hugo 构建后处理脚本：修复子路径部署下 src=/data-src=/href= 本地绝对路径缺失
basePath 前缀（/site1/）的问题。作为「模板层修复失效时的最后防线」。

用法：
    hugo --gc --minify
    python3 scripts/fix_prefix_post_build.py --public public --base-path /site1

作用：
    扫描 public/**/*.html 内所有 img/a/style 等的 URL 属性
    （src / data-src / data-srcset / href / poster 等）
    对 URL == "/images/xxx"、"/avatar/xxx"、"/js/xxx"、"/css/xxx"、
    "/favicon.xxx"、"/post/xxx" 这类「/ 开头、且第二个字符不是 /（非协议）、
    且不已经以 /site1/ 开头」的本地绝对路径 URL，统一替换为
    "/site1/images/xxx"。已经是 http(s): / data: / # / mailto: / /xxx?query
    （有前缀的）等全部跳过。不会产生 /site1/site1/ 双前缀。

默认 --base-path 自动从 hugo.yaml 的 baseURL 解析（优先）。
"""
from __future__ import annotations
import argparse
import os
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

# ---------- 从 hugo.yaml 解析 baseURL ----------
def parse_base_path_from_hugo_yaml(repo_root: Path) -> str | None:
    hugo = repo_root / "hugo.yaml"
    if not hugo.exists():
        return None
    with open(hugo, encoding="utf-8") as f:
        for raw in f:
            line = raw.strip()
            if line.startswith("baseURL:"):
                # baseURL: https://red-ace3333.github.io/site1/
                rest = line.split(":", 1)[1].strip().strip("'").strip('"')
                try:
                    path = urlparse(rest).path  # e.g. "/site1/"
                except Exception:
                    return None
                path = path.rstrip("/")
                if not path:
                    return ""
                return path
    return None


def should_rewrite(u: str, base_path: str) -> bool:
    """返回 True 表示 u 应该补 basePath 前缀"""
    if not u:
        return False
    # 非本地绝对 / 开头：跳过
    if not u.startswith("/"):
        return False
    # 协议相对 URL（//cdn....）：跳过
    if u.startswith("//"):
        return False
    # 已带 basePath 前缀：跳过（防双前缀）
    prefix = base_path + "/"
    if base_path and (u == base_path or u.startswith(prefix)):
        return False
    return True


def rewrite(u: str, base_path: str) -> str:
    if not base_path:
        return u
    return base_path + u


# 属性名 → 单值。注意 srcset 是多值（用空格或逗号分隔），稍后单独处理。
SINGLE_ATTRS = ["src", "data-src", "href", "poster", "data"]

def process_html(text: str, base_path: str) -> tuple[str, int]:
    """对单段 HTML 文本做替换。返回 (新文本, 替换次数)。"""
    total = 0

    # -------- 1. 处理单值属性：name="..." / name='...' / name=value(无引号) --------
    # 我们不假设属性一定在某个标签内，只要匹配到属性模式就处理（宽松稳健）。
    # 但为了避免误伤 CSS content 里的字符串，尽量用 tag 边界。
    attr_pat = re.compile(
        r"""
        (?P<name>src|data-src|href|poster|data)
        \s*=\s*
        (?:
            "(?P<dq>[^"]*)"           # double-quoted
          | '(?P<sq>[^']*)'           # single-quoted
          |  (?P<uq>[^\s<>]+)         # unquoted
        )
        """,
        re.IGNORECASE | re.VERBOSE,
    )

    def _repl_single(m: re.Match) -> str:
        nonlocal total
        name = m.group("name")
        url = m.group("dq") if m.group("dq") is not None else (m.group("sq") if m.group("sq") is not None else m.group("uq"))
        quote = '"' if m.group("dq") is not None else ("'" if m.group("sq") is not None else "")
        new_url = url
        if should_rewrite(url, base_path):
            new_url = rewrite(url, base_path)
            total += 1
        return f'{name}={quote}{new_url}{quote}' if quote else f'{name}={new_url}'

    text = attr_pat.sub(_repl_single, text)

    # -------- 2. 处理 srcset / data-srcset（多值：逗号分隔，每值可选空格加描述符） --------
    srcset_pat = re.compile(
        r"""
        (?P<name>srcset|data-srcset)
        \s*=\s*
        (?:
            "(?P<dq>[^"]*)"
          | '(?P<sq>[^']*)'
        )
        """,
        re.IGNORECASE | re.VERBOSE,
    )

    def _rewrite_srcset_value(s: str) -> str:
        nonlocal total
        # srcset: "/a.jpg 1x, /b.jpg 100w"
        parts = [p.strip() for p in s.split(",")]
        outs = []
        for p in parts:
            if not p:
                outs.append(p)
                continue
            tokens = p.split()  # [url] 或 [url, descriptor]
            url = tokens[0]
            rest = tokens[1:]
            if should_rewrite(url, base_path):
                url = rewrite(url, base_path)
                total += 1
            if rest:
                outs.append(url + " " + " ".join(rest))
            else:
                outs.append(url)
        return ", ".join(outs)

    def _repl_srcset(m: re.Match) -> str:
        name = m.group("name")
        val = m.group("dq") if m.group("dq") is not None else m.group("sq")
        quote = '"' if m.group("dq") is not None else "'"
        new_val = _rewrite_srcset_value(val)
        return f'{name}={quote}{new_val}{quote}'

    text = srcset_pat.sub(_repl_srcset, text)

    return text, total


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--public", default="public", help="Hugo 输出目录 (默认 public)")
    ap.add_argument("--base-path", default=None, help="子路径前缀，例如 /site1。留空则自动从 hugo.yaml 解析。")
    ap.add_argument("--dry-run", action="store_true", help="只扫描，不改文件")
    args = ap.parse_args()

    public = Path(args.public).resolve()
    if not public.is_dir():
        print(f"[fix_prefix] 错误: public 目录不存在: {public}", file=sys.stderr)
        return 2

    repo_root = Path(__file__).resolve().parent.parent
    base_path = args.base_path
    if base_path is None:
        base_path = parse_base_path_from_hugo_yaml(repo_root)
        if base_path is None:
            # 无法解析 → 不做任何事（安全退出）
            print("[fix_prefix] 跳过：hugo.yaml 中未找到 baseURL，或 base-path 为空。")
            return 0
    # 规范化 base_path：前面 /，后面空
    base_path = "/" + base_path.lstrip("/").rstrip("/")
    if base_path == "/":
        base_path = ""

    if not base_path:
        print("[fix_prefix] 跳过：base-path 为空（站点部署在域名根），无需后处理。")
        return 0

    htmls = sorted(public.rglob("*.html"))
    files_changed = 0
    total_replaced = 0
    for h in htmls:
        try:
            with open(h, "r", encoding="utf-8") as f:
                s = f.read()
        except UnicodeDecodeError:
            continue
        new_s, n = process_html(s, base_path)
        if n:
            files_changed += 1
            total_replaced += n
            rel = str(h.relative_to(public))
            print(f"  [FIXED +{n:2d}] {rel}")
            if not args.dry_run:
                with open(h, "w", encoding="utf-8") as f:
                    f.write(new_s)
    print(f"[fix_prefix] done. base-path={base_path!r}; 扫描 html={len(htmls)}; 修改文件={files_changed}; 替换点位={total_replaced}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
