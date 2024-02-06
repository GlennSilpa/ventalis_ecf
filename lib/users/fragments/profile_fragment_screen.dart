import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/fragments/page_acceuil.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:ecf_studi2/users/userPreferences/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileFragmentScreen extends StatelessWidget 
{
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async
  {
   var resultResponse = await Get.dialog(
       AlertDialog(
         backgroundColor: Colors.grey,
         title: const Text(
          "Déconnexion",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            
            ),
          ),
         content: const Text("êtes vous sure?",
         ),
         actions: [
          TextButton(
            onPressed: ()
            {
              Get.back();
            },
            child: const Text(
              "No",
            style: TextStyle(
              color: Colors.black,
            ),
            )
          ),
           TextButton(
            onPressed: ()
            {
              Get.back(result: "déconnecté");
            },
            child: const Text(
              "Oui",
            style: TextStyle(
              color: Colors.black,
            ),
            )
          ),
         ],
       ),
    );

    if(resultResponse == "déconnecté")
    {
      RememberUserPrefs.removeUserInfo()
      .then((value) 
      {

          Get.off(LoginScreen());

      });

      //delete-remove the user data from localstorage
    }
  }
  
  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 0,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [

        Center(
            child: Image.asset(
          "assets/images/profile_pic.jpg",
          width: 240,
        )),
        const SizedBox(
          height: 20,
        ),
        

    

        userInfoItemProfile(Icons.person, _currentUser.user.username),

       const SizedBox(height: 20,),

        userInfoItemProfile(Icons.email, _currentUser.user.email),

        const SizedBox(height: 20,),

        Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(0),
            child: InkWell(
              onTap: ()
              {
                  signOutUser();
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
              ),
                child: Text(
                  "Se déconnecter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,

                  ),
                  
                  ),
                
              ),
              
            ),
          ),
        )
      

      ],
    );
  }
}