
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/User.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';


class UserController extends GetxController{

  Rx<UserModel> userModel = UserModel().obs;
  final AuthController authController = Get.find();

  @override
  void onInit(){
    print('Listening user with uid ____ ${authController.user!.uid}');
    initializeUserModel(authController.user!.uid);

    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  
  initializeUserModel(String uid)  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('users')
        .doc('$uid')
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

}