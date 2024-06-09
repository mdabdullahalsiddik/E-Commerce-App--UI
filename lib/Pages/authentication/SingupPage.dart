// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:io';

import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Pages/authentication/SinginPage.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Static/all_images.dart';
import 'package:ecommerce_ui/Widget/costom_button.dart';
import 'package:ecommerce_ui/Widget/costom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formkey = GlobalKey<FormState>();
  File? pickedImage;
  String? images;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool passwordValidator = false;
  bool confampasswordValidator = false;
  var auth = FirebaseAuth.instance;
  galleryPickImage() {
    setState(() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        final tempImage = File(image!.path);
        pickedImage = tempImage;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    });
  }

  Future sendImage() async {
    setState(() async {
      var dataKye = DateTime.now().microsecond;

      var imagePath = await FirebaseStorage.instance
          .ref("user")
          .child(
            "${FirebaseAuth.instance.currentUser!.email.toString().replaceAll('.', '')}_${dataKye.toString()}",
          )
          .putFile(pickedImage!);

      images = await imagePath.ref.getDownloadURL();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      AllImages.logo,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      "Create an account so you can explore all the existing jobs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          galleryPickImage();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          child: pickedImage == null
                              ? const Icon(
                                  Icons.person,
                                  size: 100,
                                  color: AllColors.primaryColor,
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AllColors.primaryColor,
                                  backgroundImage: FileImage(pickedImage!),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        controller: nameController,
                        hintText: "Name",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your name");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        controller: phoneController,
                        hintText: "Phone",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your phone");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        controller: mailController,
                        hintText: "Email",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your mail");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        controller: areaController,
                        hintText: "Village/Area",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your village/area");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        controller: cityController,
                        hintText: "City",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your city");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        controller: countryController,
                        hintText: "Country",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your country");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: !passwordValidator,
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your password");
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                passwordValidator = !passwordValidator;
                              },
                            );
                          },
                          icon: Icon(
                            passwordValidator
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AllColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      CostomTextField(
                        textInputAction: TextInputAction.done,
                        controller: confirmpasswordController,
                        hintText: "Confirm Password",
                        validator: (valueKey) {
                          if (valueKey!.isEmpty) {
                            return ("Enter your confirm password");
                          }
                          return null;
                        },
                        obscureText: !confampasswordValidator,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                confampasswordValidator =
                                    !confampasswordValidator;
                              },
                            );
                          },
                          icon: Icon(
                            confampasswordValidator
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AllColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CostomButton(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            if (passwordController.text.length >= 6 &&
                                confirmpasswordController.text.length >= 6) {
                              if (passwordController.text ==
                                  confirmpasswordController.text) {
                                try {
                                  await EasyLoading.show(status: 'loading...');
                                  await sendImage();
                                  await FirebaseData().sendData(
                                    nameController.text,
                                    passwordController.text,
                                    phoneController.text,
                                    mailController.text,
                                    areaController.text,
                                    cityController.text,
                                    countryController.text,
                                    images ?? AllImages.profileImage,
                                  );
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: mailController.text,
                                    password: passwordController.text,
                                  )
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigatorBarPage(),
                                      ),
                                      (route) => false,
                                    );
                                  });
                                  EasyLoading.showSuccess('Great Success!');
                                  EasyLoading.dismiss();
                                  // ignore: duplicate_ignore
                                  // ignore: use_build_context_synchronously
                                } catch (e) {
                                  // ignore: duplicate_ignore
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.toString(),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      " Password are not mach ",
                                    ),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Enter 6 digit and longer password",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        text: "Sign up",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingInPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Already have an account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
