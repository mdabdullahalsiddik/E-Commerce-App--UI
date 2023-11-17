// ignore: file_names
import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Pages/home_page.dart';
import 'package:ecommerce_ui/Pages/authentication/SinginPage.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_button.dart';
import 'package:ecommerce_ui/Widget/costom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool passwordValidator = false;
  bool confampasswordValidator = false;
  var auth = FirebaseAuth.instance;

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
                const Column(
                  children: [
                    Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
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
                                  await FirebaseData().sendData(
                                    nameController.text,
                                    passwordController.text,
                                    phoneController.text,
                                    mailController.text,
                                  );
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: mailController.text,
                                    password: passwordController.text,
                                  );

                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                    (route) => false,
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
                            color: Colors.black,
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
