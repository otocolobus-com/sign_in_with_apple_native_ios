import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sign_in_with_apple_native/types/authorization_scope.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

import 'sign_in_with_apple_native_method_channel.dart';

abstract class SignInWithAppleNativePlatform extends PlatformInterface {
  SignInWithAppleNativePlatform() : super(token: _token);

  static final Object _token = Object();

  static SignInWithAppleNativePlatform _instance =
      MethodChannelSignInWithAppleNative();

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

  Stream<CredentialState> get onAuthenticationRevoked {
    throw UnimplementedError(
        'onAuthenticationRevoked has not been implemented.');
  }

  Future<bool> isAvailable() {
    throw UnimplementedError('isAvailable() has not been implemented.');
  }

  Future<Map> authorize({Iterable<AuthorizationScope>? requestedScopes}) {
    throw UnimplementedError('authorize() has not been implemented.');
  }

  Future<CredentialState> get credentialState {
    throw UnimplementedError('credentialState has not been implemented.');
  }
}
