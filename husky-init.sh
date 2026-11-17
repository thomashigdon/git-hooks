# Husky v9 sources ~/.config/husky/init.sh before each hook ($n = hook name). Husky repos set a
# local core.hooksPath, which bypasses the global hooks, so run the gitleaks scan from here.
# Source this file from ~/.config/husky/init.sh.
if [ "$n" = "pre-commit" ] && [ -z "$SKIP_GITLEAKS" ] && command -v gitleaks >/dev/null 2>&1; then
  gitleaks git --pre-commit --staged --redact --no-banner -v || {
    echo "gitleaks: possible secret in staged changes; commit blocked (set SKIP_GITLEAKS to override)" >&2
    exit 1
  }
fi
