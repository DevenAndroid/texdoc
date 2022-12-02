import 'dart:developer';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<User?> createFireBaseAccount(String name,String email,String password,) async {
  // to get Auth
  FirebaseAuth _auth = FirebaseAuth.instance;

  //to save users and related data
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  try{
    User? user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if(user!=null){
      showSnackBar("Create-FireBaseAccount Status", "Account Created Successfully.");

      user.updateProfile(displayName: name);
      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "name":name,
        "email":email,
        "status":"unavailable", // for offline and online
          });

      return user;
    }else{
      showSnackBar("Create-FireBaseAccount Status", "Account Creation Failed.");
    }

  }catch(e){
    showSnackBar("Create-FireBaseAccount Status","Account cretaion Failed:=>$e");
    return null;
  }
  return null;
}

Future<User?> loginFireBaseAccount(String email,String password) async {

  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    if(user!=null){
      showSnackBar("Login-FireBaseAccount Status", "Account login Successfully.");
      // Get.back();
      return user;
    }else{
      showSnackBar("Login-FireBaseAccount Status", "Account login Failed.");
      // Get.back();
    }

  }catch(e){
    showSnackBar("Login-FireBaseAccount Status", "Account login Failed=> $e");
    // Get.back();
    return null;
  }
  return null;
}

Future logoutFireBaseAccount() async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    _auth.signOut();
  }
      catch(e){
    showSnackBar("logoutFireBaseAccount", "logout from firebase.");
    return null;
      }
}