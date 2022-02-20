import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohit/Functions/ReverseGeocode.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:pujapurohit/controller/loginController.dart';


class Auth extends StatefulWidget{

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
 LoginController loginController = Get.put(LoginController());

 LoginField loginField=Get.put(LoginField());

 AuthController authController = Get.put(AuthController());

 LoadController loadController = Get.put(LoadController());

 final LocationController locationController = Get.put(LocationController());
  String? lat;
  String? lng;
  String addresss = "Tap on Get Address";
 getLocation()async{
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     String address = await AsistentMethod.searchCoordinateAddress(position.latitude.toString(),position.longitude.toString());
    setState(() {
      lat= position.latitude.toString();
      lng = position.longitude.toString();
       addresss = address;
    });
  
  }

  @override
  Widget build(BuildContext context) {
    double height=Get.height;
    double width=Get.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,

      body:Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(left:30,right:30,top:40),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Obx((){return toprow(context);}),
            SizedBox(height:20),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: loginField.loginFormKey,
              child:Column(
                children:[
                   Obx(()=>buildTextFormField(context)) ,
                   SizedBox(height:10),
                   Obx((){
                     return address();
                   }),
                   SizedBox(height:10),
                   Obx((){
                     return loadController.load.value.active?Container(height:80,width:80,child:Loader()):loginbutton(height, width,context);
                   }),


                ]
              ) )
          ]
        ),
      ),
    ),
    );
  }

  Widget address() {
   if(loginController.loginData.value.loginType == "Update"){
     
   return  Text("Address : $addresss");
   }
   if(loginController.loginData.value.loginType == "signup"){
      
   return  Text("Address : $addresss");
   }
  return SizedBox();
  }

 Widget locateButton(double height, double width,String data,VoidCallback tap) {
    return InkWell(
      onTap: tap,
          child: Container(
                             padding: EdgeInsets.all(10),
                             alignment: Alignment.center,
                             height: height*0.06,
                             //width: width*0.4,
                             decoration: BoxDecoration(
                               color: Colors.orangeAccent,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Text1(data: "$data", max: 22, min: 14,clr: Colors.white)

                           ),
    );
  }

  Widget loginbutton(double height, double width,BuildContext context) {
    if(loginController.loginData.value.loginType=="Update"){
       return Column(
         children: [
           SizedBox(
                   child:locateButton(height*0.9, width*0.3, "Get Address", () {
                      if(locationController.location.value.permission == LocationPermission.deniedForever){
                          Get.snackbar("Location Error", "Kindly get address after allowing location.",backgroundColor: Colors.white);
                       }
                       else{
                          getLocation();
                       }
                    })
                   ),
                   SizedBox(height:10),
           SizedBox(
                     child: locateButton(height*0.9, width*0.3, "Update", () { 
                       if(locationController.location.value.address == null){
                                    Get.snackbar("Location Error", "Kindly get address after allowing location.",backgroundColor: Colors.white);
                       }
                       else{
                         // loginField.checkLogin();
                           authController.updateuser();
                       }
                     }),
                   ),
         ],
       );
    }
    
    if(loginController.loginData.value.loginType=="signup"){
       return Column(
         children: [
           SizedBox(
                   child:locateButton(height*0.9, width*0.3, "Get Address", () {
                      if(locationController.location.value.permission == LocationPermission.deniedForever){
                          Get.snackbar("Location Error", "Kindly get address after allowing location.",backgroundColor: Colors.white);
                       }
                       else{
                          getLocation();
                       }
                    })
                   ),
                   SizedBox(height:10),
           SizedBox(
                     child: locateButton(height*0.9, width*0.3, "Sign Up", () { 
                       if(addresss == "Tap on Get Address"){
                                    Get.snackbar("Location Error", "Kindly get address after allowing location.",backgroundColor: Colors.white);
                       }
                       else{
                         loadController.updateLoad();
                          loginField.checkLogin();
                           authController.webverifyPhone('${loginField.phone}');
                       }
                      // loginField.checkLogin();
                      //      authController.webverifyPhone('${loginField.phone}');
                     }),
                   ),
         ],
       );
    }
    
    if(loginController.loginData.value.loginType=="otp"){
       return SizedBox(
                child: locateButton(height*0.9, width*0.3, "Verified and Proceed", () async{
                  
                   authController.myCredential(loginField.otp);
                print('Otp iss   ${loginField.otp}');
                 }),
               );
    }
    if(loginController.loginData.value.loginType=="sotp"){
       return SizedBox(
                child: locateButton(height*0.9, width*0.3, "Verified and Proceed", ()async{
                    loadController.updateLoad();
                    await authController.signupmyCredential(loginField.otp,lat!,lng!,addresss);
                    
                 }),
               );
    }
    return loadController.load.value.active?Loader():SizedBox(
                 child:locateButton(height*0.9, width*0.3, "Login",() {
                   loadController.updateLoad();
                    loginField.checkLogin();
                   authController.webverifyPhone('${loginField.phone}');
                 })
               );
  }

  Column buildTextFormField(BuildContext context) {
    if(loginController.loginData.value.loginType=="sotp"){
      return Column(
      children: [
        TextFormField(
                     decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Enter OTP",
                    ),
                    maxLength: 6,
                     controller: loginField.otpController,
                     onChanged: (value){
                       loginField.otp=value;
                     },
                   ),
      ],
    );
     }
    if(loginController.loginData.value.loginType=="otp"){
      return Column(
      children: [
        TextFormField(
                     decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Enter OTP",
                    ),
                    maxLength: 6,
                     controller: loginField.otpController,
                     onChanged: (value){
                       loginField.otp=value;
                     },
                   ),
      ],
    );
     }if(loginController.loginData.value.loginType=="login"){
      return Column(
      children: [
        TextFormField(
                     decoration: new InputDecoration(
                       prefixText: "+91",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Phone Number",
                    ),
                     validator: (value){
                       return loginField.validatePhone(value! );
                     },
                     controller: loginField.phoneController,
                     onSaved: (value){
                       loginField.phone=value!;
                     },
                   ),
      ],
    );
     }
    
      return Column(
        children: [
           TextFormField(
                     decoration: new InputDecoration(
                       prefixText: "+91",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    
                    hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12),
                    hintText: "Phone Number",
                    ),
                     validator: (value){
                       return loginField.validatePhone(value! );
                     },
                     controller: loginField.phoneController,
                     onSaved: (value){
                       loginField.phone=value!;
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
                    hintText: "Name",
                    ),
                     validator: (value){
                       return loginField.validatename(value! );
                     },
                     controller: loginField.nameController,
                     onSaved: (value){
                       loginField.name=value!;
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
                     validator: (value){
                       return loginField.validateemail(value!);
                     },
                     controller: loginField.emailContrller,
                     onSaved: (value){
                       loginField.email=value!;
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
                    hintText: "Age",
                    ),
                     validator: (value){
                       return loginField.validatage(value! );
                     },
                     controller: loginField.ageController,
                     onSaved: (value){
                       loginField.age=value!;
                     },
                   ),
                   SizedBox(height:10),
                   
                   
        ],
      );
    

  }

  Widget toprow(BuildContext context){
    if(loginController.loginData.value.loginType=="login"){
      return buildRow(context,'Login','create an account');
    }
    if(loginController.loginData.value.loginType=="otp"){
      return buildRow(context,'Verify','Change ${loginField.phone}');
    }
     if(loginController.loginData.value.loginType=="sotp"){
      return buildRow(context,'Verify','Change ${loginField.phone}');
    }
    if(loginController.loginData.value.loginType=="signup"){
        return buildRow(context,'Sign Up','login to your account');
    }
    if(loginController.loginData.value.loginType=="Update"){
        return buildRow(context,'Update','log out');
    }
    return buildRow(context,'Sign up','login to your account');
  }

  Row buildRow(BuildContext context,String txt1,String txt2) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text1(max: 20, data: "$txt1", min: 18,clr: Colors.black,weight: FontWeight.w600,),
                  SizedBox(height:10),
                InkWell(
                    onTap: (){
                      if(loginController.loginData.value.loginType =="login"){
                       return loginController.signup();
                      }
                      if(loginController.loginData.value.loginType =="Update"){
                        authController.signOut();
                      }
                      if(loginController.loginData.value.loginType =="otp"){
                        loginController.signup();
                      }
                     return  loginController.signin();
                    },
                        child: RichText(
                        text: TextSpan(
                          text: ' ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'or', style: GoogleFonts.aBeeZee(fontSize: 11,color: Colors.black54,fontWeight: FontWeight.w600)),
                            TextSpan(text: ' $txt2',style: GoogleFonts.aBeeZee(color: Colors.orangeAccent,fontSize: 11,fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                  ),                    
                SizedBox(height:10),
                                Container(
                                  height:1,
                                  width:20,
                                  color:Colors.black
                                ),
                                SizedBox(height: 5,),
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
        );
  }
}
class LoginField extends GetxController{
  final GlobalKey<FormState>loginFormKey=GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController emailContrller;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController otpController;
  var email='';
  var phone ='';
  var name='';
  var age='';
  var otp='';


  @override
  void onInit(){
    super.onInit();
    phoneController=TextEditingController();
    emailContrller=TextEditingController();
    nameController=TextEditingController();
    ageController=TextEditingController();
    otpController=TextEditingController();
  }

  @override
  void onClose(){
    phoneController.dispose();
    emailContrller.dispose();
    nameController.dispose();
    ageController.dispose();
    otpController.dispose();
  }
  String? validatePhone(String value){
    if(!GetUtils.isPhoneNumber(value)){
      return "Not valid phoneNumber";
    }
    return null;
  }
  String? validateemail(String value){
    if(!GetUtils.isEmail(value)){
      return "Not valid email";
    }
  }
  String? validatage(String value){
    if(!GetUtils.isNum(value) && value.length>3 &&value.length<1){
      return "Not valid age";
    }
  }
  String? validatename(String value){
    if(value.length>15 && value.length<1){
      return "Enter name in less than 15 letter's";
    }
  }
  void checkLogin(){
    final isValid=loginFormKey.currentState!.validate();
    if(!isValid){
      return ;
    }
    loginFormKey.currentState!.save();
  }
}

class NewLogin extends StatelessWidget{
LoginController loginController = Get.put(LoginController());
 LoginField loginField=Get.put(LoginField());
 AuthController authController = Get.put(AuthController());
 LoadController loadController = Get.put(LoadController());
 final LocationController locationController = Get.put(LocationController());
 Widget toprow(BuildContext context){
    if(loginController.loginData.value.loginType=="login"){
      return buildRow(context,'Login','create an account');
    }
    if(loginController.loginData.value.loginType=="otp"){
      return buildRow(context,'Change number','OTP send to ${loginField.phone}');
    }
     if(loginController.loginData.value.loginType=="sotp"){
      return buildRow(context,'Change Number','OTP send to ${loginField.phone}');
    }
    if(loginController.loginData.value.loginType=="signup"){
        return buildRow(context,'Sign Up','login to your account');
    }
    if(loginController.loginData.value.loginType=="Update"){
        return buildRow(context,'Update','log out');
    }
    return buildRow(context,'Sign up','login to your account');
  }
  Row buildRow(BuildContext context,String txt1,String txt2) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text1(max: 20, data: "$txt1", min: 18,clr: Colors.black,weight: FontWeight.w600,),
                  SizedBox(height:10),
                InkWell(
                    onTap: (){
                      if(loginController.loginData.value.loginType =="login"){
                       return loginController.signup();
                      }
                      if(loginController.loginData.value.loginType =="Update"){
                        authController.signOut();
                      }
                      if(loginController.loginData.value.loginType =="otp"){
                        
                      }
                     return  loginController.signin();
                    },
                        child: RichText(
                        text: TextSpan(
                          text: ' ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'or', style: GoogleFonts.aBeeZee(fontSize: 11,color: Colors.black54,fontWeight: FontWeight.w600)),
                            TextSpan(text: ' $txt2',style: GoogleFonts.aBeeZee(color: Colors.orangeAccent,fontSize: 11,fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                  )            ,        
                SizedBox(height:10),
                                Container(
                                  height:1,
                                  width:20,
                                  color:Colors.black
                                ),
                                SizedBox(height: 5,),
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
        );
  }
   Widget address() {
   if(loginController.loginData.value.loginType == "Update"){
      if(locationController.location.value.address == null){
      return  Text("Click on Get Address");
    }
   return  Text("Address : ${locationController.location.value.address}");
   }
   return SizedBox();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(left:30,right:30,top:40),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Obx((){return toprow(context);}),
            SizedBox(height:20),
            // Form(
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   key: loginField.loginFormKey,
            //   child:Column(
            //     children:[
            //        Obx(()=>buildTextFormField(context)) ,
            //        SizedBox(height:10),
            //         Obx((){
            //          return address();
            //        }),
            //        SizedBox(height:10),
            //        Obx((){
            //          return loadController.load.value.active?Container(height:80,width:80,child:Loader()):loginbutton(height, width,context);
            //        }),


            //     ]
            //   ) )
          ]
        ),
      ),
    );
  }

}