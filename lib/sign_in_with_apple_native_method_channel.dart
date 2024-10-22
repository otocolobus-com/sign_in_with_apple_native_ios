import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple_native/types/authorization_scope.dart';
import 'package:sign_in_with_apple_native/types/credential_state.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

class MethodChannelSignInWithAppleNative extends SignInWithAppleNativePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('SignInWithAppleNative');

  final revokedAuthenticationEventChannel =
      const EventChannel('SignInWithAppleNativeRevokedAuthentication');

  @override
  Stream<CredentialState> get onAuthenticationRevoked {
    return revokedAuthenticationEventChannel
        .receiveBroadcastStream()
        .map((event) {
      if (event is int) {
        return CredentialState.values.firstWhere(
          (element) => element.value == event,
          orElse: () {
            throw Exception("Unknown credential state");
          },
        );
      } else {
        throw Exception("Unknown event type");
      }
    });
  }

  @override
  Future<bool> isAvailable() async {
    final isAvailable = await methodChannel.invokeMethod<bool>('isAvailable');
    return isAvailable ?? false;
  }

  @override
  Future<Map> authorize({Iterable<AuthorizationScope>? requestedScopes}) async {
    final result = await methodChannel.invokeMapMethod<String, dynamic>(
          'authorize',
          {
            'requestedScopes':
                requestedScopes?.map((e) => e.value).toList() ?? [],
          },
        ) ??
        {};

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

  @override
  Future<CredentialState> get credentialState async {
    final result = await methodChannel.invokeMethod<int>("getState") ??
        CredentialState.notFound.value;
    return CredentialState.values.firstWhere(
      (element) => element.value == result,
      orElse: () {
        throw Exception("Unknown credential state");
      },
    );
  }
}
