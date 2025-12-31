# =============================================
# Git Worktree 快速管理助手
# =============================================

# Create a new worktree and branch from within current git directory.
gwa() {
  if [[ -z "$1" ]]; then
    echo "Usage: gwa <branch-name>"
    return 1
  fi

  local branch="$1"
  local base="$(basename "$PWD")"
  local worktree_path="../${base}-${branch}"

  git worktree add -b "$branch" "$worktree_path" || return 1
  cd "$worktree_path"
  echo "✅ 已创建 worktree 并切换到: $worktree_path (分支: $branch)"
}

# Remove worktree and branch from within active worktree directory.
gwd() {
  # 检查 gum 是否可用
  if ! command -v gum >/dev/null 2>&1; then
    echo "❌ gwd 需要 gum。请执行: brew install gum"
    return 1
  fi

  # 获取主仓库路径
  local common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
  if [[ -z "$common_dir" ]]; then
    echo "❌ 当前不在 Git 仓库中"
    return 1
  fi

  # 主仓库的实际物理路径
  local main_repo_path=$(cd "$common_dir/.." && pwd)
  local current_dir=$(pwd)

  # 主仓库保护：禁止在主仓库中删除
  if [[ "$current_dir" == "$main_repo_path" ]]; then
    echo "❌ 警告：你当前就在主仓库中，不能删除！"
    return 1
  fi

  if ! gum confirm "🚨 确认删除当前 worktree 和对应分支？"; then
    echo "❎ 操作已取消"
    return 0
  fi

  local worktree_name="$(basename "$current_dir")"
  local branch_name=$(git rev-parse --abbrev-ref HEAD)

  # 分隔符检查：必须是 worktree 格式（包含 `-`）
  local root="${worktree_name%%-*}"

  # 保护非 worktree 目录（如果不包含 `-`，则不是 worktree）
  if [[ "$root" == "$worktree_name" ]]; then
    echo "❌ 当前目录不是 worktree 目录（目录名不包含 '-' 分隔符）"
    return 1
  fi

  # 切换回主仓库目录，这样才能执行删除操作
  cd "$main_repo_path" || { echo "❌ 无法回退到主仓库目录: $main_repo_path"; return 1; }

  # 执行删除
  git worktree remove "$worktree_name" --force
  git branch -D "$branch_name"

  echo "🗑️  已清理完成！"
  echo "📍 当前已回到主仓库: $main_repo_path"
}
