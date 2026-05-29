[中文](CONTRIBUTING.md) | [English](CONTRIBUTING.en.md)

This is the extension plugin contribution guide for SCU Beamer Theme. For the general contribution guide, see [#13](https://github.com/FvNCCR228/SCU-Beamer-Theme/discussions/13).

## SCU Beamer Theme Extension Plugin Contribution Guide

### Plugin System Overview

SCU Beamer Theme supports loading extension themes through a plugin mechanism.
Refer to [#12](https://github.com/FvNCCR228/SCU-Beamer-Theme/discussions/12) for guidance on defining SCU Beamer Theme extension plugins. Once your plugin information is merged into this project's GitHub repository, users can download and install plugins with one click using `docs/install-plugin.sh` (Linux/MacOS) or `docs/install-plugin.bat` (Windows).

### Prerequisites

1. You need to create a public GitHub repository to host your extension plugin files
2. You can customize plugin-related files (e.g. `.sty`, `.tex`, `.pdf`, `.png`, etc.) and upload standalone minimal examples and documentation independent of SCU Beamer Theme. Please try to avoid file naming conflicts with the SCU Beamer Theme project. To avoid duplicate files with other plugins, you can create a second-level folder, e.g. `resources/mytheme/image.png`
3. Plugin names must not duplicate existing ones. Check with:

  Linux/MacOS:
  ```bash
  ./docs/install-plugin.sh -l
  ```

  Windows:
  ```cmd
  .\docs\install-plugin.bat -l
  ```

4. Please ensure that the copyright of all related files is clear, or that you have obtained legal authorization. This project is not responsible for any issues arising from copyright disputes.

---

### Plugin Configuration Format

In `docs/dev/plugins.conf`, each plugin is defined as an INI-style configuration block:

```ini
# Plugin: <Display Name> - <Plugin Identifier>
[plugin-name]
repo = GitHubUsername/Repository
branch = BranchName
files = file1 file2 file3
name = Display Name
```

#### Field Descriptions

| Field | Description | Example |
|-------|-------------|---------|
| `repo` | Repository address in `user/repo` format | `FvNCCR228/SCU-Beamer-Theme` |
| `branch` | Branch name | `main` |
| `files` | List of files to download (avoid spaces in filenames), space-separated, list all files in subdirectories | `theme.sty slides.tex resources/image.png` |
| `name` | Plugin display name | `My Custom Theme` |

#### Complete Example

Suppose your GitHub username is `ZhangSan`, your repository is `my-beamer-theme`, the branch is `main`, and you need to provide `mytheme.sty`, `demo.tex`, and `resources/mytheme.png`:

```ini
# Plugin: ZhangSan Custom Theme - zhangsan-theme
[zhangsan-theme]
repo = ZhangSan/my-beamer-theme
branch = main
files = mytheme.sty demo.tex resources/mytheme.png
name = ZhangSan Custom Theme
```

#### File Requirements

1. File paths must match the actual paths in your repository. The script downloads files based on these paths, otherwise files will be missing
2. Avoid spaces in filenames. Use `_` or `-` instead
3. Subdirectories are created automatically during download. For example, `resources/mytheme.png` is valid
4. It is recommended to include a `README.md` in your repository explaining the plugin's purpose and usage
5. Do not commit build artifacts (`.aux`, `.log`, `.synctex.gz`, etc.) in your plugin repository. Refer to the `.gitignore` in the project root

---

### Submission Process

1. Fork this repository, add your plugin entry in `docs/dev/plugins.conf`, then submit a Pull Request
2. PRs must pass review before becoming official plugins. You will also become a contributor to this repository

#### Testing Your Plugin

Before submitting a PR, please complete the following tests locally

Linux/MacOS:
```bash
# 1. List all plugins, confirm your plugin appears in the list
./docs/install-plugin.sh -l

# 2. Search for your plugin by name
./docs/install-plugin.sh -s <your-plugin-name>

# 3. Installation test (recommended to operate in a temporary directory)
./docs/install-plugin.sh -e <your-plugin-name>

# 4. Confirm files are correctly downloaded to the project root and compilation succeeds
```

Windows:
```cmd
:: 1. List all plugins, confirm your plugin appears in the list
.\docs\install-plugin.bat -l

:: 2. Search for your plugin by name
.\docs\install-plugin.bat -s <your-plugin-name>

:: 3. Installation test (recommended to operate in a temporary directory)
.\docs\install-plugin.bat -e <your-plugin-name>

:: 4. Confirm files are correctly downloaded to the project root and compilation succeeds
```

#### PR Guidelines

- Title format: `plugin: Add <Display Name> - <Plugin Name>` (e.g. `plugin: Add ZhangSan Custom Theme - ZhangSanTheme`)
- PR description must include:
  1. Plugin repository link
  2. Corresponding extension theme package name (e.g. `extension-ZhangSan.sty`)
  3. Brief description and preview screenshot of the plugin (if available)
  4. Confirmation of local test results

---

### FAQ

**Q: My repository is private. Can I submit a plugin?**
A: No. Plugins must be hosted in public repositories, otherwise other users cannot download them.

**Q: Can a plugin contain multiple files?**
A: Yes. Use spaces to separate multiple file paths in the `files` field.

**Q: Do I need to re-submit a PR after updating plugin files?**
A: No. As long as the file paths remain unchanged and are on the same branch, the script will automatically download the latest version. If you need to add new files or change the branch, you will need to update the PR.
