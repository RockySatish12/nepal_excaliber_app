List<Address> addressListFromJson(List<dynamic> addressListJson) =>
    List<Address>.from(
        addressListJson.map((addressJson) => Address.fromJson(addressJson)));

class Address {
  int? id;
  String? label;
  String? contactName;
  String? contact;
  String? country;
  String? provision;
  String? district;
  String? city;
  String? street;
  String? area;
  String? zipCode;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Address(
      {this.id,
      this.label,
      this.contactName,
      this.contact,
      this.country,
      this.provision,
      this.district,
      this.city,
      this.street,
      this.area,
      this.zipCode,
      this.createdAt,
      this.updatedAt,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    contactName = json['contactName'];
    contact = json['contact'];
    country = json['country'];
    provision = json['provision'];
    district = json['district'];
    city = json['city'];
    street = json['street'];
    area = json['area'];
    zipCode = json['zipCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['contactName'] = contactName;
    data['contact'] = contact;
    data['country'] = country;
    data['provision'] = provision;
    data['district'] = district;
    data['city'] = city;
    data['street'] = street;
    data['area'] = area;
    data['zipCode'] = zipCode;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }

  @override
  String toString() {
    return "$provision, $district, $city, $area, $street, ($zipCode)";
  }
}
