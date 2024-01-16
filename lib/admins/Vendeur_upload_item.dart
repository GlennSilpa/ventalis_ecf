import 'dart:convert';
import 'dart:io';
import 'package:ecf_studi2/admins/vendeur_login.dart';
import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class AdminUploadItemsScreen extends StatefulWidget {
  
 
  @override
  State<AdminUploadItemsScreen> createState() => _AdminUploadItemsScreenState();
}



class _AdminUploadItemsScreenState extends State<AdminUploadItemsScreen> 
{

  final ImagePicker _picker = ImagePicker();
  XFile? pickedimageXFile;

  var formKey = GlobalKey<FormState>();
  var libelleController = TextEditingController();
  var descritpionController = TextEditingController();
  var prixController = TextEditingController();
  var categorieController = TextEditingController();
  var imageLink = "";

  //default screen methods

captureImageWithPhoneCamera() async

{
  pickedimageXFile = await _picker.pickImage(source: ImageSource.camera);

  Get.back();

setState(()=> pickedimageXFile);
  


}

pickImageFromPhoneGallery() async

{
  pickedimageXFile = await _picker.pickImage(source: ImageSource.gallery);

  Get.back();

  setState(()=> pickedimageXFile);
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

//default screen fini ici

//uploadItemFormScreen methods

uploadItemImage() async
{
  var requestImgurApi = http.MultipartRequest(
    "POST",
    Uri.parse("https://api.imgur.com/3/image")

  );

String imageName = DateTime.now().millisecondsSinceEpoch.toString();
requestImgurApi.fields['title'] = imageName;
requestImgurApi.headers['Authorization'] = "Client-ID " + "8952cf828f076d3";


var imageFile = await http.MultipartFile.fromPath(
  'image',
  pickedimageXFile!.path,
  filename: imageName,
);

requestImgurApi.files.add(imageFile);
var responseFromImgurApi = await requestImgurApi.send();

var responseDataFromImgurApi = await responseFromImgurApi.stream.toBytes();
var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);


Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
imageLink = (jsonRes["data"]["link"]).toString();
String deleteHash = (jsonRes["data"]["deletehash"]).toString();

saveItemInfoToDatabase();

}

saveItemInfoToDatabase() async
{
 List<String> categorieList = categorieController.text.split(',');


 try
{
   var response = await http.post(
    Uri.parse(API.uploadNewItem),
    body: 
    {
      'item_id' : '1',
      'libelle': libelleController.text.trim().toString(),
      'description': descritpionController.text.trim().toString(),
      'prix': prixController.text.trim().toString(),
      'categorie': categorieList.toString(),
      'image': imageLink.toString(),
    },
   );

   if(response.statusCode == 200)
{
  var resBodyOfUploadItem = jsonDecode(response.body);

if(resBodyOfUploadItem['success'] == true)
  {
    Fluttertoast.showToast(msg: "nouveau produit créer");
  
setState(() { 
          pickedimageXFile=null;
          libelleController.clear();
          descritpionController.clear();
          prixController.clear();
          categorieController.clear();
          });

    Get.to(AdminUploadItemsScreen());
  }
  else
  {
   Fluttertoast.showToast(msg: "erreur, veuillez réessayer");
  }


}

}
catch(errorMsg)
{
 print("Error:: " + errorMsg.toString());
}
}

//uploadItemFormScreen methods ends here

Widget uploadItemFormScreen()
{
  return Scaffold(
    backgroundColor: Colors.black,
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
        "Upload"
       ),
       centerTitle: true,
       leading: IconButton(
        onPressed: ()
        {
          setState(() { 
          pickedimageXFile=null;
          libelleController.clear();
          descritpionController.clear();
          prixController.clear();
          categorieController.clear();


          });
          Get.to(AdminUploadItemsScreen());
        },
        icon: const Icon(
          Icons.clear
          ,)
       ),
       actions: [
        TextButton(
          onPressed: ()
          {
             Fluttertoast.showToast(msg: "En cours de création...");
                    
             uploadItemImage();
                            
          },
          child: const Text(
            "Terminé",
            style: TextStyle(
              color: Colors.green,
            )
          ),

        ),
       ],
    ),
    body: ListView(
      children: [
        //image :
        Container(
         height: MediaQuery.of(context).size.height * 0.4,
         width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            image:DecorationImage(
              image: FileImage(
                File(pickedimageXFile!.path),
                ),
                fit: BoxFit.cover,
                )
          ),
        ),
      
    //upload item form
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
                             
                              //libelle             
                             TextFormField(
                                controller: libelleController,
                                validator: (val) => val == "" ? "Veuillez entrer le libelle du produit" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                  
                                    Icons.title,
                                    color: Colors.black,
                                    ),
                                  hintText: "libelle",
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
                      
                             //description             
                             TextFormField(
                                controller: descritpionController,
                                validator: (val) => val == "" ? "Veuillez entrer la description produit" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                  
                                    Icons.description,
                                    color: Colors.black,
                                    ),
                                  hintText: "description",
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
                      
                              //prix             
                             TextFormField(
                                controller: prixController,
                                validator: (val) => val == "" ? "Veuillez entrer le prix du produit" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                  
                                    Icons.price_change_outlined,
                                    color: Colors.black,
                                    ),
                                  hintText: "prix",
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

                              //Catégorie             
                             TextFormField(
                                controller: categorieController,
                                validator: (val) => val == "" ? "Veuillez entrer la catégorie du produit" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                  
                                    Icons.category,
                                    color: Colors.black,
                                    ),
                                  hintText: "catégorie",
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


                      
                              //button
                              Material(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: ()
                                  {
                                     if(formKey.currentState!.validate())
                                     {
                                      Fluttertoast.showToast(msg: "En cours de création...");
                                      uploadItemImage();
                                     }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Text(
                                      "Ajouter le produit",
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
                      



                     ],
                 
                    ),
                   ),
                 ),
      
      ],
    ),
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
    return pickedimageXFile == null ? defaultScreen() :uploadItemFormScreen();
  }
}