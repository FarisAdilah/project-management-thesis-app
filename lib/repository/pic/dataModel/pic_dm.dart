class PicDM {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;

  PicDM();

  factory PicDM.fromJson(Map<String, dynamic> json) {
    PicDM pic = PicDM();
    pic.id = json['id'];
    pic.name = json['name'];
    pic.email = json['email'];
    pic.phoneNumber = json['phoneNumber'];
    pic.role = json['role'];
    return pic;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
