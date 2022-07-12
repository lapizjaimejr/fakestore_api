class UserCredentials {
  String? username;
  String? password;

  UserCredentials({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'password': password,
      };
}
