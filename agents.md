# I. Environment Setup

This guide explains how to set up the development environment on a Linux machine (e.g., Ubuntu/Debian).

## 1. System Dependencies

Before installing Flutter, ensure you have the necessary system tools and libraries.
You must enable 32-bit architecture and install specific libraries:

```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y curl git unzip xz-utils libglu1-mesa \
    libc6:i386 libncurses6:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 \
    ninja-build build-essential libgtk-3-dev openjdk-17-jdk
```

## 2. Installation Steps

### Step 1: Install Homebrew (Linuxbrew)
Homebrew is used to manage several tools in this project.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to your PATH (adjust for your shell if not using bash)
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(test -d ~/.linuxbrew && echo ~/.linuxbrew/bin/brew || echo /home/linuxbrew/.linuxbrew/bin/brew) shellenv)\"" >> ~/.bashrc
```

### Step 2: Install FVM (Flutter Version Management)
Use Homebrew to install FVM:

```bash
brew tap leoafarias/fvm
brew install fvm
```

### Step 3: Install Flutter SDK via FVM
Install the stable version of Flutter and make it global:

```bash
fvm install stable
fvm global stable
```

**Note:** Ensure the `default` link is created:
```bash
ln -sfFn ~/fvm/versions/stable ~/fvm/default
```

### Step 4: Install Go and Tools
Install Go and the license tool:

```bash
brew install go
go install github.com/google/addlicense@latest
```

### Step 5: Environment Variables
Add the following to your `~/.bashrc` (or `~/.zshrc`):

```bash
# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#Flutter Settings
export PATH=$HOME/fvm/default/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export FLUTTER_ROOT=$HOME/fvm/default
export PATH=$FLUTTER_ROOT/bin:$PATH
export PATH=$PATH:$HOME/.pub-cache/bin

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Android SDK (adjust path if your SDK is installed elsewhere)
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
```

Apply changes:
```bash
source ~/.bashrc
```

### Step 6: Activate Global Dart Packages
Activate essential tools:

```bash
dart pub global activate melos
dart pub global activate flutter_gen
dart pub global activate get_cli
dart pub global activate flutterfire_cli
```

### Step 7: Project Setup
Install project dependencies and git tools:

```bash
fvm flutter pub get
bash ./scripts/install_git_tools.sh
```

## 3. Toolchain Checklist

- **Android Studio**: Download from the official website and install the Android SDK and Command-line Tools.
- **Flutter Doctor**: Run `fvm flutter doctor` to verify your setup.

> [!NOTE]
> iOS development and builds are not supported on Linux. This setup is primarily for Android and Web/Desktop development.
