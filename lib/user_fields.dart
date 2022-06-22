class UserFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String email = 'email';
  static final String isBeginner = 'isBeginner';
  static List<String> getFields() => [id, name, email, isBeginner];
}

class User {
  final String id;
  final String name;
  final String email;
  final String isBeginner;

  User(this.id, this.name, this.email, this.isBeginner);

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.isBeginner: isBeginner
      };
}
