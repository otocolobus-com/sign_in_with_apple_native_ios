import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_platform_interface.dart';
import 'package:sign_in_with_apple_native/sign_in_with_apple_native_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSignInWithAppleNativePlatform
    with MockPlatformInterfaceMixin
    implements SignInWithAppleNativePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SignInWithAppleNativePlatform initialPlatform = SignInWithAppleNativePlatform.instance;

  test('$MethodChannelSignInWithAppleNative is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSignInWithAppleNative>());
  });

  test('getPlatformVersion', () async {
    SignInWithAppleNative signInWithAppleNativePlugin = SignInWithAppleNative();
    MockSignInWithAppleNativePlatform fakePlatform = MockSignInWithAppleNativePlatform();
    SignInWithAppleNativePlatform.instance = fakePlatform;

    expect(await signInWithAppleNativePlugin.getPlatformVersion(), '42');
  });
}
