// ignore: duplicate_ignore
// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItemModel {
  String? title;
  String? image;
  int? quantity;
  // ignore: prefer_typing_uninitialized_variables
  var price;
  // ignore: prefer_typing_uninitialized_variables
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
  // ignore: non_constant_identifier_names
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
  // ignore: prefer_typing_uninitialized_variables
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

class OderCartProductModel {
  String? title;
  String? image;
  int? quantity;
  // ignore: prefer_typing_uninitialized_variables
  var price;
  var totalprice;
  String? id;
  String? about;
  String? categoryID;
  String? size;
  String? color;

  OderCartProductModel({
    required this.title,
    required this.image,
    this.quantity,
    this.about,
    required this.price,
    required this.totalprice,
    required this.id,
    this.size,
    this.color,
    this.categoryID,
  });

  OderCartProductModel.fromJson(dynamic json) {
    title = json['title'];
    about = json['about'];

    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    totalprice = json['totalprice'];
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
    map['totalprice'] = totalprice;
    map['id'] = id;
    map['size'] = size;
    map['color'] = color;
    map['categoryID'] = categoryID;

    return map;
  }
}

class OderProductModel {
  String? title;
  String? image;
  int? quantity;
  // ignore: prefer_typing_uninitialized_variables
  var price;

  String? id;
  String? mail;
  String? categoryID;
  String? size;
  String? color;

  OderProductModel({
    required this.title,
    required this.image,
    this.quantity,
    this.mail,
    required this.price,
    required this.id,
    this.size,
    this.color,
    this.categoryID,
  });

  OderProductModel.fromJson(dynamic json) {
    title = json['title'];
    mail = json['mail'];

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
    map['mail'] = mail;
    map['image'] = image;

    map['quantity'] = quantity;
    map['price'] = price;

    map['id'] = id;
    map['size'] = size;
    map['color'] = color;
    map['categoryID'] = categoryID;

    return map;
  }
}
