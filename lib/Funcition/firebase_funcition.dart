import 'dart:convert';
import 'package:ecommerce_ui/Model/all_model.dart';
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
      mail: mail,
    );

    await FirebaseDatabase.instance
        .ref(
          "User",
        )
        .child(
          "${mail.replaceAll(".", "")}",
        )
        .set(
          user.toJson(),
        );
  }
}

class FirebaseGetData {
  Future<List<CategoryModel>> categoryGetData() async {
    List<CategoryModel> data = [];
    await FirebaseDatabase.instance.ref("Category").orderByKey().get().then(
      (value) {
        print(value);
        for (var i in value.children) {
          data.add(
            CategoryModel.fromJson(
              jsonDecode(
                jsonEncode(i.value),
              ),
            ),
          );
          print(data);
        }
      },
    );
    return data;
  }

  Future<List<ProductModel>> productGetData(String categoryTitle) async {
    List<ProductModel> data = [];
    await FirebaseDatabase.instance
        .ref("Product")
        .child(categoryTitle)
        .orderByKey()
        .get()
        .then(
      (value) {
        for (var i in value.children) {
          data.add(
            ProductModel.fromJson(
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

  Future productItemGetData(String categoryTitle, String id) async {
    var data ;
    await FirebaseDatabase.instance
        .ref("Product")
        .child(categoryTitle)
        .child(id.toLowerCase())
        .orderByKey()
        .get()
        .then(
      (value) {
        print(value);
      data = ProductModel.fromJson(jsonDecode(jsonEncode(value)));
        // for (var i in value.children) {
        //   data.add(
        //     ProductModel.fromJson(
        //       jsonDecode(
        //         jsonEncode(i.value),
        //       ),
        //     ),
        //   );
        // }
      },
    );
  }
}

class FirebaseUserGetData {
  Future<List<UserInfoModel>> getData() async {
    List<UserInfoModel> data = [];
    await FirebaseDatabase.instance
        .ref(
          "User",
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
