#!/bin/bash

# ==============================================
# oh-my-zsh-gitworktree Installation Script
# ==============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Plugin directory
PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/gitworktree"

echo "🚀 Installing oh-my-zsh-gitworktree..."

# Check if oh-my-zsh is installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo -e "${RED}❌ oh-my-zsh is not installed!${NC}"
  echo "Please install oh-my-zsh first:"
  echo "  sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
  exit 1
fi

# Remove existing installation if present
if [[ -d "$PLUGIN_DIR" ]]; then
  echo -e "${YELLOW}⚠️  Existing installation found. Removing...${NC}"
  rm -rf "$PLUGIN_DIR"
fi

# Create plugin directory
mkdir -p "$(dirname "$PLUGIN_DIR")"

# Clone the repository
echo "📦 Cloning repository..."
git clone https://github.com/foolgry/oh-my-zsh-gitworktree.git "$PLUGIN_DIR"

# Check if plugin is already in .zshrc
if grep -q "gitworktree" ~/.zshrc 2>/dev/null; then
  echo -e "${GREEN}✅ Plugin already configured in .zshrc${NC}"
else
  echo ""
  echo -e "${YELLOW}📝 Manual step required:${NC}"
  echo "  Please add 'gitworktree' to your plugins array in ~/.zshrc:"
  echo ""
  echo "  plugins=(... gitworktree)"
  echo ""
  echo "  Then reload your configuration:"
  echo "  source ~/.zshrc"
fi

echo ""
echo -e "${GREEN}✅ Installation completed!${NC}"
echo "📍 Plugin installed at: $PLUGIN_DIR"
