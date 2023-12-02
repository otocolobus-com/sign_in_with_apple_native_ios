import 'package:sign_in_with_apple_native/types/authorization_scope.dart';
import 'package:sign_in_with_apple_native/types/person_name_components.dart';

class SignInWithAppleNativeAuthenticationResult {
  final String id;
  String? idToken;
  String? email;
  PersonNameComponents? fullName;
  Iterable<AuthorizationScope>? authorizedScopes;
  String? authorizationCode;

  SignInWithAppleNativeAuthenticationResult._(
    this.id, {
    this.idToken,
    this.email,
    this.fullName,
    this.authorizedScopes,
    this.authorizationCode,
  });

  static SignInWithAppleNativeAuthenticationResult fromMap(Map map) {
    if (!map.containsKey('id')) {
      throw Exception('Invalid authorization result: missing id');
    }

    return SignInWithAppleNativeAuthenticationResult._(
      map['id'],
      idToken: map['idToken'],
      email: map['email'],
      fullName: map['fullName'] != null
          ? PersonNameComponents.fromMap(map['fullName'])
          : null,
      authorizedScopes: map['authorizedScopes'] != null
          ? (map['authorizedScopes'] as List).map(
              (e) => AuthorizationScope.values.firstWhere(
                (element) => element.value == e,
                orElse: () => throw Exception(
                  'Invalid authorization result: unknown scope $e',
                ),
              ),
            )
          : null,
      authorizationCode: map['authorizationCode'],
    );
  }
}
