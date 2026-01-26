# Dev Dotfiles

My development environment configuration files for Kitty terminal, VS Code IDE, and Zsh shell.

**Repository**: [https://github.com/Michael-Matta1/dev-dotfiles](https://github.com/Michael-Matta1/dev-dotfiles)

## Contents

This repository includes configuration files for:

- **Kitty Terminal** (`kitty.conf`) - Terminal emulator
- **VS Code** (`vscode/settings.json` and `vscode/keybindings.json`) - IDE settings and functional keybindings
- **Zsh Shell** (`.zshrc`) - Shell configuration with plugins and customizations

## Configuration Overview

### Kitty Terminal (`kitty.conf`)

The Kitty configuration is designed to provide seamless Zsh integration, working cooperatively with the [zsh-edit-select](https://github.com/Michael-Matta1/zsh-edit-select) plugin, zsh-autosuggestions, and `.zshrc` configurations. The keybindings are carefully orchestrated to avoid conflicts between terminal-level and shell-level bindings, ensuring a smooth editing experience.

### VS Code (`vscode/settings.json` and `vscode/keybindings.json`)

The VS Code configuration includes functional settings and keybindings that may benefit other users. The `keybindings.json` file contains functional configurations (such as terminal integration bindings and overriding tab navigation to match browser behavior) rather than personal preference keybindings, as keybindings themselves are inherently personal preferences.

**Note**: Some settings in `settings.json` are explicitly set even though they match VS Code defaults. This ensures consistent behavior when importing to VS Code-based IDEs (like Cursor or Windsurf) that may override these defaults.

**Location**: These configuration files should be placed in:
> - Mac ~/Library/Application Support/Code/User/
> - Linux ~/.config/Code/User/
> - Windows %APPDATA%\Code\User\


### Zsh Shell (`.zshrc`)

The Zsh configuration provides a comprehensive setup with modern plugins, enhanced completions, and productivity-focused aliases and functions. It integrates with various CLI tools to provide a better shell experience.

## Important Notes

### Placeholder Replacement

**All configuration files contain placeholders that must be replaced with your own values:**

- `<path_to_your_kitty_background_image>` - Path to your Kitty background image (in `kitty.conf`)
- `<path_to_your_flake8_config_file>` - Path to your flake8 configuration file (in `vscode/settings.json`)
- `<path_to_your_shfmt_binary>` - Path to your shfmt binary (in `vscode/settings.json`)

These placeholders are marked with angle brackets `<...>` for easy identification. Search for them in the configuration files and replace them with appropriate values for your system, or remove the lines if you don't need those features.

### Zsh Configuration

The `.zshrc` file is provided as a reference of settings that I've found helpful. Feel free to cherry-pick the configurations (aliases, functions, options, etc.) that would be useful for your own setup and integrate them into your existing Zsh configuration files.

### VS Code Extensions List

A list of VS Code extensions I use is included as a bonus reference in `vsc-extensions.txt`. Most of them are deactivated, and I activate them as needed or just keep them there for reference.

## Dependencies

These configurations rely on various tools, plugins, and extensions. Below is a comprehensive list:

### Zsh Framework & Theme

- **Oh My Zsh** - Framework for managing Zsh configuration
- **Powerlevel10k** - Zsh theme with instant prompt

### Zsh Plugins

- **zsh-edit-select** - [https://github.com/Michael-Matta1/zsh-edit-select](https://github.com/Michael-Matta1/zsh-edit-select) - Text selection and clipboard integration in ZLE
- **zsh-completions** - Additional completion definitions
- **fzf-tab** - Enhanced tab completion using FZF
- **zsh-autosuggestions** - Fish-like autosuggestions (system package)
- **zsh-syntax-highlighting** - Command syntax highlighting (system package)

### Shell History & Command Tools

- **Atuin** - Better shell history with sync and search
- **thefuck** - Command correction tool
- **FZF** - Fuzzy finder for command-line

### Modern CLI Tools

- **eza** - Modern replacement for `ls`
- **bat** / **batcat** - Modern replacement for `cat` with syntax highlighting
- **ripgrep** (rg) - Fast text search tool
- **fdfind** (fd) - Fast alternative to `find`
- **zoxide** - Smart directory jumper
- **dust** - Modern replacement for `du`
- **htop** - Interactive process viewer

### System Utilities

- **xclip** - X11 clipboard utility

### Python Development Tools

- **flake8** - Python linter
- **isort** - Python import sorter
- **Black** - Python code formatter

### Terminal & Shell

- **Kitty Terminal** - GPU-accelerated terminal emulator
- **Zsh** - Z shell
- **shfmt** - Shell formatter (optional)

## Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) - Framework for managing Zsh configuration
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/) - GPU-accelerated terminal emulator
- [VS Code](https://code.visualstudio.com/) - Code editor
- All the plugin and tool developers who make these configurations possible

---

**Remember**: These configurations are reference implementations meant to inspire your own setup. Customize them to fit your workflow and preferences!
