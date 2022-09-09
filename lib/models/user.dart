class User {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? name;
  String? imageUrl;
  String? userType;
  DateTime? dob;
  String? gender;
  String? deviceToken;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.username,
      this.phone,
      this.name,
      this.imageUrl,
      this.userType,
      this.dob,
      this.gender,
      this.deviceToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    userType = json['userType'];
    if (json['dob'] != null) {
      dob = DateTime.parse(json['dob']);
    }
    gender = json['gender'];
    deviceToken = json['deviceToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['phone'] = phone;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['userType'] = userType;
    data['dob'] = dob;
    data['gender'] = gender;
    data['deviceToken'] = deviceToken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
