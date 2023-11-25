import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sign_in_with_apple_native_method_channel.dart';

abstract class SignInWithAppleNativePlatform extends PlatformInterface {
  /// Constructs a SignInWithAppleNativePlatform.
  SignInWithAppleNativePlatform() : super(token: _token);

  static final Object _token = Object();

  static SignInWithAppleNativePlatform _instance = MethodChannelSignInWithAppleNative();

  /// The default instance of [SignInWithAppleNativePlatform] to use.
  ///
  /// Defaults to [MethodChannelSignInWithAppleNative].
  static SignInWithAppleNativePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SignInWithAppleNativePlatform] when
  /// they register themselves.
  static set instance(SignInWithAppleNativePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
