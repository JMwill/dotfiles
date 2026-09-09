# JMwill's Dotfiles

基于 [chezmoi](https://www.chezmoi.io/) 构建的现代化、模块化、跨平台个人开发环境配置。

---

## 🌟 支持环境

* **Linux 桌面 / 服务器**（银河麒麟 Kylin V10 SP1 aarch64 / Ubuntu / Debian）
* **macOS**（Apple Silicon & Intel）
* **Android**（Termux 手机 / 平板终端）
* **Windows**（WSL2）

---

## 🚀 极速上手

### 1. 安装 Chezmoi

* **macOS**: `brew install chezmoi`
* **Android Termux**: `pkg install chezmoi`
* **Linux / WSL 一键安装**:
  ```bash
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
  ```

### 2. 一键初始化并部署

在任意新机器或移动设备上，只需一条命令即可全自动装配环境（自动安装依赖工具与插件、自动分发配置）：

```bash
chezmoi init --apply https://github.com/JMwill/dotfiles.git
```

---

## 📦 模块概览

| 模块 | 关键特性 | 对应源文件 |
| :--- | :--- | :--- |
| **Zsh** | Powerlevel10k 即时提示、zoxide 极速目录跳转 (保留 `j`/`ji`)、fnm (Node.js)、uv 补全、智能代理 `tproxy` / `tunproxy`、原生 Tmux 极速别名、原生 Git URL 提取 `gurl`、fd 极速文件检索 `ff`、历史记录防泄密、本地逃生舱 `~/.zshrc.local` | `dot_zshrc.tmpl` |
| **Tmux** | 256 真彩色 (`Tc`)、escape-time 10ms 零延迟优化、50000 行历史回滚、窗口自适应 1 起编号、当前目录平滑分屏 (`-` / `\|`)、四端自适应系统剪贴板 (`pbcopy` / `xclip` / `clip.exe` / `termux-clipboard-set`) | `dot_tmux.conf.tmpl` |
| **Git** | 跨平台凭据助手 (`osxkeychain` / Windows Credential Manager / `store`)、中文路径防乱码、全局忽略模板、彩色分支图 `git lg`、基于目录的公私邮箱智能切换 (`**/WorkProjects/**`) | `dot_gitconfig.tmpl`<br>`dot_gitignore_global` |
| **Vim** | 精简原生 ~100 行、单文件自洽 (内置官方旗舰配色 habamax，兼顾 desert)、选区极速搜索 (`*`/`#`)、自愈式跨会话持久撤销 (`undofile`)、双拼秒退编辑态 (`kj`)、代码折叠与无缝窗格跳转 | `dot_vimrc` |
| **Emacs** | 深度契合 `redguardtoo/emacs.d`、Emacs 29 编译告警静默、清华 ELPA 国内镜像加速、临时与备份文件全隔离、pyim 中文输入法弹窗、keyfreq 按键热度统计 | `dot_custom.el` |
| **装机总管** | 平台原生包管理器自动安装 (`apt` / `brew` / `pkg`)、`zoxide`、`uv`、`croc` 与 `fnm` 幂等自装、Oh My Zsh 插件自动克隆与 Gitee 镜像容错 | `run_once_before_install_packages.sh.tmpl` |

---

## 🛠️ 日常维护指南

* **查看当前配置与仓库模板差异**：
  ```bash
  chezmoi diff
  ```
* **将仓库最新修改应用到系统**：
  ```bash
  chezmoi apply
  ```
* **编辑模板**：
  ```bash
  chezmoi edit ~/.zshrc
  ```
* **将实机修改反向同步回仓库**：
  ```bash
  chezmoi re-add
  # 或
  chezmoi add ~/.zshrc
  ```
* **多端同步更新**：
  ```bash
  chezmoi update
  ```

---

## 🔒 私有与敏感配置隔离

* 本项目严格遵循开源安全规范，所有公用模板不含任何私有域名、公司 Token 或凭据。
* **单位内网代理白名单**：置于本地 `~/.zshrc.local` 中，自动加载且不入 Git 版本控制。
* **公司专属 Git 邮箱**：在任何 `**/WorkProjects/**` 路径下，自动引入本地 `~/.gitconfig.work` 身份。
