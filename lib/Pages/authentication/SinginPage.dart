// ignore: file_names
import 'package:ecommerce_ui/Pages/authentication/SingupPage.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_button.dart';
import 'package:ecommerce_ui/Widget/costom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../home_page.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Lorem iqsum",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
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
                      const SizedBox(
                        height: 15,
                      ),
                      CostomTextField(
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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AllColors.yellowColor,
                          value: value,
                          onChanged: (val) {
                            setState(() {
                              value = val!;
                            });
                          },
                        ),
                        const Text(
                          "Remember",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot your password ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AllColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
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
                                            const HomePage(),
                                      ),
                                      (route) => false,
                                    ),
                                  );
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                  text: "Lorem iqsum",
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
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
