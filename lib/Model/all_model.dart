// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItemModel {
  String? title;
  String? image;
  int? quantity;
  var price;
  var totalPrice;
  String? id;
  String? size;
  String? color;
  CartItemModel({
    this.title,
    this.image,
    this.quantity,
    this.price,
    this.totalPrice,
    this.id,
    this.size,
    this.color,
  });
}

class FavoriteItemModel {
  String? product_id;
  String? image;
  String? title;
  double? price;
  int? quantity;
  String? about;
  List? size;
  List? color;
}


class ProductModel {
  String? title;
  String? image;
  int? quantity;
  var price;

  String? id;
  String? about;
  String? categoryID;
  List? size;
  List? color;

  ProductModel({
    required this.title,
    required this.image,
    this.quantity,
    this.about,
    required this.price,
    required this.id,
    this.size,
    this.color,
    this.categoryID,
  });

  ProductModel.fromJson(dynamic json) {
    title = json['title'];
    about = json['about'];

    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    id = json['id'];
    size = json['size'];
    color = json['color'];
    categoryID = json['categoryID'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;
    map['about'] = about;

    map['quantity'] = quantity;
    map['price'] = price;
    map['id'] = id;
    map['size'] = size;
    map['color'] = color;
    map['categoryID'] = categoryID;

    return map;
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  String? title;
  String? image;
  String? id;

  CategoryModel({
    required this.title,
    required this.image,
    required this.id,
  });

  CategoryModel.fromJson(dynamic json) {
    title = json['title'];

    image = json['image'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;

    map['id'] = id;

    return map;
  }
}
