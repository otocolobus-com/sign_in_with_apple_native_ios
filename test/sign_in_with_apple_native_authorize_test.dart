import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_authorization_result.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSignInWithAppleNativePlatformWithEmptyAuthResult
    with MockPlatformInterfaceMixin
    implements SignInWithAppleNativePlatform {
  @override
  Future<bool> isAvailable() => Future.value(true);

  @override
  Future<Map> authorize() => Future.value({});
}

class MockSignInWithAppleNativePlatform
    with MockPlatformInterfaceMixin
    implements SignInWithAppleNativePlatform {
  @override
  Future<bool> isAvailable() => Future.value(true);

  @override
  Future<Map> authorize() => Future.value({
        "user": "test",
      });
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
    expect(result, isInstanceOf<SignInWithAppleNativeAuthorizationResult>());
    expect(result.user, "test");
  });
}
