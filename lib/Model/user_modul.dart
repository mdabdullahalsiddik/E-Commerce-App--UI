// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserInfoModel {
  String? name;
  String? mail;
  String? phone;
  String? password;

  UserInfoModel({
    this.name,
    this.mail,
    this.phone,
    this.password,
 
  });
 UserInfoModel.fromJson(dynamic json) {
    name = json['name'];
    mail = json['mail'];
    phone = json['phone'];
    password = json['password'];
  
    
  }

  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
   
    map['mail'] = mail;
    map['phone'] = phone;
    map['password'] = password;
   
 
    return map;
  }
}