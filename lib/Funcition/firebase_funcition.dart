import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:ecommerce_ui/Model/user_modul.dart';

class FirebaseData {
  sendData(
    String name,
    String password,
    String phone,
    String mail,
  ) async {
    var dataKye = DateTime.now().microsecond;
    var user = UserInfoModel(
      name: name,
      phone: phone,
      password: password,
      mail:mail,
    );

  await  FirebaseDatabase.instance
        .ref(
          "User",
        )
        .child(
          "${phone}_${name.replaceAll(" ", "_")}_$dataKye",
        )
        .set(
          user.toJson(),
        );
  }
}

class Firebasedatabase {}

class FirebaseGetData {
  Future<List<UserInfoModel>> getData() async {
    List<UserInfoModel> data = [];
    await FirebaseDatabase.instance
        .ref(
          "Nagad_User",
        )
        .orderByKey()
        .get()
        .then(
      (value) {
        for (var i in value.children) {
          data.add(
            UserInfoModel.fromJson(
              jsonDecode(
                jsonEncode(i.value),
              ),
            ),
          );
        }
      },
    );
    return data;
  }
}
