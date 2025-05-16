# ~/.config/git-messages.zsh

git_push_message() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if [ $? -eq 0 ]; then
      echo ""
      echo "    ⛩️───────────────────────────⛩️"
      echo "          Git Push 成功！"
      echo "     状態 : 完璧 (Perfect)"
      echo "     リモート : 同期済み (Synced)"
      echo "    ⛩️───────────────────────────⛩️"
    fi
  fi
}

git_push_fail() {
  echo ""
  echo "    ☠️━━━━━━━━━━━━━━━━━━━━━━━━━☠️"
  echo "         Git Push 失敗！"
  echo "     状態 : エラー (Error)"
  echo "     リモート : 非同期 (Desynced)"
  echo "    ☠️━━━━━━━━━━━━━━━━━━━━━━━━━☠️"
}

git_commit_message() {
  echo ""
  echo "    🖋️═════════════════════════🖋️"
  echo "         Git Commit 成功！"
  echo "     状態 : 保存済み (Saved)"
  echo "     意志 : 明確 (Clear Intent)"
  echo "    🖋️═════════════════════════🖋️"
}

git_commit_fail() {
  echo ""
  echo "    🛑╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌⛔"
  echo "        Git Commit 中止！"
  echo "     状態 : 未保存 (Not Saved)"
  echo "     理由 : エラー (Error)"
  echo "    ⛔╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌🛑"
}

git_pull_message() {
  echo ""
  echo "    📥🌸━━━━━━━━━━━━━━━━━━━━━━━🌸📥"
  echo "          Git Pull 成功！"
  echo "     状態 : 最新 (Up-to-date)"
  echo "     リモート : 統合済み (Merged)"
  echo "    📥🌸━━━━━━━━━━━━━━━━━━━━━━━🌸📥"
}

git_pull_fail() {
  echo ""
  echo "    ⚔️🔥╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌🔥⚔️"
  echo "        Git Pull 衝突！"
  echo "     状態 : 衝突発生 (Conflict)"
  echo "     解決 : 必要 (Needs Resolution)"
  echo "    ⚔️🔥╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌🔥⚔️"
}

