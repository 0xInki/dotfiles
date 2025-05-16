# ~/.config/git-messages.zsh

git_status_prompt() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local dirty=""
    local staged=""
    local ahead=""
    
    # Check uncommitted changes
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      dirty="%F{white}*%f"
    fi
    
    # Check staged changes
    git diff --cached --quiet --ignore-submodules -- . || staged="%F{white}+%f"
    
    # Check if ahead of remote
    if [[ $(git rev-list --count @{upstream}..HEAD 2>/dev/null) -gt 0 ]]; then
      ahead="%F{white}↑%f"
    fi
    
    echo "%F{202}${branch}%f${dirty}${staged}${ahead}"
  else
    echo ""
  fi
}

git() {
  local exit_code

  if [[ $1 == "push" ]]; then
    command git "$@"
    exit_code=$?
    [[ $exit_code -eq 0 ]] && git_push_message || git_push_fail
    return $exit_code

  elif [[ $1 == "commit" ]]; then
    command git "$@"
    exit_code=$?
    [[ $exit_code -eq 0 ]] && git_commit_message || git_commit_fail
    return $exit_code

  elif [[ $1 == "pull" ]]; then
    command git "$@"
    exit_code=$?
    [[ $exit_code -eq 0 ]] && git_pull_message || git_pull_fail
    return $exit_code

  elif [[ $1 == "status" ]]; then
    git_status_art
    return $?

  else
    command git "$@"
  fi
}

git_push_message() {
	if git rev-parse --git-dir > /dev/null 2>&1; then
		if [ $? -eq 0 ]; then
			echo ""
			echo ""
			echo "    ⛩️───────────────────────────⛩️"
			echo "             Git Push 成功！"
			echo "          状態 : 完璧 (Perfect)"
			echo "     リモート : 同期済み (Synced)"
			echo "    ⛩️───────────────────────────⛩️"
			echo ""
			echo ""
		fi
	fi
}

git_push_fail() {
	echo ""
	echo ""
	echo "    ☠️━━━━━━━━━━━━━━━━━━━━━━━━━☠️"
	echo "           Git Push 失敗！"
	echo "        状態 : エラー (Error)"
	echo "     リモート : 非同期 (Desynced)"
	echo "    ☠️━━━━━━━━━━━━━━━━━━━━━━━━━☠️"
	echo ""
	echo ""
}

git_commit_message() {
	echo ""
	echo ""
	echo "    🖋️═════════════════════════🖋️"
	echo "         Git Commit 成功！"
	echo "      状態 : 保存済み (Saved)"
	echo "     意志 : 明確 (Clear Intent)"
	echo "    🖋️═════════════════════════🖋️"
	echo ""
	echo ""
}

git_commit_fail() {
	echo ""
	echo ""
	echo "    🛑╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌⛔"
	echo "        Git Commit 中止！"
	echo "     状態 : 未保存 (Not Saved)"
	echo "       理由 : エラー (Error)"
	echo "    ⛔╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌🛑"
	echo ""
	echo ""
}

git_pull_message() {
	echo ""
	echo ""
	echo "    📥🌸━━━━━━━━━━━━━━━━━━━━━━━🌸📥"
	echo "           Git Pull 成功！"
	echo "       状態 : 最新 (Up-to-date)"
	echo "     リモート : 統合済み (Merged)"
	echo "    📥🌸━━━━━━━━━━━━━━━━━━━━━━━🌸📥"
	echo ""
	echo ""
}

git_pull_fail() {
	echo ""
	echo ""
	echo "    ⚔️🔥╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌🔥⚔️"
	echo "             Git Pull 衝突！"
	echo "       状態 : 衝突発生 (Conflict)"
	echo "     解決 : 必要 (Needs Resolution)"
	echo "    ⚔️🔥╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌🔥⚔️"
	echo ""
	echo ""
}

git_status_art() {
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo ""
		echo ""
		echo "    📜⛩️━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━⛩️📜"
		echo ""
		echo "    ⚠️ このディレクトリは This is not a Git repo リポジトリではありません。"
		echo ""
		echo "    📜⛩️━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━⛩️📜"
		echo ""
		echo ""
		return
	fi

	echo ""
	echo ""
	echo "    📜⛩️━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━⛩️📜"
	echo "                  Git Status 状態"
	echo ""

	local conflicts
	conflicts=$(git diff --name-only --diff-filter=U)

	local staged
	staged=$(git diff --cached --name-status)

	local unstaged
	unstaged=$(git diff --name-status)

	local untracked
	untracked=$(git ls-files --others --exclude-standard)

	if [[ -z "$conflicts" && -z "$staged" && -z "$unstaged" && -z "$untracked" ]]; then
		echo "    \033[38;5;245m     ワークツリー: クリーン (Clean)\033[0m"
		echo "    \033[38;5;245m     全てコミット済み (All committed)\033[0m"
	else
		if [[ -n "$conflicts" ]]; then
			echo "    \033[38;5;196m⚠️ コンフリクト中のファイル (Conflicting files):\033[0m"
			echo "    \033[38;5;196m────────────────────────────────────────────────\033[0m"
			echo "$conflicts" | sed 's/^/    /'
			echo "    \033[38;5;196m────────────────────────────────────────────────\033[0m"
			echo ""
		fi

		if [[ -n "$staged" ]]; then
			echo "    \033[38;5;82mステージング済みファイル (Staged files):\033[0m"
			echo "    \033[38;5;82m──────────────────────────────────────────────\033[0m"
			echo "$staged" | sed 's/^/    /'
			echo "    \033[38;5;82m──────────────────────────────────────────────\033[0m"
			echo ""
		else
			echo "    \033[38;5;82mステージング済みファイル: なし (None)\033[0m"
			echo ""
		fi

		if [[ -n "$unstaged" ]]; then
			echo "    \033[38;5;208m未ステージファイル (Unstaged files):\033[0m"
			echo "    \033[38;5;208m──────────────────────────────────────────────\033[0m"
			echo "$unstaged" | sed 's/^/    /'
			echo "    \033[38;5;208m──────────────────────────────────────────────\033[0m"
			echo ""
		else
			echo "    \033[38;5;208m未ステージファイル: なし (None)\033[0m"
			echo ""
		fi

		if [[ -n "$untracked" ]]; then
			echo "    \033[38;5;117m新規ファイル (Untracked files):\033[0m"
			echo "    \033[38;5;117m────────────────────────────────────────────\033[0m"
			echo "$untracked" | sed 's/^/    /'
			echo "    \033[38;5;117m────────────────────────────────────────────\033[0m"
			echo ""
		else
			echo "    \033[38;5;117m新規ファイル: なし (None)\033[0m"
			echo ""
		fi
	fi

	echo "    📜⛩️━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━⛩️📜"
	echo ""
	echo ""
}

