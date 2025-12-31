# oh-my-zsh-gitworktree

> 一个快速且安全的 Git Worktree 管理插件

[English](README.md) | 简体中文

## 特性

- ✨ **快速创建** - 一条命令即可创建新的 worktree
- 🛡️ **主仓库保护** - 防止误删主仓库
- 🔍 **智能检测** - 自动识别 worktree 目录并验证操作
- 🎨 **友好提示** - 美观的 emoji 增强反馈信息
- ⚡ **轻量级** - 无额外依赖（`gum` 为可选依赖）

## 安装

### 方法 1：一键安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/wangzhi108/oh-my-zsh-gitworktree/main/install.sh | bash
```

### 方法 2：手动安装

1. 克隆仓库到 oh-my-zsh 自定义插件目录：

```bash
git clone https://github.com/wangzhi108/oh-my-zsh-gitworktree.git \
  ~/.oh-my-zsh/custom/plugins/gitworktree
```

2. 在 `~/.zshrc` 的 `plugins` 中添加 `gitworktree`：

```zsh
plugins=(... gitworktree)
```

3. 重新加载 shell 配置：

```bash
source ~/.zshrc
```

## 使用方法

### `gwa` - Git Worktree Add

创建指定分支名的新 worktree：

```bash
gwa <分支名>
```

**示例：**

```bash
# 在主仓库中（如 ~/project/myapp）
gwa feature/new-ui

# 会创建：../myapp-feature/new-ui
# 并自动切换到该目录
```

**目录命名规则：**

```
<原目录名>-<分支名>
```

示例：
- `myapp` → `myapp-feature/login`
- `backend-api` → `backend-api-fix-bug`

### `gwd` - Git Worktree Delete

删除当前 worktree 及其对应分支：

```bash
gwd
```

**安全特性：**

- 🔒 **主仓库保护** - 无法在主仓库中执行
- ✅ **确认提示** - 使用 `gum` 进行交互式确认
- ✅ **目录验证** - 检查当前目录是否为有效的 worktree

**依赖要求：**

- 需要安装 [gum](https://github.com/charmbracelet/gum) 用于交互式确认：

```bash
brew install gum
```

## 使用示例

### 典型工作流

```bash
# 1. 在主仓库中
cd ~/project/myapp

# 2. 创建新的 worktree
gwa feature/user-auth

# 现在你在：../myapp-feature/user-auth

# 3. 开始工作...
git add .
git commit -m "添加用户认证"

# 4. 完成后，清理 worktree
gwd

# worktree 和分支已删除，你回到了主仓库
```

### 多 Worktree 并行开发

```bash
# 主仓库
cd ~/project/myapp

# 为不同任务创建多个 worktree
gwa feature/payment     # → ../myapp-feature/payment
gwa fix/bug-123         # → ../myapp-fix/bug-123
gwa refactor/database   # → ../myapp-refactor/database

# 每个 worktree 都是隔离的，可以有各自的：
# - 分支
# - 未提交的更改
# - Node modules / 依赖
# - 环境配置
```

## 命令参考

| 命令 | 说明 | 用法 |
|------|------|------|
| `gwa` | 添加（创建）新的 worktree | `gwa <分支名>` |
| `gwd` | 删除当前 worktree | `gwd` |

## 工作原理

### 目录结构

```
project/
├── myapp/              ← 主仓库
├── myapp-feature-a/    ← 功能分支 a 的 worktree
├── myapp-fix-bug-123/  ← Bug 修复的 worktree
└── myapp-refactor-db/  ← 重构的 worktree
```

### 安全机制

1. **主仓库检测** - 使用 `git rev-parse --git-common-dir` 识别主仓库
2. **Worktree 验证** - 检查目录命名规则（必须包含 `-`）
3. **操作确认** - 执行破坏性操作前需要确认

## 系统要求

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- Git 2.19+ (支持 worktree)
- [gum](https://github.com/charmbracelet/gum) (可选，用于 `gwd` 确认提示)

## 许可证

MIT License - 可自由使用和修改。

## 贡献

欢迎贡献！请随时提交 Pull Request。

## 致谢

本插件改编自 [vikingmute 的 Git Worktree 管理脚本](https://gist.github.com/vikingmute/0c641db6a834a7a6bee7bd677323bc97)，原脚本分享于[这条推文](https://x.com/vikingmute/status/2006004791424733525)。

原始脚本已被改造为 oh-my-zsh 插件格式，以便更轻松地安装和使用。
