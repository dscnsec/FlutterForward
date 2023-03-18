// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chat {
  String? message;
  String? username;
  String? createdAt;
  Chat({
    this.message,
    this.username,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'username': username,
      'createdAt': createdAt,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      message: map['message'] != null ? map['message'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
