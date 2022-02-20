import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohit/Models/serviceModal.dart';
import 'package:pujapurohit/Models/servicetop.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/service_top.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
import 'package:pujapurohit/Widgets/reviews.dart';
import 'package:pujapurohit/controller/CommonController.dart';
import '../new_pandit_home.dart';
import 'Controllers/images_controller.dart';
import 'Controllers/pandits_controller.dart';
import 'Widgets/responsive.dart';
class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    String puid=Get.parameters['puid']!;
    var ScreenSize= MediaQuery.of(context).size;
    final DetailSideMenu detailSideMenu= Get.put(DetailSideMenu());
    final DetailSideMenu1 detailSideMenu1= Get.put(DetailSideMenu1());
   return Scaffold(
     
     appBar:PreferredSize(preferredSize: Size(ScreenSize.width,height*0.099,), 
      child: TopTabs()
      ),
     
     body: GetX<PanditDetailController>(
       init: Get.put<PanditDetailController>(PanditDetailController(uid:puid)),
       builder: (PanditDetailController pandDetailController){
         if(pandDetailController.userModel.value.name == null){
           return Center(child: Loader(),);
         }
         var swastik = pandDetailController.userModel.value.swastik;
         int? rates = pandDetailController.userModel.value.raters;
         double? overall_rate=swastik!/rates!;
         return SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                  height:  ResponsiveWidget.isSmallScreen(context)? width<=380?height*0.38:height*0.3:height*0.35,
                   width: width,
                   color: Color(0xff181c2c),
                   padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)?5:width*0.06,right: ResponsiveWidget.isSmallScreen(context)?5:30,top: height*0.02,bottom: 10),
                   margin: EdgeInsets.only(bottom: height*0.04),
                   child: Row(
                     children:[
                       Expanded(
                         flex: 1,
                         child: Obx((){
                           return InkWell(
                             onTap: (){
                               Get.defaultDialog(
                                 title: 'Profile Pic',
                                 content: Image.network("${pandDetailController.userModel.value.image}",fit: BoxFit.fill,)
                               );
                             },
                             child: Container(
                             margin:  ResponsiveWidget.isMediumScreen(context)? EdgeInsets.all(0.0):EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)?10:width*0.06,right:width*0.01),
                             height:ResponsiveWidget.isSmallScreen(context)?height*0.12:width==1024?height*0.2:height*0.25,
                             
                             width: width*0.1,
                             decoration: BoxDecoration(
                               color:Colors.white,
                               shape: ResponsiveWidget.isSmallScreen(context)?BoxShape.circle:BoxShape.rectangle,
                               image: DecorationImage(image: NetworkImage("${pandDetailController.userModel.value.image}"),
                               fit: BoxFit.fill,
                               ),
                               
                             ),
                                                    ),
                           ) ;
                         })),
                         SizedBox(width:width*0.05),
                       Expanded(
                         flex: ResponsiveWidget.isSmallScreen(context)? 3:2,
                         child: Container(
                           padding: EdgeInsets.only(top:height*0.035),
                           child: Obx((){
                            var swastik =pandDetailController.userModel.value.swastik;
                            var raters =  pandDetailController.userModel.value.raters;
                            double? overall_rate=swastik!/raters!;
                             return Column(
                               
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text1(max:ResponsiveWidget.isSmallScreen(context)?16:28,min: ResponsiveWidget.isSmallScreen(context)?12:26,data: "${pandDetailController.userModel.value.name}",clr:Colors.white,),
                               SizedBox(height:10),
                                Text1(data: "${pandDetailController.userModel.value.city}, ${pandDetailController.userModel.value.state}",max: 12,min: 11,clr: Colors.white54,),
                               SizedBox(height:10),
                              Text1(data: "Qualification: ${pandDetailController.userModel.value.type}",max: 12,min: 11,clr: Colors.white54,),
                               SizedBox(height:20),
                               Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child:MiniBox(icon: true, FirstText: "${overall_rate!.toStringAsFixed(1)}", SecondText: "${pandDetailController.userModel.value.raters} ratings",iconData: CupertinoIcons.star,)),
                                      Expanded(
                                          flex: 1,
                                          child: MiniBox(icon: false, FirstText: "${pandDetailController.userModel.value.experience}", SecondText: "Experience",iconData: Icons.translate,)),
                                      Expanded(
                                          flex: 1,
                                          child: MiniBox(icon: true, FirstText: "${pandDetailController.userModel.value.language}", SecondText: "Language",iconData: Icons.translate,)),

                                    ],
                                  ),
                                   SizedBox(height:15),          
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child:InkWell(
                                    onTap: (){
                                      Get.bottomSheet(
                                        GetX<ImageController>(
                                 init: Get.put<ImageController>(ImageController(uid:'${pandDetailController.userModel.value.uid}')),
                                 builder: (ImageController imagesController) {
                                   if (imagesController.userModel.value.link1 != null) {
                                     return Container(
                                         color: Colors.white,
                                         width: double.infinity,
                                         child: Stack(
                                           children: [
                                             Row(
                                               children: [
                                                 Expanded(
                                                   flex:5,
                                                   child:
                                                   PageView(
                                                     pageSnapping: true,
                                                     scrollDirection: Axis.vertical,
                                                     children: [
                                                       bigImage(height, imagesController.userModel.value.link1??''),
                                                       bigImage(height, imagesController.userModel.value.link2??''),
                                                       bigImage(height, imagesController.userModel.value.link3??''),
                                                       bigImage(height, imagesController.userModel.value.link4??''),

                                                     ],
                                                   ),
                                                 ),
                                                 SizedBox(width:5),
                                                 Expanded(
                                                     flex: 1,
                                                     child:Column(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         smallImage(imagesController.userModel.value.link1??''),
                                                         smallImage(imagesController.userModel.value.link2??''),
                                                         smallImage(imagesController.userModel.value.link3??''),
                                                         smallImage(imagesController.userModel.value.link4??''),
                                                       ],
                                                     ))
                                               ],
                                             ),
                                           ],
                                         )
                                     );
                                   } else {
                                     return Center(child: SizedBox(
                                         height: 50,width: 50,
                                         child: Loader()));
                                   }
                                 },
                               ),
                               enableDrag: false,
                             );

                           },
                           child: MiniBox(icon: true, FirstText: "Puja Snaps", SecondText: "4 photos",iconData: CupertinoIcons.camera,))),
                   Expanded(
                       flex: 1,
                       child: InkWell(
                           onTap: (){
                             Get.bottomSheet(Container(
                                 color: Colors.white,
                                 padding: EdgeInsets.all(10),
                                 alignment: Alignment.center,
                                 child:Text1(data: "Comming soon", max: 12, min: 11)
                             ));
                           },
                           child: MiniBox(icon: true, FirstText: "Sort Video", SecondText: "0 video",iconData: CupertinoIcons.videocam_circle,))),
                   
                   Expanded(
                       flex: 1,
                       child: ResponsiveWidget.isSmallScreen(context)? InkWell(
                           onTap: (){
                             Get.bottomSheet(
                                 Container(
                                   color: Colors.white,
                                   child: Reviews(uid: '${pandDetailController.userModel.value.uid}',ServiceId: '2021-04-17T20:11:41.917123',pandit: true,swastik:pandDetailController.userModel.value.swastik,raters: pandDetailController.userModel.value.raters,reviewers: pandDetailController.userModel.value.reviewers,),
                                 ),
                                 enableDrag: false
                             );
                           },
                           child: MiniBox(icon: true, FirstText: "Read Reviews", SecondText: "${pandDetailController.userModel.value.reviewers} reviews",iconData: Icons.rate_review,)):SizedBox()),

                                ],
                              ),
                              
                             ]
                           );
                           })
                         ) ),
                          SizedBox(width:width*0.05),
                       ResponsiveWidget.isSmallScreen(context)?SizedBox():Expanded(
                         flex:1,
                         child: Padding(
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
                                     Column(
                                      children:[
                                        offers(width,"No offer's right now"),                                                                                
                                       ]
                                     )
                                       
                                   ],
                                 ),
                               )
                             ]
                           ),
                         ) ),
                     ]
                   )
                   ),

              
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                    
                   Container(
                     height: 40,
                     child: ResponsiveWidget.isSmallScreen(context)?Padding(
                       padding: const EdgeInsets.only(left:30),
                       child: topController(pandDetailController, context,Axis.horizontal),
                     ):SizedBox(),
                   ),
                   Container(
                     width:double.infinity,
                     
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                      ResponsiveWidget.isSmallScreen(context)?SizedBox():Expanded(
                           flex: 1,
                           child: Padding(
                             padding: const EdgeInsets.only(left:30),
                             child: topController(pandDetailController, context,Axis.vertical),
                           ),
                         ),

                          Expanded(
                            flex: ResponsiveWidget.isSmallScreen(context)?1:2,
                            child: Obx((){
                                           return StreamBuilder<QuerySnapshot>(
                                               stream: detailSideMenu.select.value.selected=="All"?FirebaseFirestore.instance.collection("Avaliable_pundit/${pandDetailController.userModel.value.uid}/puja_offering").where("offer" , isEqualTo:"${detailSideMenu1.select.value.selected}").snapshots():
                                               FirebaseFirestore.instance.collection("Avaliable_pundit/${pandDetailController.userModel.value.uid}/puja_offering").where("type" , isEqualTo:"${detailSideMenu.select.value.selected}").where("offer" , isEqualTo:"${detailSideMenu1.select.value.selected}").snapshots(),
                                               builder: (context, snapshot) {
                          
                          
                             if(snapshot.data == null){
                               return Center(child:Text("Loading services"));
                             }
                             if(snapshot.data!.docs.isEmpty){
                               return Center(child: Text1(data: "Nothing to show", max: 14, min: 12),);
                             }
                             final servicess = snapshot.data!.docs.reversed;
                          
                             List<Widget> servicessWidgets=[];
                          
                             for(var mess in servicess){
                               final puja=mess.get('puja');
                               final time= mess.get('time');
                               final price=mess.get('price');
                               final benefit=mess.get('Benefit');
                               final samgri=mess.get('Pujan Samagri');
                               final detail=mess.get('PanditD');
                               final keyword=mess.get('keyword');
                               final image= mess.get('image');
                               final id=mess.get('serviceId');
                               final offer= mess.get('offer');
                               final np=mess.get('np');
                               final messWidget=  serviceCard(height, context, width,puja,detail,time,price,id,image,offer,'${Get.parameters['puid']}',np,pandDetailController.userModel.value.name!);
                               servicessWidgets.add(messWidget);
                          
                             }

                          
                             return ListView(
                                 physics: NeverScrollableScrollPhysics(),
                                 shrinkWrap: true,
                                 children: servicessWidgets
                             );
                                               }
                                           );
                                         }),
                          ),
                          ResponsiveWidget.isSmallScreen(context)?SizedBox():
                          Expanded(
                            flex:2,
                            child: Reviews(uid: '${pandDetailController.userModel.value.uid}',ServiceId: '2021-04-17T20:11:41.917123',pandit: true,swastik:pandDetailController.userModel.value.swastik,raters: pandDetailController.userModel.value.raters,reviewers: pandDetailController.userModel.value.reviewers,),)
                       ],
                     ),
                   ),
                 ],
               ),
              
                ResponsiveWidget.isSmallScreen(context)?MobileBottomBar():NewBottomBar()
             ],
           ),
         );
       },
     )
     );

  }

  GetX<ServiceTopController> topController(PanditDetailController pandDetailController, BuildContext context,Axis scroll) {
    return GetX<ServiceTopController>(
                             init: Get.put<ServiceTopController>(ServiceTopController(uid:'${pandDetailController.userModel.value.uid}')),
                             builder: (ServiceTopController serviceTopController) {
                               if (serviceTopController != null && serviceTopController.serviceTop != null) {
                                 return ListView.builder(
                                   scrollDirection: scroll,
                                   //physics: NeverScrollableScrollPhysics(),
                                   shrinkWrap: true,
                                   itemCount: serviceTopController.serviceTopList.value!.length,
                                   itemBuilder: (_, index) {
                                     return sideMenu(serviceTopController.serviceTop![index],context);
                                   },
                                 );
                               } else {
                                 return Center(child: SizedBox(
                                     height: 50,width: 50,
                                     child: Loader()));
                               }
                             },
                           );
  }

  Container smallImage(String? imagesController) {
    return Container(
                                                     margin: EdgeInsets.only(bottom:10),
                                                     height: 50,width: 100,
                                                     decoration: BoxDecoration(
                                                       image: DecorationImage(
                                                         image: NetworkImage('${imagesController}'),
                                                         fit: BoxFit.contain,
                                                       )
                                                     ),
                                                   );
  }

  Container bigImage(double height, String? imagesController) {
    return Container(
                                                 height:height*0.45,
                                                 width: double.infinity,
                                                 child: Image.network('${imagesController}'),
                                               );
  }
Widget sideMenu(ServiceTopModal serviceTopModal,BuildContext context) {
  final DetailSideMenu detailSideMenu= Get.put(DetailSideMenu());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx((){
        return InkWell(
            onTap: (){
              detailSideMenu.updateSelected("${serviceTopModal.name}");
            },
            child: Text1(max: detailSideMenu.select.value.selected=="${serviceTopModal.name}"? 14:12, data: "${serviceTopModal.name}", min: detailSideMenu.select.value.selected=="${serviceTopModal.name}"?13:11,clr:detailSideMenu.select.value.selected=="${serviceTopModal.name}"?Colors.orangeAccent:Colors.black54));
      })
    );
  }

  Padding offers(double width, String offer) {
    return Padding(
                                       padding: const EdgeInsets.only(left:10,top: 5),
                                       child: Container(
                                         width: width*0.18,
                                         child: Row(
                                           children: [
                                               Icon(Icons.local_offer_sharp,color:Colors.white,size:10),
                                               SizedBox(width:5),
                                             Expanded(child:  Text1(data: "$offer",max: 12,min: 11,clr: Colors.white,))
                                             ],
                                           ),
                                       ),
                                     );
  }

}
class MiniBox extends StatelessWidget{
  final IconData? iconData;
  final bool icon;
  final String FirstText;
  final String SecondText;
  MiniBox({ this.iconData, required this.icon,required this.FirstText,required this.SecondText});
  @override
  Widget build(BuildContext context) {
    return  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                        icon?Icon(iconData,size:12,color:Colors.grey,):SizedBox(),

                                        icon?SizedBox(width:5):SizedBox(),
                                          Expanded(child: Text1(data: "$FirstText",max: ResponsiveWidget.isSmallScreen(context)?10:12,min: 8,clr: Colors.grey,weight: FontWeight.w600,),flex: 1,)
                                      ],),
                                      SizedBox(height:5),
                                      Text1(data: "$SecondText",max: ResponsiveWidget.isSmallScreen(context)?10:8,min: 7,clr: Colors.grey,weight: FontWeight.w100),
                                    ]
                                  );
  }

}

class DetailSideMenu extends GetxController{
 final String? uid;
 DetailSideMenu({this.uid});
  Rxn<List<ServiceModal>> serviceList = Rxn<List<ServiceModal>>();

  List<ServiceModal>? get service => serviceList.value;
  var select = DetailSelectedItem(selected: "All",item: 0).obs;
  var items = 0.obs;
 @override
 void onInit(){
   serviceList.bindStream(trendingStream());
   super.onInit();
 }
  Stream<List<ServiceModal>> trendingStream() {
    return FirebaseFirestore.instance
        .collection("Avaliable_pundit")
        .doc("$uid")
        .collection("puja_offering").where('type',isEqualTo: '${select.value.selected}')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ServiceModal> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ServiceModal.fromSnapshot(element));
      });
      return retVal;
    });
  }

  updateSelected(String value){
    select.update((val) {
      val!.selected = "$value";
    });
    
  }

  updateItems(var item){
    items.value = item;
  }

}


class DetailSelectedItem {
  String selected = "All";
  int? item;
  DetailSelectedItem({required this.selected, this.item});
}

class DetailSideMenu1 extends GetxController{
  // final String value;
  // DetailSideMenu({required this.value});
  var select = DetailSelectedItem(selected: "Physical",item: 0).obs;
  var items = 0.obs;
  updateSelected(String value){
    select.update((val) {
      val!.selected = "$value";
    });
    
  }

  updateItems(var item){
    items.value = item;
  }

}


class DetailSelectedItem1 {
  String selected = "Physical";
  String? dselected = "Online";
  int? item;
  DetailSelectedItem1({required this.selected,this.dselected, this.item});
}

Widget serviceCard(double height, BuildContext context, double width,String puja,String detail,String time,var price,String id,String image,String offer,String id2,var np,String pandit) {
  return InkWell(
    onTap: (){
      CommonController commonController = Get.put(CommonController());
      commonController.profileMove('$id', '$pandit');
      Get.toNamed('/serviceDetail?pid=$id2&sid=$id&pandit=$pandit');
    },
    child: Container(
        margin: EdgeInsets.all(20),
        child:Row(
            children:[
              Expanded(
                flex:3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Row(

                        children: [
                          Icon(Icons.circle_rounded,size: 13,color: Colors.green,),
                          SizedBox(width:5),
                          Icon(Icons.star,size: 13,color: Colors.orangeAccent,),
                          SizedBox(width:5),
                          Text1(max: 13,min: 13,data: "BestSeller",clr:Colors.orangeAccent,),
                        ],
                      ),
                      SizedBox(height:10),
                      SelectableText("${puja}",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),),
                      SizedBox(height:10),
                      Row(
                        children: [
                          Text('\₹${np}',style:GoogleFonts.aBeeZee(color:Colors.redAccent,fontSize:10,decoration: TextDecoration.lineThrough)),
                          SizedBox(width:5),
                    Text1(max: 12,min: 10,data: "\₹${price}",clr:Colors.green,weight: FontWeight.bold,),


                        ],
                      ),
                      SizedBox(height:10),
                      Text1(max: 12,min: 10,data: "${detail}\nDuration: ${time}",clr:Colors.black54),
                    ]
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        height: height*0.18,
                        width: 800,

                        decoration: BoxDecoration(
                          // color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(image: NetworkImage("${image}"),
                                fit: BoxFit.contain)
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height*0.13,left:5,right:2,),
                        child: Column(

                            children:[
    //                            Text1(max: 9,min: 7,data: "Samagri in stock",clr:Colors.black54),

                            ]
                        ),
                      )
                    ],
                  ))
            ]
        )
    ),
  );
}