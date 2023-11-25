import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

class MethodChannelSignInWithAppleNative extends SignInWithAppleNativePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('SignInWithAppleNative');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> isAvailable() async {
    final isAvailable = await methodChannel.invokeMethod<bool>('isAvailable');
    return isAvailable ?? false;
  }
}
