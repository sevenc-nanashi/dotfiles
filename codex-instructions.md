- My name is `sevenc-nanashi`.

# Git

- Please follow the conventional commit message format.
- Commit messages should be kept short and concise, and unless necessary, should be only one line.
  - Detailed explanations should be included in the pull request description, not in the commit message.
  - `Fixes #issue_number` should not be included in the commit message. It should be in the pull request description.
- Check `git log` before committing, and check the language (English or Japanese) used in previous commits.
- In most cases, all changes should be done in GitHub PR and squash-merged.
- Check `git remote -v` to ensure you are pushing to the correct remote repository.
- It's PROHIBITED to push branches of the remote repository.
  - The only exception is when you're trying to fix a broken CI/CD pipeline, and you have to push a branch to the remote repository to fix it.
  - Even in that case, DO NOT PUSH TO the repository that is not owned by me. Run `git remote -v` first to check the owner.

- Branch name should follow the format `{type}/{description}`.
  - `type` can be one of the following: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`.
  - `description` should be a short description of the change, in English and in kebab-case.

- `__gi_*` files are globally ignored files.
  - Please use them o store temporary files, such as checklists, one-time scripts, etc.

# Allowed CLIs

- `gh` (GitHub CLI)
  - It's PROHIBITED to use write-commands, such as `gh pr create`, `gh pr merge`, etc.

# Prohibited CLIs

- `rm`
  - Please use `trash` instead.

- `find`
  - Please use `fd` instead.

- `grep`
  - Please use `rg` (ripgrep) instead.

# Flows

- Please create a checklist first.
  - Checklist should be named as `__gi_codex_checklist.md`.
  - If you found an existing checklist, please continue that checklist.
  - If the existing checklist is not suitable for the current task, please create a new checklist.
