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

    if (result.keys.isEmpty || result.containsKey("error")) {
      throw Exception(result["error"]);
    }

    return result["credential"] ?? {};
  }
}
