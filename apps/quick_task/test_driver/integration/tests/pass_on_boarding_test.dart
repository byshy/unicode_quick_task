import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:quick_task/main.dart' as quick_task;

import '../screens/on_boarding_screen_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('OnBoarding test', () {
    testWidgets(
      'Pass onBoarding',
      (WidgetTester tester) async {
        quick_task.main();
        await tester.pump(const Duration(seconds: 5));

        final onBoardingScreen = OnBoardingScreenTest(tester);

        await onBoardingScreen.passOnBoarding();

        final isNextButtonPresent = await onBoardingScreen.isNextButtonPresent();
        expect(isNextButtonPresent, false, reason: 'Expected onboarding should be passed and the next button is gone');
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
