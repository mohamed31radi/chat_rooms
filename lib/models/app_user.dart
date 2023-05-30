class AppUser {
  static const String COLLECTION_NAME = "users";
  String id;
  String firstName;
  String userName;
  String email;

  AppUser(
      {required this.id,
      required this.firstName,
      required this.userName,
      required this.email});

  AppUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          email: json["email"],
          firstName: json["firstName"],
          userName: json["userName"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "userName": userName
    };
  }
}
