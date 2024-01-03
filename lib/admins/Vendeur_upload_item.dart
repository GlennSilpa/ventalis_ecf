import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminUploadItemsScreen extends StatefulWidget {
  
 
  @override
  State<AdminUploadItemsScreen> createState() => _AdminUploadItemsScreenState();
}



class _AdminUploadItemsScreenState extends State<AdminUploadItemsScreen> 
{

  final ImagePicker _picker = ImagePicker();
  XFile? pickedimageXFile;

captureImageWithPhoneCamera() async

{
  pickedimageXFile = await _picker.pickImage(source: ImageSource.camera);

  Get.back();
}

pickImageFromPhoneGallery() async

{
  pickedimageXFile = await _picker.pickImage(source: ImageSource.gallery);

  Get.back();
}


showDialogBoxForImagePickingAndCapturing()
 {
  return showDialog(
    context: context,
    builder: (context)
  {
    return SimpleDialog(
     title: const Text(
    "image produit",
    style: TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.bold,
    ),
    ),
    children: [
     SimpleDialogOption(
      onPressed: ()
      {
       captureImageWithPhoneCamera();
      },
      child: const Text(
        "Prendre une photo avec caméra",
        style: TextStyle( 
        color:Colors.grey,
        ),
      ),
     ),
     SimpleDialogOption(
      onPressed: ()
      {
       pickImageFromPhoneGallery();
      },
      child: const Text(
        "Sélectionner une image",
        style: TextStyle( 
        color:Colors.grey,
        ),
      ),
     ),
     SimpleDialogOption(
      onPressed: ()
      {
       Get.back();
      },
      child: const Text(
        "Annuler",
        style: TextStyle( 
        color:Colors.red,
        ),
      ),
     ),
    ],
    );
  }
 
 );
 }

Widget defaultScreen()
{
  return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
  gradient:LinearGradient(
    colors: [
      Colors.black54,
      Colors.deepPurple,
    ],
  ), 
),
        ),
      automaticallyImplyLeading: false,
      title: Text(
        "Bienvenue cher(e) employé(e)"
        ),
        centerTitle: true,
      ),
      body: Container(
decoration: BoxDecoration(
  gradient:LinearGradient(
    colors: [
      Colors.black54,
      Colors.deepPurple,
    ],
  ), 
),

child: Center(
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.add_photo_alternate,
        color: Colors.white54,
        size: 200,
        ),
        Material(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: ()
                                  {
                                     showDialogBoxForImagePickingAndCapturing();
                                     },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Text(
                                      "Ajouter produit",
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
    );
}

  @override
  Widget build(BuildContext context) 
  {
    return defaultScreen() ;
  }
}