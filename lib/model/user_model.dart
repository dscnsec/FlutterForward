// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? name;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? email;

  User({
    this.name,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        createdAt: map['createdAt'],
        email: map['email'],
        name: map['name'],
        updatedAt: map['updatedAt'],
        username: map['username']);
  }
}
