# Usage

The setup script help in quickly
- Running `flutter pub get` in all the flutter projects and packages in this repo
- Generating all translation files needed to run the project
- Generating all mock files for the unit tests

To activate it please run the following command
```
chmod +x scripts/*.bash && ./scripts/setup.bash 
```

Note: Please make sure to activate intl_utils package globally before running the script
```
flutter pub global activate intl_utils
```