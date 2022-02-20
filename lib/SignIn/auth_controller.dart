
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/User.dart';
import 'package:pujapurohit/SignIn/login_page.dart';
import 'package:pujapurohit/Starter/splash_screen.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:pujapurohit/controller/loginController.dart';
import 'dart:html' as html;


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  LoginController loginController = Get.put(LoginController());
  LocationController locationController = Get.put(LocationController());
  LoadController loadController = Get.put(LoadController());
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();
  RxBool isLoggedIn = false.obs;
  RxBool reloadCompleted = false.obs;
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;
  User? get user => _firebaseUser.value;
  String? phoneNo, smssent, sms, verificationId,errorMessage;
  var pandit= 0.obs;
  var verify = false.obs;
  var verifinaction = "1".obs;
  LoginField loginField=Get.put(LoginField());
  @override
  void onReady()async {
    super.onReady();
    _firebaseUser.bindStream(auth.authStateChanges());
    //ever(_firebaseUser, _setInitialScreen);
  }
  
 



  void signOut() async {
    auth.signOut().whenComplete(() {
      Get.offAndToNamed('/');
      Get.snackbar("Snack", "Successfully log out");
    });
  }

  updateuser()async{
    print("Code run");
    loadController.updateLoad();
     user!.updateProfile(displayName: '${loginField.name}',photoURL:"https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fblank-profile-picture-png-removebg-preview.png?alt=media&token=56909aea-e9d5-41b5-8bed-2b147e474a41");
      user!.updateEmail('${loginField.email}');
   await   FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        "name": loginField.name,
         "uid": user!.uid,
         "email": loginField.email,
         "age":loginField.age,
         "phone":user!.phoneNumber,
         "photoUrl":"https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fblank-profile-picture-png-removebg-preview.png?alt=media&token=56909aea-e9d5-41b5-8bed-2b147e474a41",
         "lat":locationController.location.value.slat.toString(),
         "lng":locationController.location.value.slng.toString(),
         "address":locationController.location.value.address
      }).catchError((e){Get.snackbar("Error","$e");}).whenComplete(() {
        loadController.updateLoad();
       Get.to(SplashScreen());
       //html.window.location.reload();
      });
    user!.reload();
  }

  signupmyCredential(String input,String lat,String lng,String address)async{
  print('${verifinaction.value}');
    AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verifinaction.value, smsCode: loginField.otp);
    await auth.signInWithCredential(authCredential).catchError((e){Get.snackbar("Error", "${e.message}");}).then((value)async{
        FirebaseFirestore.instance.doc('users/${value.user!.uid}').set({
           "name": loginField.name,
            "uid": value.user!.uid,
            "email": loginField.email,
            "age":loginField.age,
            "phone":loginField.phone,
            "photoUrl":"https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fblank-profile-picture-png-removebg-preview.png?alt=media&token=56909aea-e9d5-41b5-8bed-2b147e474a41",
            "lat":lat,
            "lng":lng,   
            "address":address,
            "joining":FieldValue.serverTimestamp(),
            "token":"Web"
        });
           await  value.user!.updateProfile(displayName: '${loginField.name}',photoURL:"https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fblank-profile-picture-png-removebg-preview.png?alt=media&token=56909aea-e9d5-41b5-8bed-2b147e474a41");
          await  value.user!.updateEmail('${loginField.email}');
          await value.user!.reload().whenComplete((){
              Get.toNamed('/home');
              loadController.updateLoad();
              loginController.signin();
          });
          html.window.location.reload();
    });
    
    
  }
  
  myCredential(String input)async{
    loadController.updateLoad();
    print('${verifinaction.value}');
    AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verifinaction.value, smsCode: loginField.otp);
    
    // UserCredential authResult = await auth.signInWithCredential(authCredential).catchError((e){Get.snackbar("Error", "${e.message}");}).whenComplete(() {
    //   loadController.updateLoad();
    //   html.window.location.reload();
    // });
    
    await auth.signInWithCredential(authCredential).catchError((e){Get.snackbar("Error", "${e.message}");}).then((value){
      FirebaseFirestore.instance.doc('users/${value.user!.uid }').get().then((value) {
            if(value.exists){
                 loadController.updateLoad();
                 html.window.location.reload();
                 loginController.signin();
            }
            else{
              loadController.updateLoad();
              Get.snackbar("Login Error", "User not exists, please SignUp");
              auth.signOut();
              loginController.signin();
              
            }
        });
    });
    loginController.signin();
    
    //Get.to(SplashScreen());
     
  }


  webverifyPhone(String phone)async{
     
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
        '+91${phone}').catchError((error){
      Get.snackbar('Error', error.message);
    });
    
 
  
     if(loginController.loginData.value.loginType == "login"){
       loginController.otp();
       loadController.updateLoad();
       print("Otp activated");
     }
     else{
        loginController.sotp();
        loadController.updateLoad();
        print("sOtp activated");
     }
     verifinaction.value = confirmationResult.verificationId;
     
   

  }
  verifyPhone(String phone)async{
    final PhoneVerificationCompleted verified=
        (AuthCredential authResult){
        Get.offAndToNamed('/home');
    };
    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
      Get.snackbar("Login Error", "${authException.message}");

    };
    final PhoneCodeSent smsSent = (String? verId, [int? forceResend]) {
      this.verificationId = verId;
      if(loginController.loginData.value.loginType == "login"){
        loginController.otp();
        print("Otp activated");
      }
      else{
        loginController.sotp();
        print("sOtp activated");
      }
      verifinaction.value = verId!;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;

    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,);
  }
 
  initializeUserModel(String userId)  async{
    userModel.value =await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

}
