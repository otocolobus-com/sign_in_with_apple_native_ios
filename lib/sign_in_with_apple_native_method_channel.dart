import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

/// An implementation of [SignInWithAppleNativePlatform] that uses method channels.
class MethodChannelSignInWithAppleNative extends SignInWithAppleNativePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sign_in_with_apple_native');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
