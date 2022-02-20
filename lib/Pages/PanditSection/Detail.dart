import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:pujapurohit/Models/BModal.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/pandits_controller.dart';

import 'package:pujapurohit/Pages/PanditSection/profile.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/image_view.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/youtube_player.dart';
import 'package:pujapurohit/Widgets/bottombar.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
import 'package:pujapurohit/controller/CommonController.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'Widgets/responsive.dart';

class Detail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
      double width =  MediaQuery.of(context).size.width;
      String detail = '#${Get.parameters['id']!}';
      var language = 'detailEnglish'.obs;
      final AuthController authController = Get.find();
       LocationController locationController = Get.put(LocationController());
    return Scaffold(
    backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              StreamBuilder<DocumentSnapshot>(
                stream:FirebaseFirestore.instance.doc('PujaPurohitFiles/commonCollections/deatil/$detail').snapshots(),
                builder: (context, snapshot) {
                    if(snapshot.data==null){
                    return Center(child:Loader());
                  }
                  List<Widget> para = [];
                  for(var i in snapshot.data!.get('detailEnglish')){
                    final String textdata = i;
                    final txt = Container(
                      margin: EdgeInsets.all(20),
                      child: Text1(data: "${i}", max:ResponsiveWidget.isSmallScreen(context)?12:20,min:ResponsiveWidget.isSmallScreen(context)?10:18,clr:Colors.black,),
                    );
                    para.add(txt);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Container(
                       height: height*0.35,
                        width: width,
                        color: Color(0xff181c2c),
                        padding: EdgeInsets.only(left:width*0.06,right: 30,top: height*0.02,bottom: 10),
                        margin: EdgeInsets.only(bottom: height*0.04),
                        child: Row(
                          children: [
                              Expanded(
                              flex: 1,
                              child: Container(
                                margin:  ResponsiveWidget.isMediumScreen(context)?EdgeInsets.all(0.0):EdgeInsets.only(left:width*0.06,right:width*0.01),
                                height:ResponsiveWidget.isSmallScreen(context)?height*0.15:height*0.23,
                                
                                width: width*0.15,
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  image: DecorationImage(image: NetworkImage("${snapshot.data!.get('image')}"),
                                  fit: BoxFit.fill,
                                  ),
                                  
                                ),
                              ) 
                              
                              ),
                              SizedBox(width:width*0.05),
                                Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top:height*0.035),
                                child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Text1(max: 28,min: 26,data: "${snapshot.data!.get('name')}",clr:Colors.white,),
                                    SizedBox(height:10),
                                    Text1(data: "${snapshot.data!.get('date')}",max: 12,min: 11,clr: Colors.white54,),
                                    SizedBox(height:10),
                                    Text1(data: "Vikram Samvat: ${snapshot.data!.get('vikram')}",max: 12,min: 11,clr: Colors.white54,),
                                    SizedBox(height:20),
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       Expanded(
                                         flex: 1,
                                         child: MiniBox(icon: true, FirstText: "${snapshot.data!.get('begin')}", SecondText: "Tithi begin",iconData: CupertinoIcons.clock,)),
                                          Expanded(
                                            flex: 1,
                                            child: MiniBox(icon: true, FirstText: "${snapshot.data!.get('end')}", SecondText: "Tithi End",iconData: CupertinoIcons.clock,)),
                                    
        
                                      ],
                                    )
                                  ]
                                )
                              ) ),
                               SizedBox(width:width*0.05),  


                       ResponsiveWidget.isSmallScreen(context)? SizedBox():Expanded(
                              flex:1,
                              child:Padding(
                               padding: EdgeInsets.only(top:height*0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Row(
                                      children: [
                                        Text1(data:"OFFER",max: 12,min: 10,clr: Colors.white,),
                                        SizedBox(width:5),
                                        Container(width:width*0.15,height:1,color:Colors.white54)
                                      ],
                                    ),
                                    SizedBox(height:5),
                                    Expanded(
                                        child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Container(
                                            margin: EdgeInsets.only(left:5),
                                            
                                            width:1,height:height*0.18,color:Colors.white54),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                             children:[
                                               Text1(data: "No offers right now", max: 12, min: 11,clr: Colors.white,),
                                              // offers(width,"20% of on all orders up to ₹1000"),
                                               SizedBox(height:20),
                                              // offers(width,"20% of upto INR 125/- with Kotak Credit or Debit Cards | Use Code KOTAK125"),
        
                                              ]
                                            ),
                                          )
                                            
                                        ],
                                      ),
                                    )
                                  ]
                                ),
                              ) ),
                          ],
                        )                 
                        ),
                      //   Padding(
                      //   padding:EdgeInsets.only(left:width*0.1),
                      //   child: Text1(
                      //     data: "Suggested purohit for ${snapshot.data!.get('pujaname')}",                         
                      //     max: 14, min: 11,clr: Colors.black87,),
                      // ),
                      // SizedBox(height: 10,),
                      // Padding(
                      //   padding:EdgeInsets.only(left:width*0.1),
                      //   child: authController.user==null? unloggeduggestions(snapshot):SizedBox(),
                        
                      // ),
                       snapshot.data!.get('video') ?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Expanded(child: YoutubeAppDemo(id:snapshot.data!.get('videoId')),)
                            Container(
                              width: width*0.7,
                              height:ResponsiveWidget.isSmallScreen(context)?height*0.4:ResponsiveWidget.isMediumScreen(context)?height*0.6: height*0.65,
                              child: YoutubeAppDemo(id:snapshot.data!.get('videoId')),
                            )
                          ],
                        ):SizedBox(),

                    Padding(
                      padding: EdgeInsets.only(left: width*0.1,right: width*0.1),
                      child: Column(
                          children: [
                            ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: para,
                              shrinkWrap: true,
                            ),                         
                          ],
                      ),
                    ),
                      SizedBox(height: 10,),
                      ResponsiveWidget.isSmallScreen(context)?MobileBottomBar():NewBottomBar()
                    ],
                  );
                }
              )
          ],
        ),
      ),
    );
  }
    Widget loggeduggestions(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
    return GetX<UserController>(
                      init: Get.put<UserController>(UserController()),
                      builder: (UserController userController){
                        if(userController.userModel.value.lat == null){
                          return Center(child:SizedBox(height:50,child: Loader(),));
                        }
                        return   GetX<PanditKeywordController>(
                          init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'${snapshot.data!.get('pujakeyword')}',lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'))),
                          builder: (PanditKeywordController panditController) {
                            if (panditController != null && panditController.pandits != null) {
                              if(panditController.panditList.value!.isEmpty){
                                return Padding(
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: Text1(data: "No pandit in your area performing ${snapshot.data!.get('pujaname')}", max: 18, min: 12,clr:Colors.redAccent),
                                );
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

  Widget unloggeduggestions(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
    return GetX<LocationController>(
      init: Get.put<LocationController>(LocationController()),
      builder: (LocationController userController){
        if(userController.location.value.lat == null){
          return Center(child:SizedBox(height:50,child: Loader(),));
        }
        return   GetX<PanditKeywordController>(
          init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'${snapshot.data!.get('pujakeyword')}',lat: double.parse('${userController.location.value.lat}'),lng: double.parse('${userController.location.value.lng}'))),
          builder: (PanditKeywordController panditController) {
            if (panditController != null && panditController.pandits != null) {
              if(panditController.panditList.value!.isEmpty){
                return Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Text1(data: "No pandit in your area performing ${snapshot.data!.get('pujaname')}", max: 18, min: 12,clr:Colors.redAccent),
                );
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
                          return new PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.location.value.lat}'),lng: double.parse('${userController.location.value.lng}'));
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


class PanditNewCard extends StatelessWidget{
  final BMModal? bmModal;
  final double? lat;
  final double? lng;
  
  PanditNewCard({this.bmModal,this.lat,this.lng});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    GeoPoint geoPoint = bmModal!.location!['geopoint'];
   double distanceInMeters = Geolocator.distanceBetween(lat!,lng!, geoPoint.latitude, geoPoint.longitude);
   return InkWell(
     hoverColor: Colors.transparent,
     onTap: (){
       FareBreakup farebreakup = Get.put(FareBreakup());
       farebreakup.pandit(bmModal!.image!, bmModal!.name!, bmModal!.number!, bmModal!.token!,bmModal!.uid!,double.parse('${(distanceInMeters/1000).toStringAsFixed(2)}'));
       CommonController commonController = Get.put(CommonController());
       commonController.updatePandit(bmModal!.uid!);
       Get.toNamed('/profile?puid=${bmModal!.uid}');
     },
     child: HoverWidget(
       onHover: (event){},
       hoverChild: Container(
       margin: EdgeInsets.all(10),
       alignment:Alignment.center,
       padding:EdgeInsets.all(10.0) ,
       decoration: BoxDecoration(
           color:Colors.white,
           borderRadius: BorderRadius.circular(12),
           border: Border.all(
             color:Color(0xff181c2c) 
           ),
           boxShadow: [
             BoxShadow(color: Colors.grey.shade100,blurRadius: 10)
           ]
       ),
       height:height*0.3,
       width:  ResponsiveWidget.isSmallScreen(context)? width*0.4:width*0.15,
       child: Stack(

         children: [
           Align(
             alignment: Alignment.topRight,
             heightFactor: 20,
             child: bmModal!.verified?Icon(Icons.verified,color: Colors.blueAccent,size: 14,):SizedBox(),
           ),
           Align(
             alignment:Alignment.topCenter,
             child: CircleAvatar(
               maxRadius:40,
               backgroundColor: Colors.white,
               backgroundImage: NetworkImage('${bmModal!.image}',),
             ),
           ),
           SizedBox(height:5),
           Padding(
             padding: EdgeInsets.only(top:40),
             child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("${bmModal!.name}",style: GoogleFonts.aBeeZee(color:Colors.black54,fontSize: ResponsiveWidget.isSmallScreen(context)?12:16,),textAlign: TextAlign.center,),
                   SizedBox(height:5),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       bmModal!.raters==0?Container(
                       decoration: BoxDecoration(
                       color: Colors.green,
                       borderRadius: BorderRadius.circular(5),),
                           alignment: Alignment.center,
                           padding: EdgeInsets.all(5),
                           child: Row(children: [
                             Icon(Icons.star,color:Colors.white,size:10),
                             SizedBox(width:2),
                             Text1(max: 10, data: '5.0', min: 8,clr: Colors.white,)
                           ],),
                       ):SizedBox(
                           height:20,
                           width: 40,
                           child: rating()),
                       //Text1(data:'${(distanceInMeters/1000).toStringAsFixed(2)} Km', max: 12, min: 10,clr:Colors.green,weight: FontWeight.bold,)
                     ],
                   )
                 ]),
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               SizedBox(
                 height:40,
                 child: Row(
                   mainAxisAlignment:MainAxisAlignment.center,
                   children: [
                     ElevatedButton(onPressed: (){
                       FareBreakup farebreakup = Get.put(FareBreakup());
                       farebreakup.pandit(bmModal!.image!, bmModal!.name!, bmModal!.number!, bmModal!.token!,bmModal!.uid!,double.parse('${(distanceInMeters/1000).toStringAsFixed(2)}'));
                       CommonController commonController = Get.put(CommonController());
                       commonController.updatePandit(bmModal!.uid!);
                       Get.toNamed('/profile?puid=${bmModal!.uid}');
                     }, child: Text1(data: 'Book now',max: ResponsiveWidget.isSmallScreen(context)?10:15,min: 8,clr: Colors.white),style: ElevatedButton.styleFrom(primary: Color(0xff181c2c),shape: StadiumBorder()),),
                   ],
                 ),
               ),
             ],
           )
         ],
       ),
     ),
       child: Container(
         margin: EdgeInsets.all(10),
         alignment:Alignment.center,
         padding:EdgeInsets.all(10.0) ,
         decoration: BoxDecoration(
             color:Colors.white,
             borderRadius: BorderRadius.circular(12),
             boxShadow: [
               BoxShadow(color: Colors.grey.shade100,blurRadius: 20)
             ]
         ),
         height:ResponsiveWidget.isSmallScreen(context)? height*0.25:height*3,
         width:ResponsiveWidget.isSmallScreen(context)? width*0.4:width*0.13,
         child: Stack(
     
           children: [
             Align(
               alignment: Alignment.topRight,
               heightFactor: 20,
               child: bmModal!.verified?Icon(Icons.verified,color: Colors.blueAccent,size: 14,):SizedBox(),
             ),
             Align(
               alignment:Alignment.topCenter,
               child: CircleAvatar(
                 maxRadius:40,
                 backgroundColor: Colors.white,
                 backgroundImage: NetworkImage('${bmModal!.image}',),
               ),
             ),
             SizedBox(height:5),
             Padding(
               padding: EdgeInsets.only(top:40),
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("${bmModal!.name}",style: GoogleFonts.aBeeZee(color:Colors.black54,fontSize: ResponsiveWidget.isSmallScreen(context)?12:16,),textAlign: TextAlign.center,),
                     SizedBox(height:5),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         bmModal!.raters==0?Container(
                         decoration: BoxDecoration(
                         color: Colors.green,
                         borderRadius: BorderRadius.circular(5),),
                             alignment: Alignment.center,
                             padding: EdgeInsets.all(5),
                             child: Row(children: [
                               Icon(Icons.star,color:Colors.white,size:10),
                               SizedBox(width:2),
                               Text1(max: 10, data: '5.0', min: 8,clr: Colors.white,)
                             ],),
                         ):SizedBox(
                             height:20,
                             width: 40,
                             child: rating()),
                         //Text1(data:'${(distanceInMeters/1000).toStringAsFixed(2)} Km', max: 12, min: 10,clr:Colors.green,weight: FontWeight.bold,)
                       ],
                     )
                   ]),
             ),
            ResponsiveWidget.isLargeScreen(context)? SizedBox():Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 SizedBox(
                   height:40,
                   child: Row(
                     mainAxisAlignment:MainAxisAlignment.center,
                     children: [
                       ElevatedButton(onPressed: (){
                         FareBreakup farebreakup = Get.put(FareBreakup());
                         farebreakup.pandit(bmModal!.image!, bmModal!.name!, bmModal!.number!, bmModal!.token!,bmModal!.uid!,double.parse('${(distanceInMeters/1000).toStringAsFixed(2)}'));
                         CommonController commonController = Get.put(CommonController());
                         commonController.updatePandit(bmModal!.uid!);
                         Get.toNamed('/profile?puid=${bmModal!.uid}');
                       }, child: Text1(data: 'Book now',max:ResponsiveWidget.isSmallScreen(context)?10:15,min: 8,clr: Colors.white),style: ElevatedButton.styleFrom(primary: Color(0xff181c2c),shape: StadiumBorder()),),
                     ],
                   ),
                 ),
               ],
             )
           ],
         ),
       ),
     ),
   );
  }
  Widget rating(){
    var swastik = bmModal!.swastik;
    int? rates = bmModal!.raters;
    double? overall_rate=swastik!/rates!;
    if(overall_rate!>=4){
      return newrate(overall_rate,Colors.green);
    }
    if(overall_rate >=3 && overall_rate<4){
      return  newrate(overall_rate,Colors.orangeAccent);
    }
    return  newrate(overall_rate>0?bmModal!.swastik:0, Colors.redAccent);



  }

  Container newrate(double overall_rate,Color clr) {
    return Container(
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(5),),
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Row(children: [
        Icon(Icons.star,color:Colors.white,size:10),
        SizedBox(width:2),
        Text1(max: 10, data: '${overall_rate.toStringAsFixed(1)}', min: 8,clr: Colors.white,)
      ],),
    );
  }
}