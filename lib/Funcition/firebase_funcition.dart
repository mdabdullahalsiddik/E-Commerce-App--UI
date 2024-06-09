import 'dart:convert';
import 'package:ecommerce_ui/Model/all_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ecommerce_ui/Model/user_modul.dart';

class FirebaseData {
sendData(
    String name,
    String password,
    String phone,
    String mail,
    String area,
    String city,
    String country,
    String image,
  ) async {
    var user = UserInfoModel(
      name: name,
      phone: phone,
      password: password,
      mail: mail,
      area: area,
      city: city,
      country: country,
      image: image,
    );

    await FirebaseDatabase.instance
        .ref(
          "User",
        )
        .child(
          mail.replaceAll(".", ""),
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
        for (var i in value.children) {
          data.add(
            CategoryModel.fromJson(
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

  Future<List<OderCartProductModel>> productCartListGetData() async {
    List<OderCartProductModel> data = [];
    await FirebaseDatabase.instance
        .ref("OderCart")
        .child(
          FirebaseAuth.instance.currentUser!.uid.toString(),
        )
        .orderByKey()
        .get()
        .then(
      (value) {
        for (var i in value.children) {
          data.add(
            OderCartProductModel.fromJson(
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

  Future<List<FavoriteProductModel>> favoriteGetData() async {
    List<FavoriteProductModel> data = [];
    await FirebaseDatabase.instance
        .ref("Favorite")
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        //.orderByKey()
        .get()
        .then(
      (value) {
        for (var i in value.children) {
          data.add(
            FavoriteProductModel.fromJson(
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
