import 'dart:convert';

import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



class senregistrer extends StatefulWidget {
  const senregistrer({super.key});

  @override
  State<senregistrer> createState() => _senregistrerState();
}

class _senregistrerState extends State<senregistrer> {
var formKey = GlobalKey<FormState>();
var entrepriseController = TextEditingController();
var usernameController = TextEditingController();
var prenomController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var isObsecure = true.obs;

validateUserEmail() async

{
try
{
 var res = await http.post(
    Uri.parse(API.validateEmail),
    body: {
      'email' : emailController.text.trim(),
    }
 );

if(res.statusCode == 200); //connection anvec api vers server - succes
 {
  var resBodyOfValidateEmail = jsonDecode(res.body);

  if(resBodyOfValidateEmail['success'] == true)
  {
    Fluttertoast.showToast(msg: "l'email existe déja");
  }
  else
  {
    //enregistrer la nouvelle donné à la base de donné
    registerAndSaveUserRecord();
  }
 }

}
catch(e)
{
   print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
}
}


registerAndSaveUserRecord() async
{
  User userModel = User(
   1,
   usernameController.text.trim(),
   emailController.text.trim(),
   passwordController.text.trim(),
   entrepriseController.text.trim(),
   prenomController.text.trim(),
  );

   try{
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if(res.statusCode == 200)
      {
        var resBodyOfsignUp = jsonDecode(res.body);
        if(resBodyOfsignUp['success'] == true)
        {
          Fluttertoast.showToast(msg: "Félécitation vous êtes enregistré.");

         setState((){
          usernameController.clear();
   emailController.clear();
   passwordController.clear();
   entrepriseController.clear();
   prenomController.clear();
         });

        }
        else
        {
          Fluttertoast.showToast(msg: "Erreur, veuillez réessayer.");
        }
      }
   }
   catch(e)
   {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
   }
}
  
  @override
  Widget build(BuildContext context) 
  {
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

                  //header de la page d'enregistrememnt
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset(
                      "images/ecologie.webp", 
                    ),
                  ),


                 //formulaire d'enregistrement
                 Padding(
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


                                 ///Nom d'utlisateur
                                 TextFormField(
                                controller: usernameController,
                                validator: (val) => val == "" ? "Veuillez entrer votre nom d'utilisateur" : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                  
                                    Icons.person,
                                    color: Colors.black,
                                    ),
                                  hintText: "Nom d'utlisateur",
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),



                                 const SizedBox(height: 18,),

                                  //Nom de l'entreprise
                              TextFormField(
                                controller: entrepriseController,
                                validator: (val) => val == "" ? "Veuillez entrer le nom votre enreprise" : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                  
                                    Icons.email,
                                    color: Colors.black,
                                    ),
                                  hintText: "Entreprise",
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),


                             const SizedBox(height: 18,),

                             //Prénom
                             TextFormField(
                                controller: prenomController,
                                validator: (val) => val == "" ? "Veuillez entrer votre prénom" : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                  
                                    Icons.person,
                                    color: Colors.black,
                                    ),
                                  hintText: "Prénom",
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),


                                    const SizedBox(height: 18,),


                              //email              
                             TextFormField(
                                controller: emailController,
                                validator: (val) => val == "" ? "Veuillez entrer votre email" : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                  
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),
                            
                             const SizedBox(height: 18,),
                      
                              //password
                              Obx(
                              ()=> TextFormField(
                                controller: passwordController,
                                obscureText: isObsecure.value,
                                validator: (val) => val == "" ? "Veuillez entrer votre mot de passe" : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                  
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled:  true,
                                ),
                                ),
                              ),
                      
                              const SizedBox(height: 18,),
                      
                      
                      
                              //button
                              Material(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: ()
                                  {
                                       if(formKey.currentState!.validate())
                                       {
                                        //valider l'email
                                        validateUserEmail();
                                       }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Text(
                                      "Enregistrer",
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

                      const SizedBox(height: 16,),
                      // Vous avez déja un compte ? Connectez vous
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Vous avez déja un compte ?"
                          ),
                          TextButton(
                            onPressed: ()
                            {
                                Get.to(const LoginScreen());
                            },
                            child: const Text(
                              "Connectez vous",
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

