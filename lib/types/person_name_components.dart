class PersonNameComponents {
  final String? givenName;
  final String? familyName;
  final String? middleName;
  final String? prefix;
  final String? suffix;
  final String? nickname;
  final String? description;

  PersonNameComponents._({
    this.givenName,
    this.familyName,
    this.middleName,
    this.prefix,
    this.suffix,
    this.nickname,
    this.description,
  });

  static PersonNameComponents fromMap(Map map) {
    return PersonNameComponents._(
      givenName: map['givenName'],
      familyName: map['familyName'],
      middleName: map['middleName'],
      prefix: map['namePrefix'],
      suffix: map['nameSuffix'],
      nickname: map['nickname'],
      description: map['description'],
    );
  }
}
