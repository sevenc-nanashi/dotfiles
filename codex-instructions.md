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

- `npm`, `yarn`
  - Please use `pnpm`, unless the project specifically requires `npm` or `yarn`.
    - Check the project's documentation to see if it requires `npm`, `yarn`, or `pnpm`.

- `git merge`
  - Please use `git cmerge` instead.
    - `git cmerge` is a custom command that merges branches with better commit message.

- `pip`, `pip3`
  - Please use `uv pip`, unless the project specifically requires `pip` or `pip3`.
    - if you need to create a virtual environment, please use `uv venv __gi_ai_venv` to create a virtual environment.

# Flows

- You can create your memos in `__gi_codex_memo.md`.
  - You may use it for:
    - Keep API responses so that you can refer to them later, even if you're restarted
    - Any other temporary memos that you want to keep

  - You should create checklist in the memo file, and check them off as you complete the tasks.
  - You should save the direction in the memo file, so that you can refer to it later.
    - When you're told "continue", you should check the memo file first to see what you need to do next.
- Please read the memo file before starting your work.
- Please run the formatter before `git add` and `git commit`.
  - Use the formatter specified in the project's documentation.
  - Some projects include a formatter in linter, please check the linter configuration file.
- Please respond in Japanese, even though the instructions are in English.
