import 'package:sign_in_with_apple_native/types/authorization_scope.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';
import 'package:sign_in_with_apple_native/types/sign_in_with_apple_native_authentication_result.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

class SignInWithAppleNative {
  Stream<CredentialState> get onAuthenticationRevoked {
    return SignInWithAppleNativePlatform.instance.onAuthenticationRevoked;
  }

  Future<bool> isAvailable() {
    return SignInWithAppleNativePlatform.instance.isAvailable();
  }

  Future<SignInWithAppleNativeAuthenticationResult> authorize({
    Iterable<AuthorizationScope>? requestedScopes,
  }) async {
    final result = await SignInWithAppleNativePlatform.instance.authorize(
      requestedScopes: requestedScopes,
    );

    return SignInWithAppleNativeAuthenticationResult.fromMap(result);
  }

  Future<CredentialState> get credentialState async {
    return SignInWithAppleNativePlatform.instance.credentialState;
  }
}
