abstract class UserDM {
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? phoneNumber;
  String? image;

  UserDM();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'phoneNumber': phoneNumber,
      'image': image,
    };
  }
}
