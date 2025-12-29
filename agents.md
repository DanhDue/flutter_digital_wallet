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

# Flutter Settings
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

Activate essential tools. Note that `melos` must be version `2.9.0`.

```bash
dart pub global activate melos 2.9.0
dart pub global activate flutter_gen
dart pub global activate get_cli
dart pub global activate flutterfire_cli
```

### Step 7: Project Setup

Install project dependencies. Also verify `melos` configuration by running
`genAlls`.

```bash
# Fix Melos SDK path issue if needed
mkdir -p .fvm
ln -sf $FLUTTER_ROOT .fvm/flutter_sdk

fvm flutter pub get

# Verify setup
melos run genAlls
```

---

# II. Toolchain Checklist

1. **Android Studio**: Download from the official website and install the
   Android SDK and Command-line Tools.
2. **Flutter Doctor**: Run `fvm flutter doctor` to verify your setup.

> [!NOTE]
> iOS development and builds are not supported on Linux. This setup is
> primarily for Android and Web/Desktop development.

---

# III. UI & Localization Guide

This section explains how to manage UI elements and localization in the project.

## 1. Flow to add colors

1. **Add colors to colors.xml**:
   Open `assets/colors/colors.xml` and add your new color:
   ```xml
   <color name="your_color_name">#HEX_CODE</color>
   ```

2. **Add colors to app_theme**:
   Open `lib/styles/app_themes.dart`, add the field to `AppThemes` class, and provide values for all themes(`lightAppThemes`, `darkAppThemes`,...). Note: this project uses `theme_tailor`.

3. **Generate essential contents**:
   Run the following command to trigger `flutter_gen` and `theme_tailor` generation:
   ```bash
   melos run genAlls
   ```

4. **Apply to UI via context**:
   Access the color in your widgets using:
   ```dart
   context.appThemes.yourColorName
   ```

## 2. Flow to add localization texts

1. **Add to JSON files**:
   Add your key-value pair to `assets/locales/en_US.json` and `assets/locales/vn_VI.json` (ensure it's above the `eof` key).

2. **Generate with melos**:
   Run the following command to update the localization strings:
   ```bash
   melos run genAlls
   ```

3. **Apply to UI Text**:
   Import `package:d3_wallet/generated/locales.g.dart` and use the `LocaleKeys` constant with the `.tr` extension:
   ```dart
   LocaleKeys.yourKey.tr
   ```
