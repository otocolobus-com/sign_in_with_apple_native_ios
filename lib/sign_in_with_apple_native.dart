import 'package:sign_in_with_apple_native/types/sign_in_with_apple_native_authentication_result.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

class SignInWithAppleNative {
  Future<bool> isAvailable() {
    return SignInWithAppleNativePlatform.instance.isAvailable();
  }

  Future<SignInWithAppleNativeAuthenticationResult> authorize() async {
    final result = await SignInWithAppleNativePlatform.instance.authorize();

    return SignInWithAppleNativeAuthenticationResult.fromMap(result);
  }
}
