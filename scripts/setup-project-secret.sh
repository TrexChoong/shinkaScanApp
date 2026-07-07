#!/usr/bin/env bash
# Set the PROJECTS_TOKEN Actions secret so board-automation.yml can write the
# project board. The default Actions GITHUB_TOKEN cannot write user-owned
# Projects, so a token with 'project' + 'repo' scopes is stored as a secret.
#
# By default this reuses the gh CLI's own token (gh auth token). For least
# privilege, pass a dedicated fine-grained PAT instead:
#     bash scripts/setup-project-secret.sh <token>
#
# Prereq: gh CLI authenticated with 'project' + 'repo' scopes
#         (check: gh auth status).
set -euo pipefail

cd "$(dirname "$0")/.."

TOKEN="${1:-$(gh auth token)}"
if [ -z "${TOKEN}" ]; then
  echo "error: no token available. Run 'gh auth login' or pass a PAT as \$1." >&2
  exit 1
fi

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "Repository: ${REPO}"

# Report classic-PAT scopes when the API exposes them (fine-grained tokens don't).
scopes=$(curl -fsSI -H "Authorization: token ${TOKEN}" https://api.github.com \
  | tr -d '\r' | awk -F': ' 'tolower($1)=="x-oauth-scopes"{print $2}')
if [ -n "${scopes:-}" ]; then
  echo "Token scopes: ${scopes}"
  case ",${scopes// /}," in
    *",project,"*) : ;;
    *) echo "warning: token is missing the 'project' scope; project writes will fail." >&2 ;;
  esac
else
  echo "Token scopes: (not reported — fine-grained token; ensure Issues + Projects = Read/write)"
fi

printf '%s' "${TOKEN}" | gh secret set PROJECTS_TOKEN --repo "${REPO}"
echo "Set PROJECTS_TOKEN on ${REPO} (source: ${1:+provided PAT}${1:-gh CLI token})."
echo "Next: Actions -> Board dependency automation -> Run workflow (sweep to verify)."
