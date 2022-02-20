
import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/Checkout/stripe_checkout_web.dart';
import 'package:pujapurohit/Pages/new_pandit_home.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/event_controller.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'dart:ui' as ui;
import '../Controllers/pandits_controller.dart';
import '../detail.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'dart:js';


class Registration_Form extends StatefulWidget{
  @override
  _Registration_FormState createState() => _Registration_FormState();
}
enum AppState {
  free,
  picked,
  cropped,
}

class _Registration_FormState extends State<Registration_Form> {
  final RegistraionField registerForm = Get.put(RegistraionField());
  late AppState appstate;
  File? SelectImageFile;
  File? imageFile;
  String indx = Get.parameters["id"]!;
  List<XFile>? _imageFileList;
  final LoadController loadController = Get.put(LoadController());
  XFile? imageFile1;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }
  String? name;
  String? state='Select State';
  String? district = 'Select District';
  dynamic _pickImageError;

  String? _retrieveDataError;
  var uuid = Uuid();
  String? photoUrl;
  XFile ? ImageFile;
  final ImagePicker _picker = ImagePicker();
  


  uploadImage(BuildContext context)async{

    final   firebase_storage.Reference firebaseStorage = firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child("eventimages").
    child('${uuid.v1()}.jpg');
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {'picked-file-path': _imageFileList![0].path});
    if(kIsWeb){
      firebase_storage.UploadTask task = firebaseStorage.putData(await _imageFileList![0].readAsBytes(),metadata);
      var dowurl = await (await task.whenComplete(() {print("url downloaded");})).ref.getDownloadURL();
      String url = dowurl.toString();
      task.then((value)async{
        setState(() {
          photoUrl=url;
        });
      });
    }
    firebase_storage.UploadTask task = firebaseStorage.putFile(imageFile!,metadata);
    var dowurl = await (await task.whenComplete(() => print("Task Completed"))).ref.getDownloadURL();
    String url = dowurl.toString();
    task.then((value)async{
      setState(() {
        photoUrl=url;
      });
    });

  }

  String? _chosenValue;
  String? _chosenValueG;
  //final EventController  eventController= Get.put(EventController());
  final AuthController authController = Get.put(AuthController());
  
  


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
        builder: (context, snapshot) {
           if(snapshot.data==null){
                    return Center(child: Loader(),);
                  }
                  List <dynamic> events = snapshot.data!.get("events");
          return   Column(
            children: [
               SizedBox(height: height*0.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0,top:25),
                      child: Align(
                        alignment : Alignment.topLeft,
                        child: Container(
                          height:35,width:35,
                          padding :  EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Color(0xff181c2c),
                              shape: BoxShape.circle
                          ),
                          child: IconButton(
                            onPressed: (){
                              Get.back();
                            },
                            icon: Icon(Icons.close,size: 12,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                    ),
              Padding(
                padding: ResponsiveWidget.isSmallScreen(context)? EdgeInsets.all(0):EdgeInsets.only(left:width*0.2,right:width*0.2),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: LightColors.shadowColor,blurRadius: 20)]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Form(
                          key:registerForm.loginFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Padding(
                            padding: EdgeInsets.only(left: width*0.08,right: width*0.08,top: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     _imageFileList!=null ?InkWell(
                                      onTap: ()async{
                                       final pickedFileList = await _picker.pickMultiImage();
                                          setState(() {
                                            _imageFileList = pickedFileList;
                                          });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: ResponsiveWidget.isSmallScreen(context)? height*0.3:ResponsiveWidget.isSmallScreen(context)? height*0.25: height*0.3,
                                        width: ResponsiveWidget.isSmallScreen(context)?width*0.5 :width*0.2,
                                        decoration: BoxDecoration(
                                           // color: context.theme.backgroundColor,
                                          // borderRadius: BorderRadius.circular(20),
                                          //   boxShadow: [
                                          //     BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                                          //   ]
                                        ),
                                        child:ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    key: UniqueKey(),
                                                    itemCount: _imageFileList!.length,
                                                    itemBuilder: (context, index) {
                                                    return kIsWeb
                                                        ? Image.network(
                                                            _imageFileList![index].path,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            File(
                                                              _imageFileList![index].path,
                                                            ),
                                                            fit: BoxFit.fill,
                                                          );
                                                  }
                                                ),
                                      ),
                                    ): InkWell(
                                      onTap: ()async{
                                       final pickedFileList = await _picker.pickMultiImage();
                                          setState(() {
                                            _imageFileList = pickedFileList;
                                          });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: ResponsiveWidget.isSmallScreen(context)? height*0.3:ResponsiveWidget.isSmallScreen(context)? height*0.25: height*0.3,
                                        width: ResponsiveWidget.isSmallScreen(context)?width*0.5 :width*0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            
                                            boxShadow: [
                                              BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                                            ]
                                        ),
                                        child: Text1(data: "Pick Image", max: 12, min: 11),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Container(
                                 // margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.only(left:20),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0))),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.0),
                                  onChanged: (value){
                                      name = value;
                                  },
                                    maxLength: 10,
                                    decoration: InputDecoration(
      
                                        border: InputBorder.none,
                                        hintText: 'Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Montserrat',
                                            fontSize: 14.0),
                                        contentPadding: EdgeInsets.only(top: 10.0),
                                        ),
      
      
                                  ),
      
                                ),
      
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Row(
                                   children: [
                                     DropdownButton<String>(
                                         focusColor:Colors.white,
                                         value: _chosenValue,
                                         //elevation: 5,
                                         style: TextStyle(color: Colors.white),
                                         iconEnabledColor:Colors.grey,
                                         items: events[int.parse(indx)]["age"]!.cast<String>().map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(value,style:TextStyle(color:Colors.grey),),
                                           );
                                         }).toList(),
                                         hint:Text(
                                           "Age",
                                           style: TextStyle(
                                               color: Colors.grey,
                                               fontSize: 14,
                                               fontWeight: FontWeight.w500),
                                         ),
                                         onChanged: (String? value) {
                                           setState(() {
                                             _chosenValue = value;
                                           });
                                         },
                                       ),
                                    
                                    
                                     Spacer(),
                                    DropdownButton<String>(
                                         focusColor:Colors.white,
                                         value: _chosenValueG,
                                         //elevation: 5,
                                         style: TextStyle(color: Colors.white),
                                         iconEnabledColor:Colors.grey,
                                         items: events[int.parse(indx)]["gender"]!.cast<String>().map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(value,style:TextStyle(color:Colors.grey),),
                                           );
                                         }).toList(),
                                         hint:Text(
                                           "Gender",
                                           style: TextStyle(
                                               color: Colors.grey,
                                               fontSize: 14,
                                               fontWeight: FontWeight.w500),
                                         ),
                                         onChanged: (String? value) {
                                           setState(() {
                                             _chosenValueG = value;
                                           });
                                         },
                                       )
                                     
                                     
                                   ],
                                 ),
                               ),
      
                                Obx((){

                                  return loadController.load.value.active?SizedBox(height: 50,width: 50,child: Loader(),):ElevatedButton(onPressed: ()async{
                                    final EventControllerPayment eventControllerPayment = Get.put(EventControllerPayment());
                                    registerForm.checkLogin();
                                    if(events[int.parse(indx)]["price"]==0){
                                      if(name==null || _imageFileList ==null || _chosenValue==null || _chosenValueG ==null){
                                        return Get.snackbar("Info", "Please fill all fields properly",backgroundColor: Colors.white);
                                      }
                                      else{
                                        loadController.updateLoad();
                                        uploadImage(context);
                                        
                                        Future.delayed(Duration(seconds: 10),
                                                ()async{
                                              await FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${events[int.parse(indx)]["name"]}/${authController.user!.uid}").set({
                                                'name': "$name",
                                                'age':_chosenValue,
                                                'votes':0,
                                                'voters':FieldValue.arrayUnion([]),
                                                'image':'$photoUrl',
                                                'vote':false,
                                                'gender':_chosenValueG,
                                                'event':'${events[int.parse(indx)]["name"]}',
                                                'num':FieldValue.increment(events[int.parse(indx)]["participants"]!.length+1),
                                                'id':authController.user!.uid,
                                                'puja':'${events[int.parse(indx)]["puja"]}',
                                                'payment':false,
                                              }).whenComplete(() async{
                                                List<dynamic> participants1 = snapshot.data!.get("${events[int.parse(indx)]["name"]}P");
                                                List<dynamic> total_V= participants1;
                                                participants1.add(authController.user!.uid);
                                                await FirebaseFirestore.instance.doc('/PujaPurohitFiles/events').update(({
                                                  '${events[int.parse(indx)]["name"]}P':total_V
                                                }));
                                                Get.back();
                                                loadController.updateLoad();
                                              });
                                            }
                                        );
      
                                      }
                                    }
                                    else{                                       
                                      if(name==null || _imageFileList == null || _chosenValue==null || _chosenValueG ==null){
                                        return Get.snackbar("Info", "Please fill all fields properly",backgroundColor: Colors.white);
                                      }
                                      else{   
                                        loadController.updateLoad();
                                        uploadImage(context);  
                                            Future.delayed(Duration(seconds: 10),()async{
                                              eventControllerPayment.updatePayemnt('$name','$_chosenValue','$photoUrl','$_chosenValueG','${events[int.parse(indx)]["name"]}',events[int.parse(indx)]["participants"]!.length,'${events[int.parse(indx)]["puja"]}',snapshot.data!.get("${events[int.parse(indx)]["name"]}P"));
                                            }).whenComplete((){
                                                     redirectToCheckout(context,int.parse(indx));
                                                    // Get.toNamed('/success?id=$indx');
                                                    // loadController.updateLoad();
                                            });                                                                                      
                                      }
                                    }
                                  }, child: Text1(data: "Register", max: 20, min: 18,weight: FontWeight.w300,),style: ElevatedButton.styleFrom(
                                      primary: Color(0xff181c2c),
                                      shape: StadiumBorder()
                                  ),);
      
                                }),
                                SizedBox(height: height*0.2,)
                              ],
                            ),
                          )),
                  SizedBox(height: 10,),
                      Text1(data: "Note :", max: 24, min: 20,clr: Colors.black54,weight: FontWeight.w600,),
                      SizedBox(height: 10,),
                      Text1(data: "${events[int.parse(indx)]["note"]}", max: 16, min: 12,clr: Colors.black54,)
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class RegistraionField extends GetxController{
  final GlobalKey<FormState>loginFormKey=GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController emailContrller;
  late TextEditingController shopNameController;
  late TextEditingController addressController;
  late TextEditingController otpController;
  var email='';
  var password ='';
  var shopName='';
  var address='';



  @override
  void onInit(){
    super.onInit();
    passwordController=TextEditingController();
    emailContrller=TextEditingController();
    shopNameController=TextEditingController();
    addressController=TextEditingController();
    otpController=TextEditingController();
  }

  @override
  void onClose(){
    passwordController.dispose();
    emailContrller.dispose();
    shopNameController.dispose();
    addressController.dispose();
    otpController.dispose();
  }
  String? validatePassword(String value){
    if(value.length<6){
      return "Not valid phoneNumber";
    }
    return null;
  }
  String? validateemail(String value){
    if(!GetUtils.isEmail(value)){
      return "Not valid email";
    }
  }
  String? validataddress(String value){
    if(value.length<5){
      return "Not valid address";
    }
  }
  String? validatename(String value){
    if(value.length>15 && value.length<1){
      return "Enter Shopname in less than 15 letter's";
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