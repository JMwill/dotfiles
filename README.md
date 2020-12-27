# JMwill's dotfile

## 依赖

### MacOS

首先安装管理工具 [brew](https://brew.sh/)，以及 `brew install rsync`

### Ubuntu

#### 通过 apt 安装的依赖

```shell
apt install -y build-essential \
  rsync \
  gcc \
  file \
  xsel
```

### 基础

必不可少的 [Git](https://git-scm.com/)，[curl](https://curl.se/) / [wget](https://www.gnu.org/software/wget/) 任意一个。其余依赖如下：

- Shell：[zsh](http://zsh.sourceforge.net/)，Ubuntu 下 apt，MacOS 则为 brew
- Shell 配置管理工具：[Oh My Zsh](https://ohmyz.sh/)
- 漫游文本系统工具：[autojump](https://github.com/wting/autojump)
- 命令行模糊查找工具：[fzf](https://github.com/junegunn/fzf)
- 文件传输工具 [rsync](https://rsync.samba.org/)
- 文本查找工具：[ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- 文本流处理工具：[gnu-sed](https://www.gnu.org/software/sed/) MacOS 上的 sed 功能较弱，因此安装此工具
- 博客框架：[hugo](https://gohugo.io/)

```shell
# Oh My Zsh 根据官方方式安装：https://ohmyz.sh/#install
# nvm 根据官方方式安装：https://github.com/nvm-sh/nvm#installing-and-updating

# MacOS
brew install git curl zsh autojump fzf ripgrep gun-sed hugo

# Ubuntu
apt install git zsh autojump fzf ripgrep hugo
```

#### Oh My Zsh 插件

- 主题 [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- 语法高亮插件：[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- 命令自动补全: [zsh-autosuggestions](git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions)

### 推荐工具

#### MacOS

```shell
brew install mitmproxy w3m tmux sqlite3 shellcheck tldr
brew cask install google-chrome appcleaner mathpix-snipping-tool \
            iterm2 visual-studio-code postman emacs \
            clashx keka iina \
            slack google-backup-and-sync xquartz \
            sourcetree telegram parallels-desktop
```

#### Ubuntu

```shell
# mitmproxy 在 linux 上需要下载安装包安装：https://mitmproxy.org/
apt install sdcv w3m tmux sqlite3 shellcheck tldr

snap install code emacs mathpix-snipping-tool
```

#### 命令行编辑器

近期对 Emacs 较为有兴趣，目前正在使用当中，推荐使用陈斌（斌哥）的[配置](https://github.com/redguardtoo/emacs.d)，上面安装的 w3m 也是为此服务的。

同时笔记记录方式目前采用 `org-roam` 所以需要安装依赖包：`sqlite3`，关系图的可视化目前还未使用，所需安装包暂未列出，可以自行根据文档安装 [org-roam 关系图形化](https://www.orgroam.com/manual.html#Graphing)


## 安装

**提醒**：本项目用于记录本人平常工作环境的配置文件，所有的设置不保证兼容性，使用前请确保已经了解项目内脚本作用，请勿盲目采用！

### 使用 Git 以及 bootstrap 脚本进行安装

通过 Git 工具将项目克隆到本地，我喜欢直接将克隆后的项目更名为 `~/.dotfiles`，也可以将项目克隆到任意喜欢的位置后再创建 `symlink` 链接到项目的位置，但名称需要是：`.dotfiles`

```shell
git clone https://github.com/JMwill/dotfiles.git && mv dotfiles ~/.dotfiles && cd ~/.dotfiles && source bootstrap.sh

# OR

git clone https://github.com/JMwill/dotfiles.git && ln -s dotfiles ~/.dotfiles && cd ~/.dotfiles && source bootstrap.sh
```

### 设置默认 Shell

```shell
chsh -s "$(command -v zsh)"
```

### 指定 `$PATH`

如果 `~/.dotfiles/shell/.path` 文件存在，则会与其他文件一起被加载，加载次序靠前，仅次于 `~/.dotfiles/.profile`

添加的例子可以如下：

```shell
export PATH="/usr/local/bin:$PATH"
```

### 添加自定义命令

如果 `~/.dotfiles/.extra` 文件存在，也会与其他文件一起加载，加载次序最后，因此可以新增、覆盖项目中的设置、命令、别名等
