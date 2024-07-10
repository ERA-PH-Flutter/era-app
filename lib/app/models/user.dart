class User{
  String id;
  String? firstname;
  String? lastname;
  String? role;
  User({
    required this.id,
    this.firstname,
    this.lastname,
    this.role
  });

  factory User.fromJSON(Map<String, dynamic>json){
    return User(
      id: json['id'],
      firstname:  json['firstname'],
      lastname: json['lastname'],
      role: json['role']
    );
  }

  toJSON(){
    return {
      "id": id,
      "firstname":  firstname,
      "lastname" : lastname,
      "role" : role,

    };
  }
}