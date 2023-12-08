class User
{
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

factory User.fromJson(Map<String, dynamic> json) => User(
  int.parse(json["id"]),
  json["email"],
  json["username"],
  json["password"],
  json["entreprise"],
  json["prenom"],
  );

Map<String, dynamic> toJson() =>
{
  'Id': id.toString(),
  'username': username,
  'email': email,
  'password': password,
  'prenom': prenom,
  'entreprise': entreprise,
};

}