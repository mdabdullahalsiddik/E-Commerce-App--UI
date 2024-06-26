// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_ui/Pages/authentication/SingupPage.dart';
import 'package:ecommerce_ui/Pages/authentication/otp_page.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_button.dart';
import 'package:ecommerce_ui/Widget/costom_textfromfield.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordValidator = false;
  bool value = false;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "E-Shop",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
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
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        CostomTextField(
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          hintText: "Password",
                          validator: (valueKey) {
                            if (valueKey!.isEmpty) {
                              return ("Enter your password");
                            }
                            return null;
                          },
                          obscureText: !passwordValidator,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 22,
                            child: Checkbox(
                              activeColor: AllColors.yellowColor,
                              value: value,
                              onChanged: (val) {
                                setState(() {
                                  value = val!;
                                });
                              },
                            ),
                          ),
                          const Text(
                            "Remember",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OTPPage()));
                        },
                        child: const Text(
                          "Forgot your password ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CostomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        try {
                          await EasyLoading.show(status: 'loading...');

                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: mailController.text,
                                password: passwordController.text,
                              )
                              .then(
                                (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigatorBarPage(),
                                  ),
                                  (route) => false,
                                ),
                              );
                          EasyLoading.dismiss();
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString(),
                              ),
                            ),
                          );
                          EasyLoading.dismiss();
                        }
                      }
                    },
                    text: "Sing In",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Create Account ?",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
              },
              child: const Text(
                "Sing Up",
                style: TextStyle(
                  fontSize: 20,
                  color: AllColors.yellowColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
