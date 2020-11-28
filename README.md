# JMwill's dotfile

## 安装

**提醒**：本项目用于记录本人平常工作环境的配置文件，所有的设置不保证兼容性，使用前请确保已经了解项目内脚本作用，请勿盲目采用！

### 使用 Git 以及 bootstrap 脚本进行安装

通过 Git 工具将项目克隆到本地，我喜欢直接将克隆后的项目更名为 `~/.dotfiles`，也可以将项目克隆到任意喜欢的位置后再创建 `symlink` 链接到项目的位置，但名称需要是：`.dotfiles`

```shell
git clone https://github.com/JMwill/dotfiles.git && mv dotfiles ~/.dotfiles && cd ~/.dotfiles && source bootstrap.sh

# OR

git clone https://github.com/JMwill/dotfiles.git && ln -s dotfiles ~/.dotfiles && cd ~/.dotfiles && source bootstrap.sh
```

### 指定 `$PATH`

如果 `~/.dotfiles/shell/.path` 文件存在，则会与其他文件一起被加载，加载次序靠前，仅次于 `~/.dotfiles/.profile`

添加的例子可以如下：

```shell
export PATH="/usr/local/bin:$PATH"
```

### 添加自定义命令

如果 `~/.dotfiles/.extra` 文件存在，也会与其他文件一起加载，加载次序最后，因此可以新增、覆盖项目中的设置、命令、别名等
