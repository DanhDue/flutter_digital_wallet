# I. Environment Setup

This guide explains how to set up the development environment on a Linux machine (e.g., Ubuntu/Debian).

## 1. System Dependencies

Before installing Flutter, ensure you have the necessary system tools and libraries.
You must enable 32-bit architecture and install specific libraries:

```bash
sudo apt-get upgrade
sudo apt-get install build-essential procps curl file git
```

## 2. Installation Steps

### Step 1: Install Homebrew (Linuxbrew)
Homebrew is used to manage several tools in this project.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
fvm install 3.38.5
fvm global 3.38.5
```

### Step 4: Install Go and Tools

Install Go and the license tool:

```bash
brew install go
go install github.com/google/addlicense@latest
```

### Step 5: Environment Variables

Run the following command to add all necessary environment variables to your `~/.bashrc`. This command handles Homebrew, FVM/Flutter, Go, and Android SDK settings in one block.

```bash
cat << 'EOF' >> ~/.bashrc

# Wallet Environment Setup
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Flutter & FVM
export PATH="$HOME/fvm/versions/3.38.5/bin:$PATH"
export FLUTTER_ROOT="$HOME/fvm/versions/3.38.5"
export PATH="$FLUTTER_ROOT/bin:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"

# Ruby/Gem
export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
EOF
```

Apply changes:

```bash
source ~/.bashrc
```

#### Verification
To confirm your environment is set up correctly, run:
```bash
which brew && which fvm
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
melos genAlls
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

**Note**: this project uses `theme_tailor` and `flutter_gen` to generate some UI elements. So you don't need to update generated files that I marked in gitignore such as: `lib/generated` folder, `*.freezed.dart`, `*.tailor.dart`, `/secureFiles`, `*/fastlane/report.xml`, `/lib/generated/`,... .

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
   melos genAlls
   ```

4. **Apply to UI via context**:
   Access the color in your widgets using:
   ```dart
   context.theme.yourColorName
   ```

## 2. Flow to add localization texts

1. **Add to JSON files**:
   Add your key-value pair to `assets/locales/en_US.json` and `assets/locales/vn_VI.json` (ensure it's above the `eof` key).

2. **Generate with melos**:
   Run the following command to update the localization strings:
   ```bash
   melos genAlls
   ```

3. **Apply to UI Text**:
   Import `package:d3_wallet/generated/locales.g.dart` and use the `LocaleKeys` constant with the `.tr` extension:
   ```dart
   LocaleKeys.yourKey.tr
   ```


## 3. Post-edit Workflow
After making changes to the codebase, especially to `colors.xml`, `locales.json`, or any files that require code generation, follow these steps to ensure consistency and code quality.

1. **Synchronize Generated Files**
Run `melos run genAlls` to trigger all necessary code generation (locales, colors, models, themes, etc.). This ensures that all generated constants and classes are up to date.

    ```bash
    melos genAlls
    ```

2. **Static Analysis**
Verify your changes by running static analysis. This helps catch syntax errors, type mismatches, and lint warnings.

    For a faster check on only the files you've edited, you can run the analyzer on specific paths:

    ```bash
    fvm flutter analyze lib/path/to/your_file.dart
    ```
