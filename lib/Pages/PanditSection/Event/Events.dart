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

import 'package:pujapurohit/Pages/PanditSection/Controllers/event_controller.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/Pages/new_pandit_home.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
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

class Events extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
       appBar: PreferredSize(preferredSize: Size(width,height*0.099,), 
      child:TopTabs()
      
      
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [      
            Padding(
              padding:  EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 0.0:25.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.data==null){
                    return Center(child: Loader(),);
                  }
                  List <dynamic> events = snapshot.data!.get("events");
                  Map<int, dynamic> map = events.asMap();
                  final EventController  eventController= Get.put(EventController());
                 List<dynamic> sliders = snapshot.data!.get("sliders");
                List<Widget> slides = [];
                 for(var i in sliders){
                   var link=i;
                   final sliderWidget = Container(

                     decoration:BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         image: DecorationImage(
                           image: NetworkImage("$link"),
                           fit: BoxFit.contain
                         )
                     ),
                     padding:EdgeInsets.only(left: 30,right: 30),

                   );
                   slides.add(sliderWidget);
                 }
                  return Column(
                    children: [
                      SizedBox(height: 20,),
                      ImageSlideshow(                
                        width:width*0.9,
                        height: height*0.45,
                        initialPage: 0,                      
                        indicatorColor: Colors.orangeAccent,                      
                        indicatorBackgroundColor: Colors.grey,                    
                        children:slides,                      
                        onPageChanged: (value) {
                          print('Page changed: $value');
                        },                      
                        autoPlayInterval: 5000,                      
                        isLoop: true,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                          itemBuilder:(_,index) {
                          if(map[index]["status"]=="upcoming"){
                           return  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 20,),
                               customHeading(context,"Upcoming","Event"),
                               SizedBox(height: 20,),
                               InkWell(
                                 hoverColor: Colors.transparent,
                                 onTap: (){
                                   
                                   eventController.updateupcoming(map[index]["bigS"],map[index]["youtube"],map[index]["puja"],map[index]["price"],map[index]["note"],map[index]["age"],map[index]["gender"], map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"],map[index]["participants"],map[index]["terms"]);
                                   Get.toNamed('/eventDetail?event=$index');
                                 },
                                 child: Row(
                                   mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                   children: [
                                     Container(
                                          height: height*0.55,
                                          width:ResponsiveWidget.isSmallScreen(context)? width*0.95:width*0.8,
                                        child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                        padding: EdgeInsets.all(20) ,
                                        ),
                                   ],
                                 ),
                               ),
                             ],
                           );
                          }
                          if(map[index]["status"]=="live"){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                customHeading(context,"Live","Event"),
                                SizedBox(height: 20,),
                                InkWell(
                                  hoverColor: Colors.transparent,
                                  onTap:(){
                                    eventController.updatelive(map[index]["bigS"],map[index]["youtube"],map[index]["price"],map[index]["note"],map[index]["age"],map[index]["gender"], map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"],map[index]["participants"],map[index]["terms"]);
                                    Get.toNamed('/eventDetail?event=$index');
                                  },
                                  child: Row(
                                    mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                    children: [
                                       Container(
                                          height: height*0.55,
                                          
                                        child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                        padding: EdgeInsets.all(20) ,
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                customHeading(context,"Previous","Event"),
                                SizedBox(height: 20,),
                                  InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap:(){
                                      eventController.updatePrevious(map[index]["bigS"],map[index]["youtube"],map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"], map[index]["top3"],map[index]["participants"]);
                                      Get.toNamed('/eventDetail?event=$index');
                            },
                                    child: Row(
                                      mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: height*0.55,
                                          width: width*0.8,
                                        child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                        padding: EdgeInsets.all(20) ,
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }),
                    ],
                  );
                }
              ),
            ),
           

          ],
        ),
      ),
    );
  }
 Padding customHeading(BuildContext context,String txt1,String txt2) {
    return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: RichText(
                     text: TextSpan(
                       style: Theme
                           .of(context)
                           .textTheme
                           .headline4,
                       children: [
                         TextSpan(text: "$txt1\n",),
                         TextSpan(
                             text: "$txt2",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                             ))
                       ],
                     ),
                   ),
                 );
  }}
 






