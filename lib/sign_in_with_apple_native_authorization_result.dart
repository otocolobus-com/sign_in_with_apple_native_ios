class SignInWithAppleNativeAuthorizationResult {
  final String user;

  SignInWithAppleNativeAuthorizationResult._(
    this.user,
  );

  static SignInWithAppleNativeAuthorizationResult fromMap(Map map) {
    if (!map.containsKey('user')) {
      throw Exception('Invalid authorization result: missing user');
    }

    return SignInWithAppleNativeAuthorizationResult._(map['user']);
  }
}
