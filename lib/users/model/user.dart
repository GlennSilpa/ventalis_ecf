class User {
  int id;
  String username;
  String email;
  String password;
  String prenom;
  String entreprise;

  User(
    this.id,
    this.username,
    this.email,
    this.password,
    this.prenom,
    this.entreprise,
  );

 factory User.fromJson(Map<String, dynamic> json) {
  return User(
    int.tryParse(json["id"]?.toString() ?? '0') ?? 0,
    json["username"] ?? '',
    json["email"] ?? '',
    json["password"] ?? '',
    json["prenom"] ?? '',
    json["entreprise"] ?? '',
  );
}

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'username': username,
        'email': email,
        'password': password,
        'prenom': prenom,
        'entreprise': entreprise,
      };
}