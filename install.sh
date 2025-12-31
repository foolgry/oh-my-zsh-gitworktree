#!/bin/bash

# ==============================================
# oh-my-zsh-gitworktree Installation Script
# oh-my-zsh-gitworktree 安装脚本
# ==============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Plugin directory
PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/gitworktree"

echo "🚀 Installing oh-my-zsh-gitworktree... / 正在安装 oh-my-zsh-gitworktree..."

# Check if oh-my-zsh is installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo -e "${RED}❌ oh-my-zsh is not installed! / oh-my-zsh 未安装！${NC}"
  echo "Please install oh-my-zsh first: / 请先安装 oh-my-zsh："
  echo "  sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
  exit 1
fi

# Remove existing installation if present
if [[ -d "$PLUGIN_DIR" ]]; then
  echo -e "${YELLOW}⚠️  Existing installation found. Removing... / 发现已存在的安装，正在删除...${NC}"
  rm -rf "$PLUGIN_DIR"
fi

# Create plugin directory
mkdir -p "$(dirname "$PLUGIN_DIR")"

# Clone the repository
echo "📦 Cloning repository... / 正在克隆仓库..."
git clone https://github.com/foolgry/oh-my-zsh-gitworktree.git "$PLUGIN_DIR"

# Check if plugin is already in .zshrc
if grep -q "gitworktree" ~/.zshrc 2>/dev/null; then
  echo -e "${GREEN}✅ Plugin already configured in .zshrc / 插件已在 .zshrc 中配置${NC}"
else
  echo ""
  echo -e "${YELLOW}📝 Manual step required: / 需要手动操作：${NC}"
  echo "  Please add 'gitworktree' to your plugins array in ~/.zshrc:"
  echo "  请在 ~/.zshrc 的 plugins 数组中添加 'gitworktree'："
  echo ""
  echo "  plugins=(... gitworktree)"
  echo ""
  echo "  Then reload your configuration: / 然后重新加载配置："
  echo "  source ~/.zshrc"
fi

echo ""
echo -e "${GREEN}✅ Installation completed! / 安装完成！${NC}"
echo "📍 Plugin installed at: / 插件安装位置: $PLUGIN_DIR"
