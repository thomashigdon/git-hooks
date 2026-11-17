# git-hooks

Global git hooks that block commits containing secrets.

- `pre-commit` runs [gitleaks](https://github.com/gitleaks/gitleaks) on the staged changes and blocks the commit if it finds anything.
- `commit-msg` adds a `Scanned-by: gitleaks` trailer to commits that passed. The `gitleaks` workflow in each repo flags pushed commits without it, which means the client that made them is missing this setup.
- Every other hook passes through to the repo's own `.git/hooks`, which a global `core.hooksPath` would otherwise disable.

## Set up a new client

1. Install gitleaks (`brew install gitleaks`, or a release from https://github.com/gitleaks/gitleaks/releases).
2. Clone this repo and point git at it:

   ```sh
   git clone https://github.com/thomashigdon/git-hooks ~/.git-hooks
   git config --global core.hooksPath ~/.git-hooks
   ```

3. Optional, for Husky repos (they override `core.hooksPath`):

   ```sh
   mkdir -p ~/.config/husky && echo '. ~/.git-hooks/husky-init.sh' >> ~/.config/husky/init.sh
   ```

## Escape hatches

- Skip the scan for one commit: set `SKIP_GITLEAKS` (any value), e.g. `env SKIP_GITLEAKS=yes git commit` (the commit gets no trailer, so CI flags it).
- No trailer in one repo, e.g. a fork whose commits go upstream: `git config hooks.scannedByTrailer false`.
