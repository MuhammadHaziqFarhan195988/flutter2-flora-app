import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora_app/Widgets/customTextField.dart';
import 'package:flora_app/DialogBox/errorDialog.dart';
import 'package:flora_app/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:flora_app/Config/config.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register>
{
  final TextEditingController _nametextEditingController = TextEditingController();
  final TextEditingController _emailtextEditingController = TextEditingController();
  final TextEditingController _passwordtextEditingController = TextEditingController();
  final TextEditingController _cpasswordtextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();
  String userImageUrl = "";
  XFile? _imageFile;
  File _imageFile2=File('');

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10.0,),
            InkWell(
              onTap: _selectAndPickImage,
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile==null ? null : FileImage(_imageFile2),
                child: _imageFile == null
                    ? Icon(Icons.add_photo_alternate, size: _screenWidth * 0.15, color: Colors.grey)
                    : null,
              ),
            ),
            SizedBox(height: 8.0,),
            Form(
             key: _formKey,
             child: Column(
               children: [
                 CustomTextField(
                   controller: _nametextEditingController,
                   data: Icons.person,
                   hintText: "Name",
                   isObsecure: false,
                 ),
                 CustomTextField(
                   controller: _emailtextEditingController,
                   data: Icons.email,
                   hintText: "Email",
                   isObsecure: false,
                 ),
                 CustomTextField(
                   controller: _passwordtextEditingController,
                   data: Icons.lock,
                   hintText: "Password",
                   isObsecure: true,
                 ),
                 CustomTextField(
                   controller: _cpasswordtextEditingController,
                   data: Icons.lock,
                   hintText: "Confirm Password",
                   isObsecure: true,
                 ),
               ],
             ),
            ),
            ElevatedButton(
              onPressed: () {uploadAndSaveImage();},
              child: Text("sign up", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth = 0.0,
              color: Colors.pink,
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

 Future<void> _selectAndPickImage() async{
   _imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
}

  Future<void> uploadAndSaveImage() async{
    if (_imageFile == null){
      showDialog(context: context, builder: (c){
        return ErrorAlertDialog(message: "please select an Image");
      });
    }
    else {
      _passwordtextEditingController.text == _cpasswordtextEditingController.text
          ? _emailtextEditingController.text.isNotEmpty &&
          _passwordtextEditingController.text.isNotEmpty &&
          _cpasswordtextEditingController.text.isNotEmpty &&
          _nametextEditingController.text.isNotEmpty

          ? uploadToStorage()

        : displayDialog("please complete the form")

        :  displayDialog("password do not match");
    }
  }

  displayDialog(String msg){
    showDialog(context: context, builder: (c){
      return ErrorAlertDialog(message: msg,);
    });
  }


  uploadToStorage() async {
    showDialog(context: context, builder: (c){
      return LoadingAlertDialog(message: 'Authenticating please wait.....',);
    });

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child(imageFileName);
  
    UploadTask storageUploadTask = storageReference.putFile(_imageFile2);



    storageUploadTask.then((taskSnapshot){
       taskSnapshot.ref.getDownloadURL().then((urlImage) {
         userImageUrl = urlImage;

      });
    });
    _registerUser();
  }
FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User? firebaseUser;
    
    await _auth.createUserWithEmailAndPassword(email: _emailtextEditingController.text.trim(), password: _passwordtextEditingController.text.trim()).then((auth) {
      firebaseUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context, builder: (c){
        return ErrorAlertDialog(message: error.message.toString(),);
      });
    });

    if(firebaseUser != null) {

        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => StoreHome());
            Navigator.pushReplacement(context, route);

    }
  }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nametextEditingController.text.trim(),
      "url": userImageUrl,
    });

  await EcommerceApp.sharedPreferences!.setString("uid", fUser.uid);
  //await EcommerceApp.sharedPreferences!.setString("email", fUser.email);
  await EcommerceApp.sharedPreferences!.setString("name", _nametextEditingController.text);
  await EcommerceApp.sharedPreferences!.setString("url", userImageUrl);
  await EcommerceApp.sharedPreferences!.setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }
}

