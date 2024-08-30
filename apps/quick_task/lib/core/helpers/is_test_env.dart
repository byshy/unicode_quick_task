import 'dart:io';

bool get isRunningInTest {
  // Check if the `FLUTTER_TEST` environment variable is set, which indicates a test environment

  return Platform.environment.containsKey('FLUTTER_TEST');
}