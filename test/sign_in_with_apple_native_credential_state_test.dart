import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_platform_interface.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

class MockSignInWithAppleNativePlatform
    with MockPlatformInterfaceMixin
    implements SignInWithAppleNativePlatform {
  @override
  Future<bool> isAvailable() => Future.value(true);

  @override
  Future<Map> authorize() => Future.value({});

  @override
  Future<CredentialState> get credentialState =>
      Future.value(CredentialState.authorized);
}

void main() {
  test('should bypass value', () async {
    SignInWithAppleNative signInWithAppleNativePlugin = SignInWithAppleNative();
    MockSignInWithAppleNativePlatform fakePlatform =
        MockSignInWithAppleNativePlatform();
    SignInWithAppleNativePlatform.instance = fakePlatform;

    expect(
      await signInWithAppleNativePlugin.credentialState,
      CredentialState.authorized,
    );
  });
}
