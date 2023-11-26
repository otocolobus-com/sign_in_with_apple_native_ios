import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('isAvailable test', (WidgetTester tester) async {
    final SignInWithAppleNative plugin = SignInWithAppleNative();
    final bool isAvailable = await plugin.isAvailable();
    expect(isAvailable, true);
  });
}
