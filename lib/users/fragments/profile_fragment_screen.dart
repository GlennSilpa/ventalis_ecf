import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileFragmentScreen extends StatelessWidget 
{
  final CurrentUser _currentUser = Get.put(CurrentUser());
  
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