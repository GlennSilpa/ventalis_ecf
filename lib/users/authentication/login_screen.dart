import 'dart:convert';
import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecf_studi2/users/authentication/enregistrement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecf_studi2/users/model/user.dart';
import 'package:ecf_studi2/users/userPreferences/user_preference.dart';
import 'package:ecf_studi2/users/fragments/Dashboard_of_fragments.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async {
    print("login user now");
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );
      print("res.body :: " + res.body);
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          // Fluttertoast.showToast(msg: "Félécitation vous êtes connecté(e).");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          //sauvegarder info utlisateur avec Shared Preference
          await RememberUserPrefs.storeUserInfo(userInfo);
          print('take user to dashboard');
          // Future.delayed(const Duration(milliseconds: 2000), () {
          Get.to(DashboardOfFragments());
          // });
        } else {
          print("wrong email or password");
          // Fluttertoast.showToast(msg: "Erreur, veuillez réessayer.");
        }
      }
    } catch (errorMsg) {
      // ignore: prefer_interpolation_to_compose_strings
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                //login screen header
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 285,
                  child: const Text(
                    "Bienvenue Chez Ventalis !",
                    key: const Key('loginHeader'),
                    style: TextStyle(
                        fontSize: 24, // Adjust the font size as needed
                        fontWeight:
                            FontWeight.bold, // Adjust the font weight as needed
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                //login screen sign-in form
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //email
                                  TextFormField(
                                    key: Key('emailKey'),
                                    controller: emailController,
                                    validator: (val) => val == ""
                                        ? "Veuillez entrer votre email"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //password
                                  Obx(
                                    () => TextFormField(
                                      key: Key("passwordKey"),
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == ""
                                          ? "Veuillez entrer votre mot de passe"
                                          : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_sharp,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: Obx(
                                          () => GestureDetector(
                                            onTap: () {
                                              isObsecure.value =
                                                  !isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        hintText: "mot de passe",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            )),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            )),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //button
                                  Material(
                                    key: Key("loginButton"),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          loginUserNow();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Text(
                                          "Se Connecter",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
