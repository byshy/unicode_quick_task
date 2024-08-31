#!/bin/bash

# Set BASE_DIR to the directory where the script was run from
BASE_DIR="$(pwd)"

# Define the commands to run
pubGetCommand="flutter pub get"
intlGenCommand="flutter --no-color pub global run intl_utils:generate"
mockGenCommand="dart run build_runner build --delete-conflicting-outputs"

# Check if BASE_DIR is a valid directory
if [ ! -d "$BASE_DIR" ]; then
  echo "Error: $BASE_DIR is not a valid directory."
  exit 1
fi

# Function to check if `flutter_intl` tag is present in pubspec.yaml
check_flutter_intl_tag() {
  local pubspec_file="$1/pubspec.yaml"
  if grep -q 'flutter_intl:' "$pubspec_file"; then
    return 0  # Tag found
  else
    return 1  # Tag not found
  fi
}

# Function to check if `build_runner` is present in dev_dependencies
check_build_runner() {
  local pubspec_file="$1/pubspec.yaml"
  if grep -q -E '^  build_runner:' "$pubspec_file"; then
    return 0  # build_runner found in dev_dependencies
  else
    return 1  # build_runner not found in dev_dependencies
  fi
}

# Function to process directories
process_directories() {
  local path=$1
  for SUB_DIR in "$path"/*/; do
    if [ -d "$SUB_DIR" ]; then
      echo "Entering directory: $SUB_DIR"
      cd "$SUB_DIR" || { echo "Failed to enter directory $SUB_DIR"; continue; }

      # Run pub get command
      echo "Running pubGetCommand in $SUB_DIR"
      eval "$pubGetCommand"

      # Check for flutter_intl tag and run intlGenCommand if present
      if check_flutter_intl_tag "$SUB_DIR"; then
        echo "flutter_intl tag found in $SUB_DIR"
        echo "Running intlGenCommand in $SUB_DIR"
        eval "$intlGenCommand"
      else
        echo "flutter_intl tag not found in $SUB_DIR"
      fi

      # Check for build_runner and run mockGenCommand if present
      if check_build_runner "$SUB_DIR"; then
        echo "build_runner found in dev_dependencies in $SUB_DIR"
        echo "Running mockGenCommand in $SUB_DIR"
        eval "$mockGenCommand"
      else
        echo "build_runner not found in dev_dependencies in $SUB_DIR"
      fi

      # Return to the base directory
      cd "$BASE_DIR" || { echo "Failed to return to base directory"; exit 1; }
    fi
  done
}

# Process apps and sdk subdirectories
process_directories "$BASE_DIR/apps"
process_directories "$BASE_DIR/sdk"

echo "Finished processing all subdirectories."
