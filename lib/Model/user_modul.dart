// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserInfoModel {
  String? name;
  String? mail;
  String? phone;
  String? password;
  String? image;

  String? area;
  String? city;
  String? country;

  UserInfoModel({
    this.name,
    this.mail,
    this.phone,
    this.password,
    this.area,
    this.city,
    this.country,
    this.image,
  });
  UserInfoModel.fromJson(dynamic json) {
    name = json['name'];
    mail = json['mail'];
    phone = json['phone'];
    password = json['password'];
    area = json['area'];
    city = json['city'];
    country = json['country'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['mail'] = mail;
    map['phone'] = phone;
    map['password'] = password;
    map['area'] = area;
    map['city'] = city;
    map['country'] = country;
    map['image'] = image;

    return map;
  }
}
