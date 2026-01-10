#!/bin/bash
set -e

fvm dart run build_runner build -d
fluttergen -c pubspec.yaml
get generate locales assets/locales

# Call scripts directly instead of via melos to avoid nested progress reporter issues
bash ./scripts/dartfmt.sh
bash ./scripts/add_header_ignore_flags.sh
bash ./scripts/add_license_header.sh
bash ./scripts/check_license_header.sh

git add .

echo -e "\033[0;32m✓ All generation and license tasks completed successfully!\033[0m"
