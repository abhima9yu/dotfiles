# Dotfiles

Bash config, aliases, and scripts. Set up for **macOS** with **Homebrew**.

## Prerequisites

- macOS
- [Homebrew](https://brew.sh/)

```bash
# Install Homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Dependencies (Homebrew)

Install tools used by these dotfiles and scripts:

```bash
# MacVim (for EDITOR and aliases: ea, ee)
brew install macvim

# Ruby (macOS includes one, or use brew for a specific version)
brew install ruby
```

## Setup

1. **Clone this repo** (if you haven’t already):

   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Link `bashrc`** so your shell sources it:

   ```bash
   echo '[[ -f ~/dotfiles/bashrc ]] && . ~/dotfiles/bashrc' >> ~/.bashrc
   # or, if you use .bash_profile:
   echo '[[ -f ~/dotfiles/bashrc ]] && . ~/dotfiles/bashrc' >> ~/.bash_profile
   ```

3. **Load the config** in the current shell:

   ```bash
   source ~/dotfiles/bashrc
   ```

   Or open a new terminal.

## Scripts (`scripts/`)

All scripts assume **macOS** and **Homebrew**. Run from the dotfiles repo root. Ruby is required (macOS includes it, or `brew install ruby`).

### One-time new Mac setup

```bash
./scripts/setup_new_mac.sh
```

This installs Homebrew, Git, Ruby, rbenv, Rails, Docker, AWS CLI, Heroku CLI, Oh My Zsh, and VS Code, then adds your dotfiles `bashrc` to `~/.zshrc`. If an install step fails, the script continues with the rest.

### Individual scripts

| Script | Purpose | Run command |
|--------|---------|-------------|
| `setup_new_mac.sh` | Run all installs and add bashrc to ~/.zshrc | `./scripts/setup_new_mac.sh` |
| `generate_sshkey.rb` | Generate SSH key pair (ed25519 or RSA) | `ruby scripts/generate_sshkey.rb` |
| `install_brew.rb` | Install Homebrew | `ruby scripts/install_brew.rb` |
| `install_git.rb` | Install Git (brew) | `ruby scripts/install_git.rb` |
| `install_ruby.rb` | Install Ruby (brew) | `ruby scripts/install_ruby.rb` |
| `install_rbenv.rb` | Install rbenv + ruby-build | `ruby scripts/install_rbenv.rb` |
| `install_rails.rb` | Install Rails gem | `ruby scripts/install_rails.rb` |
| `install_docker.rb` | Install Docker Desktop (cask) | `ruby scripts/install_docker.rb` |
| `install_aws.rb` | Install AWS CLI | `ruby scripts/install_aws.rb` |
| `install_heroku.rb` | Install Heroku CLI | `ruby scripts/install_heroku.rb` |
| `install_ohmyzsh.rb` | Install Oh My Zsh | `ruby scripts/install_ohmyzsh.rb` |
| `install_vscode.rb` | Install VS Code (cask) | `ruby scripts/install_vscode.rb` |

**Examples:**

```bash
# Generate default Ed25519 key at ~/.ssh/id_ed25519
ruby scripts/generate_sshkey.rb

# Generate RSA 4096 key with comment
ruby scripts/generate_sshkey.rb -t rsa -b 4096 -C "you@example.com"

# Generate key to a specific path
ruby scripts/generate_sshkey.rb -f ~/.ssh/id_ed25519_work -C "work"

# Install tools (run install_brew.rb first if needed)
ruby scripts/install_brew.rb
ruby scripts/install_git.rb
ruby scripts/install_ruby.rb
ruby scripts/install_docker.rb
```

## Reload aliases

After editing alias files:

```bash
reload
```

Or: `source ~/dotfiles/dotfiles/bash/load_aliases`
