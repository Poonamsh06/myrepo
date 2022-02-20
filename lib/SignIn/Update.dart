import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_web/firebase_messaging_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohit/Functions/ReverseGeocode.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/SignIn/starter_controller.dart';
import 'package:pujapurohit/Starter/splash_screen.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:pujapurohit/controller/loginController.dart';

class Update extends StatefulWidget{
  @override
  _UpdateState createState() => _UpdateState();
}
String? name;
String? email;
String? lat;
String? lng;
String addresss = "Tap on locate icon";
int? age;

class _UpdateState extends State<Update> {
    String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();

    setState(() {
      token = token;
    });

    print(token);
  }

  @override
  void initState() {
    
    super.initState();
  }
  @override
  getLocation()async{
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     String address = await AsistentMethod.searchCoordinateAddress(position.latitude.toString(),position.longitude.toString());
    setState(() {
      lat= position.latitude.toString();
      lng = position.longitude.toString();
       addresss = address;
    });
  
  }
  
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AuthController authController = Get.find();
    LoadController loadController = Get.put(LoadController());
    StarterController starterController = Get.put(StarterController());
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body:  Container(
        width: ResponsiveWidget.isSmallScreen(context)? width:width*0.6,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text1(max: 20, data: "Update", min: 18,clr: Colors.black,weight: FontWeight.w600,),
                  SizedBox(height:10),
                  InkWell(
                    onTap: (){
                     authController.signOut();
                    },
                    child: Row(

                          children:[
                            SizedBox(width:10),
                            Text1(data: "or", max: 12, min: 11,weight:FontWeight.w600,clr:Colors.black54),
                            SizedBox(width:10),
                            Text1(data: "Log Out", max: 12, min: 11,weight:FontWeight.w600,clr:Colors.orangeAccent)
                          ],
                        
                      ),
                  ),                    
                SizedBox(height:10),
                                Container(
                                  height:1,
                                  width:20,
                                  color:Colors.black
                                )
                              ],
              ),),
              Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(5),
                
                height: 100,width: 100,
                decoration: BoxDecoration  (
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child:Image.network("https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2Fganesha%20cartoon%201.png?alt=media&token=57237ae5-ae7c-47da-ade5-68a48b0d026e",fit: BoxFit.fill,)
                ),
              ),)
          ]
        ),
         TextFormField(
                     decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Name",
                    ),
                    onChanged: (value){
                      name = value;
                    },
                   ),
                   SizedBox(height:10),
          TextFormField(
                     decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Email",
                    ),
                    onChanged: (value){
                      email = value;
                    },
                    
                   ),                  
                   SizedBox(height:10),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                     decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Age",
                    ),
                    onChanged: (value){
                      age = int.parse(value);
                    },
                    
                   ),
                   SizedBox(height:10),
                    TextFormField(
                      readOnly: true,
                     decoration: new InputDecoration(
                       suffixIcon: IconButton(icon: Icon(Icons.gps_fixed,size: 18,),onPressed: (){getLocation();}),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "$addresss",
                    ),
                    
                   ),
                   SizedBox(height:10),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Obx((){
                         return loadController.load.value.active? Container(height:80,width:80,child:Loader()):ElevatedButton(onPressed: ()async{
                         loadController.updateLoad();
                        await authController.user!.updateProfile(displayName: '$name',photoURL:"https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fblank-profile-picture-png-removebg-preview.png?alt=media&token=56909aea-e9d5-41b5-8bed-2b147e474a41").catchError((e){Get.snackbar("Error", e.message);});
                        await  authController.user!.updateEmail('$email').catchError((e){Get.snackbar("Error", e.message,backgroundColor: Colors.white);});
                        await FirebaseFirestore.instance.collection('users').doc('${authController.user!.uid}').set({
                                  "name": name,
                                    "uid": authController.user!.uid,
                                    "email": email,
                                    "age": age,
                                    "phone":authController.user!.phoneNumber,
                                    "photoUrl":"https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fblank-profile-picture-png-removebg-preview.png?alt=media&token=56909aea-e9d5-41b5-8bed-2b147e474a41",
                                    "lat":lat,
                                    "lng":lng,
                                    "address":addresss,
                                    "token": 'token',
                                    "joining":FieldValue.serverTimestamp()
                              }).catchError((e){Get.snackbar("Error", e.message);}).whenComplete(() {
                                loadController.updateLoad();
                                authController.reloadCompleted = false.obs;
                                authController.signOut();
                                starterController.updateValue();
                                loginController.signin();
                                Get.snackbar("Data Updated", "Recent log in rquired");
                               
                              }).whenComplete(() {
                                   Get.to(SplashScreen());
                              });
                       }, child:Text1(data: "Update Data", max: 14, min: 12,clr: Colors.white,),
                       style: ElevatedButton.styleFrom(primary:Colors.orangeAccent,shape: StadiumBorder()));
                       }),

                      //  TextButton(onPressed: (){
                        
                      //  }, child: Text("Show token"))
                     ],
                   )
                   
        ]
      ),
    ),
    );
  }
}

class UpdateLoad extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment : MainAxisAlignment.center,
            
            children:[
              Container(width: 80,height:80,
              child: Loader(),
              ),
              SizedBox(height:20),
              TextButton(onPressed: (){
                Get.to(SplashScreen());
              }, child: Text1(data: "Refresh",max: 16,min: 12,clr: Colors.black54,))

            ]
          ),
        ],
      ),
    );
  }

}