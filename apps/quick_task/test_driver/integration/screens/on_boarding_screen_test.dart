import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picasso/models/config.dart';
import 'package:quick_task/di/injection_container.dart';

class OnBoardingScreenTest {
  late WidgetTester tester;

  OnBoardingScreenTest(this.tester);

  final nextButton = find.byKey(const ValueKey('on_boarding_next_button'));

  Future<void> passOnBoarding() async {
    await tester.tap(nextButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.tap(nextButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.tap(nextButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    if (sl<Config>().domain!.isPro) {
      await tester.tap(nextButton, warnIfMissed: true);
      await tester.pumpAndSettle();
    }
  }

  Future<bool> isNextButtonPresent() async {
    return tester.any(nextButton);
  }
}