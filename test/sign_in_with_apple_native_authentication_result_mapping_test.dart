import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple_native/types/authorization_scope.dart';
import 'package:sign_in_with_apple_native/types/sign_in_with_apple_native_authentication_result.dart';

void main() {
  test('should map id property', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
    });

    expect(result.id, "test");
  });

  test('should throw if id property is missing', () {
    expect(() => SignInWithAppleNativeAuthenticationResult.fromMap({}),
        throwsException);
  });

  test('should map idToken property when not null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap(
        {"id": "test", "idToken": "idToken"});

    expect(result.idToken, "idToken");
  });

  test('should map idToken property when null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "idToken": null,
    });

    expect(result.idToken, null);
  });

  test('should map email property when not null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "email": "email",
    });

    expect(result.email, "email");
  });

  test('should map email property when null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "email": null,
    });

    expect(result.email, null);
  });

  test('should map fullName property when not null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "fullName": {
        "givenName": "givenName",
        "middleName": "middleName",
        "familyName": "familyName",
        "namePrefix": "namePrefix",
        "nameSuffix": "nameSuffix",
        "nickname": "nickname",
      },
    });

    expect(result.fullName!.givenName, "givenName");
    expect(result.fullName!.middleName, "middleName");
    expect(result.fullName!.familyName, "familyName");
    expect(result.fullName!.prefix, "namePrefix");
    expect(result.fullName!.suffix, "nameSuffix");
    expect(result.fullName!.nickname, "nickname");
  });

  test('should map fullName property when any sub-properties are null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "fullName": {
        "givenName": null,
        "middleName": null,
        "familyName": null,
        "namePrefix": null,
        "nameSuffix": null,
        "nickname": null,
      },
    });

    expect(result.fullName!.givenName, null);
    expect(result.fullName!.middleName, null);
    expect(result.fullName!.familyName, null);
    expect(result.fullName!.prefix, null);
    expect(result.fullName!.suffix, null);
    expect(result.fullName!.nickname, null);
  });

  test('should map fullName property when null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "fullName": null,
    });

    expect(result.fullName, null);
  });

  test('should map authorizedScopes property when not null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "authorizedScopes": ["fullName", "email"],
    });

    expect(result.authorizedScopes!.length, 2);
    expect(result.authorizedScopes!.first, AuthorizationScope.fullName);
    expect(result.authorizedScopes!.last, AuthorizationScope.email);
  });

  test('should throw exception if authorizedScopes property is invalid', () {
    expect(
        () => SignInWithAppleNativeAuthenticationResult.fromMap({
              "id": "test",
              "authorizedScopes": ["invalid"],
            }).authorizedScopes!, // enumerate iterable to force evaluation
        throwsException);
  });

  test('should map authorizedScopes property when null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "authorizedScopes": null,
    });

    expect(result.authorizedScopes, null);
  });

  test('should map authorizationCode property', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "authorizationCode": "authorizationCode",
    });

    expect(result.authorizationCode, "authorizationCode");
  });

  test('should map authorizationCode property when null', () {
    final result = SignInWithAppleNativeAuthenticationResult.fromMap({
      "id": "test",
      "authorizationCode": null,
    });

    expect(result.authorizationCode, null);
  });
}
