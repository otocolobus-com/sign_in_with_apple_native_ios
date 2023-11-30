import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_platform_interface.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

class MockSignInWithAppleNativePlatform
    with MockPlatformInterfaceMixin
    implements SignInWithAppleNativePlatform {
  @override
  Stream<CredentialState> get onAuthenticationRevoked {
    throw UnimplementedError(
        'onAuthenticationRevoked has not been implemented.');
  }

  @override
  Future<bool> isAvailable() => Future.value(true);

  @override
  Future<Map> authorize() => Future.value({});

  @override
  Future<CredentialState> get credentialState =>
      Future.value(CredentialState.notFound);
}

void main() {
  final SignInWithAppleNativePlatform initialPlatform =
      SignInWithAppleNativePlatform.instance;

  test('$MethodChannelSignInWithAppleNative is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSignInWithAppleNative>());
  });

  test('isAvailable', () async {
    SignInWithAppleNative signInWithAppleNativePlugin = SignInWithAppleNative();
    MockSignInWithAppleNativePlatform fakePlatform =
        MockSignInWithAppleNativePlatform();
    SignInWithAppleNativePlatform.instance = fakePlatform;

    expect(await signInWithAppleNativePlugin.isAvailable(), true);
  });
}
