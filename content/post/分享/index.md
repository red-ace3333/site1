---
title: "分享"
description: "新生研讨分享--安排学习生活"
date: 2025-11-22T20:42:26+08:00
image: ""
math: false
license: ""
hidden: false
comments: true
draft: false
toc: true
tags: ["学习生活", "分享"]
categories: ["生活分享"]
---

# 新生研讨分享--安排学习生活

## 学习方面

- 课堂上，认真听讲，记笔记
  - 大部分老师会指出重点内容
  - 对比记笔记和不记笔记，前者课后没有印象，后者留有印象
  - 用于期末复习，不用把老师的所有 PPT、课本从头到尾看一遍，主看笔记，辅看 PPT、课本
  - 对比高中和大学 前者是高度结构化、被动接受 后者是高度自由化、主动探索

<center>

![](/images/posts/分享/1.jpg)

图 1 记了很多笔记

</center>

- 作业认真独立完成，弄懂（本专业经验来看，考试题目与课后作业比较类似）

- 对于所谓的水课，感兴趣的好好听，不感兴趣的选择性听，报告好好写
  - 推荐直接使用西电同学维护的 macOS LaTeX 模板：[Xidian-LaTeX-Template-for-macOS](https://github.com/Ronchy2000/Xidian-LaTeX-Template-for-macOS)
    （也可以作为通用课程/实验报告模板参考）
  - 流程：先 clone / 下载模板 → 本地用 VS Code + LaTeX Workshop（或 MacTeX）配好一次环境 → 以后再写新报告只需要改 `main.tex` 里的章节内容即可

## 生活方面

- 写日记（每天花费十几分钟简单记录以下今日生活及明日计划）

<center>

![](/images/posts/分享/1.png)

图 2 2023 年末至 2024 年初日记

</center>

## 其他

- 完成必做事项后，还有多余的时间，可以找找自己感兴趣的事情，尝试不同的东西
  - 写网站、博客
  - 学习单片机控制
  - 写软件
  - 国内外有很多资源可以学习
    - [B 站 丰富的技能教程](https://www.bilibili.com/?spm_id_from=333.1007.0.0)、
    - [MOOC 国内顶尖课程](https://www.icourse163.org/)、
    - [Coursera 国际知名课程](https://www.coursera.org/)、
    - [MIT开放课程 世界一流教育资源](https://ocw.mit.edu/)、
    - [CS自学指南 计算机专业学习路线](https://csdiy.wiki/) 
  - 参加竞赛
  - 跑步、锻炼
  - 出去玩
  - 阅读
  - ……
  - 大胆探索、大胆尝试
- 遇到难题，怎么解决
  - 问熟悉这方面的人是最快的
  - 然后是视频、文字教程等
  - 实践探索（可能会走很多弯路）
- 拒绝内耗
- 多与家人、朋友交流分享，分享困惑与快乐
- 相信只要有需求，就能找到解决方法
  - 可以使用工具完成的事情，不要亲力亲为
    - 举例 1：写课程/实验报告 —— 「LaTeX 模板 + AI Agent 自动填内容」
      1. 先用上面推荐的 [Xidian-LaTeX-Template-for-macOS](https://github.com/Ronchy2000/Xidian-LaTeX-Template-for-macOS)
         把模板在本地配好（`latexmk` 能成功一次编译出 PDF 即可）；
      2. 把「实验要求 / 老师给的 PPT / 课本章节 / 手写草稿 / 代码与运行截图」
         一股脑丢给支持文件上下文的 Agent（例如 **Trae**、GitHub **Copilot**、
         OpenAI **Codex**/Cursor、Claude Projects 等）；
      3. 给 Agent 一个固定 Prompt，比如：
         ```
         你是一个 LaTeX 报告代写助手，只能修改 \section 开头到 \subsection 结束的正文，
         不能动模板里的 \documentclass / \usepackage / 宏命令 / 封面命令。
         按「实验目的 → 原理与步骤 → 结果分析 → 代码附录 → 结论」的结构填，
         中文+公式用 siunitx/mhchem 环境，引用代码用 listings 并保留我给的源码，
         最后逐段对照我给的草稿补全，不要凭空捏造数据。
         ```
      4. Agent 直接输出可编译的 `.tex` 片段 → 粘进模板对应的章节 →
         你自己**只负责审读 + 微调 + 编译出最终 PDF**，
         这样一份 5-20 页的报告从「空白」到「可提交成品」的时间可以从 2-4 小时
         压缩到 20-40 分钟，且格式、字体、章节编号、参考文献完全符合模板。
    - 举例 2：流程化与自动化 —— 写文档/交作业/整理笔记，只要重复做 3 次以上，
      就应该把它写成命令、脚本、模板、或者 Agent 的固定 System Prompt。
      「我每次都要把 A 文件的内容搬去 B 文件」—— 那不是勤劳，是该自动化的信号。