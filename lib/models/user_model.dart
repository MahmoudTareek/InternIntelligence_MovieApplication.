class UserModel {
  late final String id;
  late final String username;
  late final String email;

  UserModel({required this.id, required this.username, required this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'].toString(),
      email: map['email'].toString(),
      id: map['id'].toString(),
    );
  }
}
