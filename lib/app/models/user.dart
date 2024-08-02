class User {
  String id;
  String? firstname;
  String? lastname;
  String? role;
  String? email;
  String? whatsApp;

  User({
    required this.id,
    this.firstname,
    this.lastname,
    this.role,
    this.email,
    this.whatsApp,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        role: json['role'],
        email: json['email'],
        whatsApp: json['whatsApp']);
  }

  toJSON() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "role": role,
      "email": email,
      "whatsApp": whatsApp
    };
  }
}
