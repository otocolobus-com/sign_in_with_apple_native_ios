import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
import 'package:sign_in_with_apple_native/types/authorization_scope.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';
import 'package:sign_in_with_apple_native/types/sign_in_with_apple_native_authentication_result.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSignInWithAppleNativePlatformWithEmptyAuthResult
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
  Future<Map> authorize({Iterable<AuthorizationScope>? requestedScopes}) =>
      Future.value({});

  @override
  Future<CredentialState> get credentialState =>
      Future.value(CredentialState.notFound);
}

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
  Future<Map> authorize({Iterable<AuthorizationScope>? requestedScopes}) =>
      Future.value({
        "id": "test",
      });

  @override
  Future<CredentialState> get credentialState =>
      Future.value(CredentialState.notFound);
}

void main() {
  test('authorize throws exception if authorization result is missing user',
      () async {
    SignInWithAppleNative signInWithAppleNativePlugin = SignInWithAppleNative();
    MockSignInWithAppleNativePlatformWithEmptyAuthResult fakePlatform =
        MockSignInWithAppleNativePlatformWithEmptyAuthResult();
    SignInWithAppleNativePlatform.instance = fakePlatform;

    expect(() => signInWithAppleNativePlugin.authorize(), throwsException);
  });

  test('authorize returns authorization result', () async {
    SignInWithAppleNative signInWithAppleNativePlugin = SignInWithAppleNative();
    MockSignInWithAppleNativePlatform fakePlatform =
        MockSignInWithAppleNativePlatform();
    SignInWithAppleNativePlatform.instance = fakePlatform;

    final result = await signInWithAppleNativePlugin.authorize();
    expect(result, isInstanceOf<SignInWithAppleNativeAuthenticationResult>());
    expect(result.id, "test");
  });
}
