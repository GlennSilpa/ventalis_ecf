import 'dart:convert';
import 'package:ecf_studi2/admins/Vendeur_upload_item.dart';
import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecf_studi2/users/authentication/enregistrement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecf_studi2/users/model/user.dart';
import 'package:ecf_studi2/users/userPreferences/user_preference.dart';
import 'package:ecf_studi2/users/fragments/Dashboard_of_fragments.dart';

class VendeurLoginScreen extends StatefulWidget {
  const VendeurLoginScreen({super.key});

  @override
  State<VendeurLoginScreen> createState() => _VendeurLoginScreenState();
}

class _VendeurLoginScreenState extends State<VendeurLoginScreen> {
var formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var isObsecure = true.obs;
  
loginVendeurNow() async
{
try{
var res = await http.post(
        Uri.parse(API.vendeurLogin),
        body: {
          "vendeur_email": emailController.text.trim(),
          "vendeur_password": passwordController.text.trim(),
        },
      );

if(res.statusCode == 200)
      {
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true)
        {
          Fluttertoast.showToast(msg: "Félécitation vous êtes connecté(e).");
      
      Future.delayed(Duration(milliseconds: 2000), ()
      {
       Get.to(AdminUploadItemsScreen());
        });
        }
        else
        {
          Fluttertoast.showToast(msg: "Erreur, veuillez réessayer.");
        }
      }
}
catch(errorMsg)
{
  // ignore: prefer_interpolation_to_compose_strings
  print("Error :: " + errorMsg.toString());
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, cons)
        {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //login screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset(
                      "images/ecologie.webp", 
                    ),
                  ),


                 //login screen sign-in form
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Container(
                     decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset:  Offset(0, -3),
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
                                controller: emailController,
                                validator: (val) => val == "" ? "Veuillez entrer votre email" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                  
                                    Icons.email,
                                    color: Colors.black,
                                    ),
                                  hintText: "email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),
                            
                             SizedBox(height: 18,),
                      
                              //password
                              Obx(
                              ()=> TextFormField(
                                controller: passwordController,
                                obscureText: isObsecure.value,
                                validator: (val) => val == "" ? "Veuillez entrer votre mot de passe" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                  
                                    Icons.vpn_key_sharp,
                                    color: Colors.black,
                                    ),
                                    suffixIcon: Obx(
                                      ()=> GestureDetector(
                                        onTap: ()
                                        {
                                          isObsecure.value = !isObsecure.value;
                      
                                        },
                                        child: Icon(
                                        isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                        color:  Colors.black,
                                        ),
                                      ),
                                    ),
                                  hintText: "mot de passe",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,     
                                       )
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),
                              ),
                      
                              SizedBox(height: 18,),
                      
                      
                      
                              //button
                              Material(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: ()
                                  {
                                     if(formKey.currentState!.validate())
                                     {
                                      loginVendeurNow();
                                     }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Padding(
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

                      SizedBox(height: 16,),
                      // Je ne suis pas un vendeur
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Je ne suis pas un vendeur"
                          ),
                          TextButton(
                            onPressed: ()
                            {
                               Get.to(LoginScreen());
                            },
                            child: const Text(
                              "Clickez ici",
                              style: TextStyle(
                              color: Colors.purpleAccent,
                              ),
                            ),
                          )
                        ]
                      ),



                     ],
                 
                    ),
                   ),
                 ),


                ]
              ),
            ),
          );
        },
      ),
    );
  }
}

