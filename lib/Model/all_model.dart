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
