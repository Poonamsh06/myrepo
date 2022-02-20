import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:provider/provider.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/SignIn/login_page.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatelessWidget{
  AuthController authController = Get.find();
  void launcher()async{
    var url = 'https://play.google.com/store/apps/details?id=com.pujapurohit.android.infopujapurohit';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'carepujapurohit@gmail.com',
      queryParameters: {
        'subject': 'Feedback'
      }
  );
  void sendLauncher()async{
    await launch(_emailLaunchUri.toString());
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: GetX<AuthController>(
            init: Get.put(AuthController()),
            builder: (AuthController authController){
              if(authController.user == null){
                return Auth();
              }
              return GetX<UserController>(
                init: Get.put(UserController()),
                builder: (UserController userController){
                  return Padding(
                    padding: const EdgeInsets.only(left :12.0,right:12,top:30),
                    child: Column(
                      children: [
                        ListTile(
                            onTap: (){

                            },
                            title: Text('${userController.userModel.value.name}',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${userController.userModel.value.phone}',style: TextStyle(color: Colors.black54,)),
                                Text('Update Detail',style: TextStyle(color: Colors.orangeAccent,fontSize: 12),)
                              ],
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage('${userController.userModel.value.photo}'),
                              radius: 30,
                            )
                        ),
                        SizedBox(height: 15,),
                        ListTile(
                          onTap: (){

                          },
                          leading: Icon(CupertinoIcons.heart,color: Colors.black),
                          title: Text('Favourite',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){
                              Get.toNamed('/bookings');
                          },
                          leading: Icon(Icons.shopping_basket,color: Colors.black),
                          title: Text('Bookings',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){

                          },
                          leading: Icon(Icons.policy,color: Colors.black),
                          title: Text('Terms and Policies',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){

                          },
                          leading: Icon(Icons.support_agent_outlined,color: Colors.black),
                          title: Text('Support Chat',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){

                          },
                          leading: Icon(CupertinoIcons.question_circle,color: Colors.black),
                          title: Text('About',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){
                            sendLauncher();
                          },
                          title: Text('Send Feedback',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){
                            launcher();
                          },
                          title: Text('Download the App Now',style: TextStyle(color: Colors.black,)),
                        ),
                        ListTile(
                          onTap: (){
                            authController.signOut();
                          },
                          title: Text('Log Out',style: TextStyle(color: Colors.black,)),
                        )
                      ],
                    ),
                  );
                }
              );
            })
      ),
    );
  }

}