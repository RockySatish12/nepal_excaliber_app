List<Category> categoriesFromJson(List<dynamic> categoriesJson) =>
    List<Category>.from(
        categoriesJson.map((categoryJson) => Category.fromJson(categoryJson)));

class Category {
  int? id;
  String? title;
  String? imageUrl;
  String? description;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id, this.title, this.imageUrl, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
