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
import 'package:flutter/widgets.dart';
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
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/youtube_player.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'dart:ui' as ui;
import '../account.dart';
import '../Controllers/pandits_controller.dart';
import '../detail.dart';
import 'event_registration.dart';

class EventDetail extends StatefulWidget{
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
    String _url = 'https://play.google.com/store/apps/details?id=com.pujapurohit.android.infopujapurohit';
    Future<void> _launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }
  final LoadController loadController = Get.put(LoadController());
  final AuthController authController = Get.put(AuthController());
  String indx = Get.parameters["event"]!;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    


    final EventController  eventController= Get.put(EventController());
    return Scaffold(
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
          builder: (context, snapshot) {
             if(snapshot.data==null){
                    return Center(child: Loader(),);
                  }
                  List <dynamic> events = snapshot.data!.get("events");
            return Column(
              children: [
                 Stack(
                    children: [
                     SizedBox(
                       width: width,
                       child: ResponsiveWidget.isSmallScreen(context)?Image.network("${events[int.parse(indx)]["image"]}"):Image.network("${events[int.parse(indx)]["bigS"]}",fit: BoxFit.fitWidth,)),
                      Padding(
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
                              onPressed: (){Get.back();},
                              icon: Icon(Icons.arrow_back_ios,size: 12,color: Colors.white,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
               
               
                SizedBox(height: 20,),
                Padding(
                  padding: ResponsiveWidget.isSmallScreen(context)?EdgeInsets.all(15):EdgeInsets.only(top:15,left:width*0.1,right:width*0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                            Icon(Icons.location_on_outlined,size: 14,color: Colors.black54, ),
                            SizedBox(width:5),
                          Text1(data:"${events[int.parse(indx)]["place"]}", max: 14, min: 12,clr: Colors.black54,),
                          Spacer(),
                          Text1(data: "${events[int.parse(indx)]["duration"]}", max: 14, min: 12,clr: Colors.black54,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text1(data:"${events[int.parse(indx)]["participants"]!.length} Participants", max: 14, min: 12,clr: Colors.black54,),
                          Spacer(),
                          Text1(data: "${events[int.parse(indx)]["total_days"]}", max: 14, min: 12,clr: Colors.black54,)
                        ],
                      ),
                      SizedBox(height: 20,),
                     authController.user==null? Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         InkWell(
                           onTap: (){
                             Get.to(Account());
                           },
                           child: Container(
                             width: 200,
                              color: Color(0xff181c2c),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              
                              child: Text1(data:"Login", max: 14, min: 12,clr: Colors.white,),
                            ),
                         ),
                       ],
                     ) :
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buttonFocus(events[int.parse(indx)]["status"],events)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text1(data: "About", max: 24, min: 20,clr: Color(0xff181c2c),),
                      SizedBox(height: 20,),
                      Text1(data: "${events[int.parse(indx)]["about"]}", max: 14, min: 12,clr: Colors.black54,),
                      SizedBox(height: 20,),
                     
                     // loggeduggestions("${eventController.eventData.value.puja}"),
                      SizedBox(height: 20,),
                      
        
                    ],
                  ),
                ),
        
                Padding(
                  padding: ResponsiveWidget.isSmallScreen(context)?EdgeInsets.all(15):EdgeInsets.only(top:15,left:width*0.1,right:width*0.1),
                  child: bottomSection(events[int.parse(indx)]["status"],events,context)
                ),
                // ResponsiveWidget.isSmallScreen(context)?MobileBottomBar():NewBottomBar()
              ],
            );
          }
        ),
      ),
    );
  }

  Widget bottomSection(String status,List<dynamic>events,BuildContext context){
    
    double height = MediaQuery.of(context).size.height;
    if(status=="upcoming"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text1(data: "Terms and Condition", max: 24, min: 20,clr: Color(0xff181c2c),),

          ListView.builder(
              itemCount: events[int.parse(indx)]["terms"]!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_,index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text1(data: "${events[int.parse(indx)]["terms"]![index]}", max: 14, min: 12,clr: Colors.black54,),
                );
              })
        ],
      );
    }
    if(status=="live"){
      return Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text1(data: "Vote participants", max: 24, min: 20),
              ],
            ),
          ),
          SizedBox(height: 25,),

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("PujaPurohitFiles/events/${events[int.parse(indx)]["name"]}").orderBy("votes").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.data==null){
                  return CircularProgressIndicator();
                }
                List<dynamic> snaps =snapshot.data!.docs;
                return ResponsiveWidget.isSmallScreen(context)?ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snaps.length,
                    itemBuilder: (_,index){
                      return VotersCard(snaps, index,height);
                    }): GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                          crossAxisCount: ResponsiveWidget.isMediumScreen(context)?2:4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: ResponsiveWidget.isMediumScreen(context) ?0.6:0.4,

                                      ),  
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snaps.length,
                                    itemBuilder: (_, index) {
                                      return VotersCard(snaps, index,height);
                                    }, 
                                  );
              }
          ),
        ],
      );
    }
    return Column(
      children: [
        Text1(data: "Top 3", max: 28, min: 24,weight: FontWeight.bold,),
        SizedBox(height: 10,),
        SizedBox(
            height: height*0.2,
            child: ListView.builder(
                itemCount: events[int.parse(indx)]["top3"]!.length,
                scrollDirection: Axis.horizontal,
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_,index){
                  return InkWell(
                    onTap: (){
                      Get.toNamed('/imageview?id=${events[int.parse(indx)]["top"]![index]["id"]}&vote=false&name=${events[int.parse(indx)]["name"]}');
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      height: 300,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${events[int.parse(indx)]["top3"]![index]["image"]}"),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  );
                }),
          )
       
       
      ],
    );
  }

  Column VotersCard(List<dynamic> snaps, int index,double height) {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snaps[index]["image"]),

                          ),
                          title: Text1(data: "${snaps[index]["name"]}", max: 14 , min: 12,clr: Colors.black87,weight: FontWeight.bold,),
                        ),
                        Container(
                          height:height*0.35,
                          child: InkWell(
                              onTap:(){
                                Get.toNamed('/imageview?id=${snaps[index]["id"]}&vote=${snaps[index]["vote"]}&name=${snaps[index]["event"]}');
                              },
                              child: Image.network("${snaps[index]["image"]}",fit:BoxFit.fill ,)),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.data==null){
                                    return Text1(data: "Loading...", max: 12, min: 11);
                                  }
                                  return Padding(
                                    padding:  EdgeInsets.only(right:ResponsiveWidget.isSmallScreen(context)?0.0:40.0),
                                    child: Row(

                                      children: [
                                        snaps[index]["voters"].contains('${authController.user!.phoneNumber}')?
                                        InkWell(
                                            onTap: (){
                                              List<dynamic> voters = snapshot.data!.get("${snaps[index]['event']}V");
                                              List<dynamic> local_voters = snaps[index]['voters'];
                                              List<dynamic> total_V= voters;
                                              voters.contains('${authController.user!.phoneNumber}')?voters.remove('${authController.user!.phoneNumber}'):(){};

                                              FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                                '${snaps[index]['event']}V':total_V
                                              });
                                              List<dynamic> total_L= local_voters;
                                              local_voters.contains('${authController.user!.phoneNumber}')?local_voters.remove('${authController.user!.phoneNumber}'):(){};

                                              FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${snaps[index]['event']}/${snaps[index]['id']}").update({
                                                'voters':total_L,
                                                'votes':FieldValue.increment(-1)
                                              });

                                            },
                                            child: Icon(CupertinoIcons.heart_fill ,color: Color(0xff181c2c),)) :
                                        InkWell(
                                            onTap: (){
                                              if(snapshot.data!.get("${snaps[index]["event"]}V").contains('${authController.user!.phoneNumber}')){
                                                Get.snackbar("Info", "You have already used your vote",backgroundColor: Colors.white);
                                              }
                                              else{
                                                List<dynamic> voters = snapshot.data!.get("${snaps[index]['event']}V");
                                                List<dynamic> local_voters = snaps[index]['voters'];
                                                List<dynamic> total_V= voters;
                                                voters.contains('${authController.user!.phoneNumber}')?(){}:voters.add('${authController.user!.phoneNumber}');

                                                FirebaseFirestore.instance.doc("PujaPurohitFiles/events").update({
                                                  '${snaps[index]['event']}V':total_V
                                                });
                                                List<dynamic> total_L= local_voters;
                                                local_voters.contains('${authController.user!.phoneNumber}')?(){}:local_voters.add('${authController.user!.phoneNumber}');

                                                FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${snaps[index]['event']}/${snaps[index]['id']}").update({
                                                  'voters':total_L,
                                                  'votes':FieldValue.increment(-1)
                                                });

                                              }
                                            },
                                                  child: Icon(CupertinoIcons.heart,)),
                                        Spacer(),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                                color:Color(0xff181c2c),

                                            ),
                                            child: Text1(data: "${snaps[index]["voters"].length} votes", max: 14 , min: 12,clr: Colors.white,weight: FontWeight.bold,)),
                                        Spacer(),
                                        Obx((){
                                        return loadController.load.value.active?SizedBox(height: 50,width:50,child: Loader(),): InkWell(
                                             onTap: ()async{
                                               Share.share('Visit the link and vote ${snaps[index]["name"]} at Puja Purohit pujapurohit.in/#/imageview?id=${snaps[index]["id"]}&vote=${snaps[index]["vote"]}&name=${snaps[index]["event"]}', subject: 'Puja Purohit Contest');

                                             },
                                             child: Icon(CupertinoIcons.share));
                                       })

                                      ],
                                    ),
                                  );
                                }
                              ),

                              SizedBox(height: 20,),
                            ],
                          ),
                        ),

                      ],
                    );
  }

  Widget buttonFocus(String status,List<dynamic> events) {
    //final EventController eventController = Get.put(EventController());
    final AuthController authController = Get.put(AuthController());
     
    if(status== "previous"){
      return InkWell(
        onTap: (){

        },
        child: Container(
          color: Color(0xff181c2c),
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          //margin: EdgeInsets.only(left:width*0.01,right:width*0.1 ),
          child: Text1(data: "Winner Announced", max: 14, min: 12,clr: Colors.white,),
        ),
      );
    }
    if(status== "live"){

      return InkWell(
        onTap: (){

        },
        child: Container(
          color: Color(0xff181c2c),
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          //margin: EdgeInsets.only(left:width*0.01,right:width*0.1 ),
          child: Text1(data: "Vote Participants", max: 14, min: 12,clr: Colors.white,),
        ),
      );
    }
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data==null){
          return Loader();
        }
        List<dynamic> participants = snapshot.data!.get("${events[int.parse(indx)]["name"]}P");
        return InkWell(
                        onTap: (){
                         // eventController.updateparticipants(participants);
                          if(participants.contains("${authController.user!.uid}")){
                            Get.snackbar("Info", "Already Participated",backgroundColor: Colors.white);
                            Get.toNamed('/imageview?id=${authController.user!.uid}&vote=false&name=${events[int.parse(indx)]["name"]}');
                          }
                          else{
                            Get.toNamed('/registration?id=$indx');
                          }

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: participants.contains("${authController.user!.uid}")? Color(0xff181c2c):Colors.white,
                            boxShadow: [
                              BoxShadow(color: participants.contains("${authController.user!.uid}")?Color(0xff181c2c).withOpacity(0.2):LightColors.shadowColor,blurRadius: 20)
                            ]
                          ),

                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          //margin: EdgeInsets.only(left:width*0.01,right:width*0.1 ),
                          child: Text1(data:participants.contains("${authController.user!.uid}")? "View Participant":"Participate Now", max: 14, min: 12,clr: participants.contains("${authController.user!.uid}")? Colors.white:Color(0xff181c2c),),
                        ),
                      );
      }
    );
  }
  GetX<UserController> loggeduggestions(String snapshot) {
    return GetX<UserController>(
      init: Get.put<UserController>(UserController()),
      builder: (UserController userController){
        if(userController.userModel.value.lat == null){
          return Center(child:SizedBox(height:50,child: Loader(),));
        }
        return   GetX<PanditKeywordController>(
          init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'$snapshot',lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'))),
          builder: (PanditKeywordController panditController) {
            if (panditController != null && panditController.pandits != null) {
              if(panditController.panditList.value!.isEmpty){
                return SizedBox();
              }
              return Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 220.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:panditController.panditList.value!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'));
                        },
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              );

            } else {
              return Center(child: SizedBox(
                  height: 50,width: 50,
                  child: Loader()));
            }
          },
        );
      },
    );
  }


}
