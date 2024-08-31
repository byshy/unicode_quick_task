import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:quick_task/main.dart' as quick_task;

import '../screens/home_screen_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  String title = 'Integration test';

  group('Home test', () {
    testWidgets(
      'Delete added TODO',
      (WidgetTester tester) async {
        quick_task.main();
        await tester.pump(const Duration(seconds: 5));

        final homeScreen = HomeScreenTest(tester);

        await homeScreen.deleteTODO(title);

        final isTodoDeleted = await homeScreen.isTodoAbsent(title);
        expect(isTodoDeleted, true, reason: 'Expected TODO should be deleted and it should reflect on TODO Home Screen');
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
