---
title: "Markdown_Katex"
description: 
date: 2025-12-01T11:41:55+08:00
image: 
math: true
license: 
hidden: false
comments: true
draft: false
toc: true
tags: ['Katex']
---

# katex-1

## 1.1 行内公式（使用\\$...\\$）

- 这是勾股定理：`$a^2+b^2=c^2$` $a^2+b^2=c^2$
- 这是爱因斯坦质能方程：`$E=mc^2$` $E=mc^2$
- 这是分数： `$\frac {a} {b}$` $\frac {a} {b}$
- 这是二次方程的解：`$x=\frac {-b \pm \sqrt{b^2-4ac}}{2a}$` $x=\frac {-b \pm \sqrt{b^2-4ac}}{2a}$

## 1.2 块级公式(使用\$\$...\$\\$)

```latex
$$\int_{-\infty}^{\infty} e^{x^2}\,dx = \sqrt{\pi}$$
```

- $$\int_{-\infty}^{\infty} e^{x^2}\,dx = \sqrt{\pi}$$

```latex
$$f(x)=\sum _{n=0}^{\infty}\frac{f^{n}(a)} {n!}(x-a)^{n}$$
```

- $$f(x)=\sum _{n=0}^{\infty}\frac{f^{n}(a)} {n!}(x-a)^{n}$$

## 1.3 常用语法

### 1.3.1 上下标

- 上标： `$x^2$` $x^2$ `$e^{x+y}$` $e^{x+y}$
- 下标： `$x_1$` $x_1$ `$a_{ij}$` $a_{ij}$
- 组合： `$\sum_{n=0}^{\infty}$` $\sum_{n=0}^{\infty}$

### 1.3.2 分式与根式

- 分式： `$\frac{a}{b}$` $\frac{a}{b}$ `$\frac{1}{1+\frac{1}}{x}}$` $\frac{1}{1+\frac{1}{x}}$
- 根式： `$\sqrt{x}$` $\sqrt{x}$ `$\sqrt[n]{x}$` $\sqrt[n]{x}$ `$\sqrt[3]{8}=2$` $\sqrt[3]{8}=2$

### 1.3.3 希腊字母

![[希腊字母latex语法.png]]

- 小写： `$\alpha$` $\alpha$ `$\beta $` $\beta $ `$\gamma$` $\gamma$ `$\pi$` $\pi$ `$\omega$` $\omega$
- 大写：`$\Alpha$` $\Alpha$  `$\Beta$` $\Beta$  `$\Gamma$` $\Gamma$ `$\Pi$` $\Pi$ `$\Omega$` $\Omega$
### 1.3.4 运算符

- 加减乘除： `$+ - \times \div \pm \mp$` $+ - \times \div \pm \mp$
- 关系运算符： `$= \neq < > \leq \geq \approx \equiv$` $= \neq < > \leq \geq \approx \equiv$
- 集合运算符： `$\in \notin \subset \subseteq \cup \cap$` $\in \notin \subset \subseteq \cup \cap$
- 逻辑运算符： `$\land \lor \neg \implies \iff$` $\land \lor \neg \implies \iff$
- 微积分运算符： `$\int \sum \prod \lim \partial$` $\int \sum \prod \lim \partial$
- 其他运算符： `$\forall \exists \nabla \infty$` $\forall \exists \nabla \infty$
- 矩阵： `$\begin{bmatrix} a & b \\ c & d \end{bmatrix}$` $\begin{bmatrix} a & b \\ c & d \end{bmatrix}$

### 1.3.5 大型运算符实例

```latex
$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$
```

$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

```latex
$$
\int_{a}^{b}\,f(x)\,dx=F(a)-F(b)
$$
```

$$
\int_{a}^{b}\,f(x)\,dx=F(a)-F(b)
$$

```latex
$$
\prod_{i=1}^{n}\,i=n!
$$
```

$$
\prod_{i=1}^{n}\,i=n!
$$

### 1.3.6 括号和定界符

- 小括号： `$(x+y)$` $(x+y)$
- 中括号： `$[x+y]$` $[x+y]$
- 大括号： `$\{x+y\}$` $\{x+y\}$
- 绝对值： `$|x+y|$` $|x+y|$
- 角括号： `$\langle x+y \rangle$` $\langle x+y \rangle$

### 1.3.7 矩阵、行列式

```latex
$$
\begin{bmatrix}
a & b \\
c & d
\end{bmatrix}
$$
```

$$
\begin{bmatrix}
a & b \\
c & d
\end{bmatrix}
$$

```latex
$$
\begin{vmatrix}
a & b \\
c & d
\end{vmatrix}
$$
```

$$
\begin{vmatrix}
a & b \\
c & d
\end{vmatrix}
$$

```latex
$$
\begin{pmatrix}
a & b \\
c & d
\end{pmatrix}
$$
```

$$
\begin{pmatrix}
a & b \\
c & d
\end{pmatrix}
$$

```latex
$$
\det \begin{bmatrix}
a & b \\
c & d
\end{bmatrix} = ad - bc
$$
```

$$
\det \begin{bmatrix}
a & b \\
c & d
\end{bmatrix} = ad - bc
$$

### 1.3.8 对齐多行公式

```latex
$$
\begin{align}
a & = b + c \\
  & = d + e \\
  & = f + g
\end{align}
$$
```

$$
\begin{aligned}
a & = b + c \\
  & = d + e \\
  & = f + g
\end{aligned}
$$

```latex
$$
\begin{cases}
x + y = 10 \\
x - y = 4
\end{cases}
$$
```

$$
\begin{cases}
x + y = 10 \\
x - y = 4
\end{cases}
$$

### 1.3.9 实例

- 薛定谔方程：

```latex
i\hbar\frac{\partial}{\partial t}\Psi = \hat{H}\Psi
```

$$
i\hbar\frac{\partial}{\partial t}\Psi = \hat{H}\Psi
$$

- 欧拉公式：

```latex
e^{i\theta} = \cos{\theta} + i\sin{\theta}
```

$$
e^{i\theta} = \cos{\theta} + i\sin{\theta}
$$

- 麦克斯韦方程组：

```latex
\begin{cases}
\nabla \cdot \mathbf{E} = \frac {\rho} {\varepsilon_0} \\
\nabla \cdot \mathbf{B} = 0 \\
\nabla \times \mathbf{E} = -\frac {\partial \mathbf{B}} {\partial t} \\
\nabla \times \mathbf{B} = \mu_0 \mathbf{J} + \mu_0 \varepsilon_0 \frac {\partial \mathbf{E}} {\partial t}
\end{cases}
```

$$
\begin{cases}
\nabla \cdot \mathbf{E} = \frac {\rho} {\varepsilon_0} \\
\nabla \cdot \mathbf{B} = 0 \\
\nabla \times \mathbf{E} = -\frac {\partial \mathbf{B}} {\partial t} \\
\nabla \times \mathbf{B} = \mu_0 \mathbf{J} + \mu_0 \varepsilon_0 \frac {\partial \mathbf{E}} {\partial t}
\end{cases}
$$
