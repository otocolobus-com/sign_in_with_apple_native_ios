import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

class MethodChannelSignInWithAppleNative extends SignInWithAppleNativePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('SignInWithAppleNative');

  @override
  Future<bool> isAvailable() async {
    final isAvailable = await methodChannel.invokeMethod<bool>('isAvailable');
    return isAvailable ?? false;
  }

  @override
  Future<Map> authorize() async {
    final result =
        await methodChannel.invokeMapMethod<String, dynamic>('authorize') ?? {};

    if (result.keys.isEmpty || !result.containsKey("isSuccess")) {
      throw Exception("Result is empty");
    }

    if (result["isSuccess"] == false) {
      throw Exception(result["error"]);
    }

    if (!result.containsKey("credential")) {
      throw Exception("Result does not contain credential");
    }

    return result["credential"];
  }
}
