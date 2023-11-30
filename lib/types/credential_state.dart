enum CredentialState {
  revoked(0),
  authorized(1),
  notFound(2),
  transferred(3);

  const CredentialState(this.value);
  final int value;
}
