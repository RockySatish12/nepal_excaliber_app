class AccessToken {
  String? type;
  String? token;

  AccessToken({this.type, this.token});

  AccessToken.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    return data;
  }
}
