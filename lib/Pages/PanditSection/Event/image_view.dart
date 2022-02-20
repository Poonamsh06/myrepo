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
import 'package:pujapurohit/Pages/new_pandit_home.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/event_controller.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/SignIn/login_page.dart';
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

class ImageView extends StatefulWidget{

  
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final LoadController loadController = Get.put(LoadController());
  GlobalKey _ssglobalKey = GlobalKey();
  String id = Get.parameters["id"]!;
  String vote = Get.parameters["vote"]!;
  String name = Get.parameters["name"]!;
  _saveScreen() async {
    loadController.updateLoad();
    RenderRepaintBoundary boundary = _ssglobalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image imageo = await boundary.toImage(pixelRatio: 10);

    ByteData? byteData =
    await (imageo.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);

      if (result["isSuccess"] == true) {
        loadController.updateLoad();

        await WcFlutterShare.share(
            sharePopupTitle: 'Vote',
            subject: 'Vote me at Puja Purohit ( Best Online Pandit Booking Platform)',
            text: "Please Vote me at Puja Purohit follow this link to vote pujapurohit.in/#/imageview?id=$id&vote=$vote&name=$name'",
            fileName: 'share.png',
            mimeType: 'image/png',
            bytesOfFile: byteData.buffer.asUint8List());
      } else {
        loadController.updateLoad();

      }
    }
  }
  // _requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //   ].request();

  //   final info = statuses[Permission.storage].toString();
  //   print(info);
  //   // _toastInfo(info);
  // }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body:
      
       GetX<AuthController>(
         init: Get.put(AuthController()),
         builder: (AuthController authController){
            if(authController.user == null){
                return Auth();
              }
           return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:  StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events/$name/$id").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.data==null){
                    return Loader();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              Get.back();
                            }, icon: Icon(Icons.close,color: Color(0xff181c2c),size: 20,)),
                            Spacer(),
                            IconButton(
                                tooltip: "Share",
                                onPressed: (){
                                  Share.share('Visit the link and vote ${snapshot.data!.get("name")} pujapurohit.in/#/imageview?id=${snapshot.data!.get("id")}&vote=$vote&name=$name', subject: 'Puja Purohit Contest');
                                  //_saveScreen();
                                }, icon: Icon(Icons.share,color: Color(0xff181c2c),size: 20,))
                          ],
                        ),
                        SizedBox(
                          height: height*0.5,
                          child: InteractiveViewer(
                              child: RepaintBoundary(
                                  key: _ssglobalKey,
                                  child: Image.network("${snapshot.data!.get("image")}",fit: BoxFit.fill,))),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text1(data: "Name : ${snapshot.data!.get("name")}", max: 26, min: 20,clr: Color(0xff181c2c),weight: FontWeight.w500,),
                            Spacer(),
                            Text1(data: "Age : ${snapshot.data!.get("age")}", max: 26, min: 20,clr: Color(0xff181c2c),weight: FontWeight.w500,),

                          ],
                        ),
                        SizedBox(height: height*0.1,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xff181c2c),
                              boxShadow: [
                                BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text1(data: "Total Votes : ${snapshot.data!.get("voters").length}", max: 24, min: 20,clr: Colors.white,weight: FontWeight.w500,),
                        ),
                        SizedBox(height: 20,),
                        snapshot.data!.get("vote")?StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                            builder: (context, mainsnapshot) {
                              if(snapshot.data==null){
                                return Loader();
                              }
                              List<dynamic> voters = mainsnapshot.data!.get("${name}V");
                              List<dynamic> local_voters = snapshot.data!.get("voters");
                              return InkWell(
                                onTap: (){
                                  if(voters.contains(authController.user!.phoneNumber)){
                                  if(local_voters.contains(authController.user!.phoneNumber)){
                                    List<dynamic> total_V= voters;
                                    voters.contains('${authController.user!.phoneNumber}')?voters.remove('${authController.user!.phoneNumber}'):(){};

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                      '${name}V':total_V
                                    });
                                    List<dynamic> total_L= local_voters;
                                    local_voters.contains('${authController.user!.phoneNumber}')?local_voters.remove('${authController.user!.phoneNumber}'):(){};

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events/$name/$id").update({
                                      'voters':total_L,
                                      'votes':FieldValue.increment(-1)
                                    });
                                  }
                                  else{
                                    Get.snackbar("Info", "You already used your vote ",backgroundColor: Colors.white);
                                  }


                                  }
                                  else{
                                    List<dynamic> total_V= voters;
                                    voters.contains('${authController.user!.phoneNumber}')?(){}:voters.add('${authController.user!.phoneNumber}');

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                      '${name}V':total_V
                                    });
                                    List<dynamic> total_L= local_voters;
                                    local_voters.contains('${authController.user!.phoneNumber}')?(){}:local_voters.add('${authController.user!.phoneNumber}');

                                    FirebaseFirestore.instance.doc("PujaPurohitFiles/events/$name/$id").update({
                                      'voters':total_L,
                                      'votes':FieldValue.increment(1)
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:local_voters.contains(authController.user!.phoneNumber)?Color(0xff181c2c):Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: LightColors.shadowColor,blurRadius: 20)
                                      ],
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Text1(data: local_voters.contains(authController.user!.phoneNumber)?"Upvoted":"Upvote", max: 24, min: 20,clr:local_voters.contains(authController.user!.phoneNumber)?Colors.white:Color(0xff181c2c),weight: FontWeight.w500,),
                                ),
                              );
                            }
                        ):SizedBox(),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text1(data: "List of Voters :", max: 20, min: 18,clr: Colors.black54,),
                          ],
                        ),
                        SizedBox(
                          height: 500,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.get("voters").length,
                              itemBuilder: (_,index){
                                List<dynamic> numbers = snapshot.data!.get("voters");
                                return Text1(data: "${index} : ${numbers[index].toString().substring(0,5) }XXXX${numbers[index].toString().substring(9,13) }", max: 14 , min: 11,clr: Colors.black54,);
                              }),
                        )
                      ],
                    ),
                  );
                }
            ),

          ),
          Obx((){
            return loadController.load.value.active?Container(
              color: Colors.black26,
              height: height,
              width: width,
              child: Center(
                child: SizedBox(
                  height: 50,width: 50,
                  child: Loader(),
                ),
              ),
            ):SizedBox();
          })
        ],
      );
         },
       )
    );
  }
}



