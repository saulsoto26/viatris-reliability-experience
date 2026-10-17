#!/usr/bin/env bash
# Publish with GitHub CLI (https://cli.github.com). Run from this folder after: gh auth login
set -e
OWNER="${1:-saulsoto26}"; REPO="${2:-viatris-reliability-experience}"
git init -q 2>/dev/null || true
git add -A && git commit -qm "Publish Viatris Reliability Experience" || true
git branch -M main
gh repo create "$OWNER/$REPO" --private --source=. --remote=origin --push
# GitHub Pages from main / root (private-repo Pages needs a paid GitHub plan)
gh api -X POST "repos/$OWNER/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null && \
  echo "Pages requested: https://$OWNER.github.io/$REPO/ (first build takes 1-2 minutes)" || \
  echo "Repository created. Enable Pages in Settings > Pages (branch main, folder /), or check your plan."
