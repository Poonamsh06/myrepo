import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Models/BModal.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/reviews.dart';

import '../new_pandit_home.dart';
import 'Widgets/responsive.dart';

class BigScreenDetailPage extends StatelessWidget{
  final DetailSideMenu detailSideMenu = Get.put(DetailSideMenu());
  final DetailSideMenu1 detailSideMenu1 = Get.put(DetailSideMenu1());
  final PanditDetailController panditDetailContrller = Get.put(PanditDetailController());
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width =  Get.width;
    String? uid = Get.parameters['puid'];
   return Scaffold(
      key: _key,
     
      appBar:  PreferredSize(preferredSize: Size(width,height*0.1,), 
          child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                  ),
                  width: width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap:(){Get.toNamed('home');},
                              child: Image.asset('assets/images/logo.png',fit: BoxFit.fill,height: 60,width: 60,),
                            ),
                          
                          ],
                        ),
                       ResponsiveWidget.isSmallScreen(context)? SizedBox():Row(
                          children: [
                            SizedBox(width: 20,),
                            ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.search, max: 12, data: 'Search', min: 8,color: Colors.black54,weight: FontWeight.bold,),
                            
                            SizedBox(width: 20,),
                            InkWell(
                              onTap: (){
                              uid!='Sign In'?Get.toNamed('/my-account?id=$uid'):_key.currentState!.openEndDrawer();
                              },
                              child: ModifiedTextIcon(iconColor: Colors.orangeAccent,icondata: LineIcons.user, max: 12, data: uid!='Sign In'?'${Get.parameters['user']}':'Sign In', min: 8,color: Colors.orangeAccent,weight: FontWeight.bold)),
                            SizedBox(width: 20,),
                            ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.shoppingBag, max: 12, data: 'Cart', min: 8,color: Colors.black54,weight: FontWeight.bold),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
          ),
     
     
     backgroundColor: Colors.white,
     body:GetBuilder<PanditDetailController>(
       init: PanditDetailController(),
       initState: (data)=>panditDetailContrller.initializeBModalModel('${Get.parameters['puid']}'),
       builder: (bcontroller){
         var len;
         return  Scrollbar(
                    child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
                      child: Column(
             children:[
     Container(
       height: height*0.32,
                 width: width,
       color:Colors.white,
       child:Stack(
             children: [
               Container(
                    height: height*0.6,
                     width: width,
                     color: Color(0xff181c2c),
                     padding: EdgeInsets.only(left:width*0.06,right: 30,top: height*0.02,bottom: 10),
                     margin: EdgeInsets.only(bottom: height*0.04),
                     child: Row(
                       children:[
                         Expanded(
                           flex: 1,
                           child: Obx((){
                             return Container(
                             margin:  ResponsiveWidget.isMediumScreen(context)? EdgeInsets.all(0.0):EdgeInsets.only(left:width*0.06,right:width*0.01),
                             height:height*0.23,
                             
                             width: width*0.1,
                             decoration: BoxDecoration(
                               color:Colors.white,
                               image: DecorationImage(image: NetworkImage("${panditDetailContrller.userModel.value.image}"),
                               fit: BoxFit.fill,
                               ),
                               
                             ),
                           ) ;
                           })),
                           SizedBox(width:width*0.05),
                         Expanded(
                           flex: 2,
                           child: Container(
                             padding: EdgeInsets.only(top:height*0.035),
                             child: Obx((){
                              var swastik =panditDetailContrller.userModel.value.swastik;
                              var raters =  panditDetailContrller.userModel.value.raters;
                              double? overall_rate=swastik!/raters!;
                               return Column(
                                 
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text1(max: 28,min: 26,data: "${panditDetailContrller.userModel.value.name}",clr:Colors.white,),
                                 SizedBox(height:10),
                                  Text1(data: "${panditDetailContrller.userModel.value.city}, ${panditDetailContrller.userModel.value.state}",max: 12,min: 11,clr: Colors.white54,),
                                 SizedBox(height:10),
                                Text1(data: "Qualification: ${panditDetailContrller.userModel.value.type}",max: 12,min: 11,clr: Colors.white54,),
                                 SizedBox(height:20),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                    MiniBox(icon: true, FirstText: "${swastik<=0?'0':overall_rate}", SecondText: "${panditDetailContrller.userModel.value.raters} Ratings",iconData: Icons.star,),
                                     Container(height:50,width: 1,color: Colors.white54,),
                                     
                                   MiniBox(icon: false, FirstText: "${panditDetailContrller.userModel.value.experience==null?'Not Updated':panditDetailContrller.userModel.value.experience}", SecondText: "Experience",iconData: Icons.star,),
                                     Container(height:50,width: 1,color: Colors.white54,),
                                     MiniBox(icon: false, FirstText: "${panditDetailContrller.userModel.value.language==null?'Not Updated':panditDetailContrller.userModel.value.language}", SecondText: "Language",iconData: Icons.star,),

                                   ],
                                 )
                               ]
                             );
                             })
                           ) ),
                            SizedBox(width:width*0.05),
                         Expanded(
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
                                       Column(
                                        children:[
                                          offers(width,"20% of on all orders up to ₹1000"),
                                          SizedBox(height:20),
                                          offers(width,"20% of upto INR 125/- with Kotak Credit or Debit Cards | Use Code KOTAK125"),

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

                    
                    
                    
                    Padding(
                      padding: EdgeInsets.only(left:width*0.45,bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(bottom: 9,left:2),
                            height:height*0.05,
                            width:200,
                           
                            child: TextFormField(
                              decoration:InputDecoration(
                                prefixIcon: Icon(LineIcons.search,size:16,color: Colors.black54),
                                border:InputBorder.none,
                                hintText:"Search Puja",
                                hintStyle:GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12)
                              )
                            ),
                          ),
                          
                        ],
                      ),
                    )
             ],
       )
     ),
     SizedBox(height:20),
     Scrollbar(
                child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
             child: Container(
               height: height*0.5,
               child: GetBuilder<DetailSideMenu>(
                 builder: (_){
                   return Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:[
                  Expanded(
        flex: 1,
        child:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Avaliable_pundit/${Get.parameters['id2']}/Category").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.data == null){
                  return  Center(child:Text("Loading List"));
                }
                 final servicess = snapshot.data!.docs.reversed;
                                
                 List<Widget> servicessWidgets=[];
                                 
                 for(var mess in servicess){
                                  
               
                 final name=mess.get('name');
                 final messWidget=  sideMenu(_,name);
                 servicessWidgets.add(messWidget);
                                    
                }
                return ListView(
                  physics: NeverScrollableScrollPhysics() ,
                  shrinkWrap: true,
                  children: servicessWidgets
                );
              }
        ),
                  ),
                  SizedBox(width:width*0.04),
                  Container(
                      height: height*2,
                      width: 1,
                      color: Colors.grey[200],
                            ),
                  SizedBox(width:width*0.035),
                  Expanded(
                  flex: 2,
                     child: SingleChildScrollView(
                       scrollDirection: Axis.vertical,
                                        child: Container(
                         
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children:[
                             Obx((){return Text1(max: 26,min: 22,data: "${detailSideMenu.select.value.selected}",clr:Colors.black87,weight: FontWeight.bold,);}),
                             SizedBox(height:10),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 InkWell(
                                  onTap: (){
                                    detailSideMenu1.updateSelected("Physical");
                                  },
                                  child: Obx((){return  Text1(max: 16,min: 14,data: "Physical",clr:detailSideMenu1.select.value.selected=="Physical"?Colors.orangeAccent:Colors.black54,weight: FontWeight.bold,);})),
                                InkWell(
                                  onTap: (){
                                    detailSideMenu1.updateSelected("Online");
                                  },
                                  child: Obx((){return  Text1(max: 16,min: 14,data: "Online",clr:detailSideMenu1.select.value.selected=="Online"?Colors.orangeAccent:Colors.black54,weight: FontWeight.bold,);})),
                              ],
                            ),
                             SizedBox(height:5),
                             //ModifiedText(max: 12,min: 11,data: "${detailSideMenu.items} ITEMS",color:Colors.black87,),
                             SizedBox(height:20),
                             Obx((){
                               return StreamBuilder<QuerySnapshot>(
                               stream: detailSideMenu.select.value.selected=="All"?FirebaseFirestore.instance.collection("Avaliable_pundit/${Get.parameters['id2']}/puja_offering").where("offer" , isEqualTo:"${detailSideMenu1.select.value.selected}").snapshots():
                               FirebaseFirestore.instance.collection("Avaliable_pundit/${Get.parameters['id2']}/puja_offering").where("type" , isEqualTo:"${detailSideMenu.select.value.selected}").where("offer" , isEqualTo:"${detailSideMenu1.select.value.selected}").snapshots(),
                               builder: (context, snapshot) {
                              
                                
                                 if(snapshot.data == null){
                                   return Center(child:Text("Loading serices"));
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
                                   final messWidget=  serviceCard(height, context, width,puja,detail,time,price,id,image,offer,'${Get.parameters['id2']}',np);
                                  servicessWidgets.add(messWidget);
                                    
                                 }
                                 print(servicessWidgets.length);
                                 _.updateItems(servicessWidgets.length);
                                 len = servicessWidgets.length;
                                 print(len);
                                 return ListView(
                                   physics: NeverScrollableScrollPhysics(),
                                   shrinkWrap: true,
                                   children: servicessWidgets
                                 );
                               }
                             );
                             })
                           ]
                         ),
                       ),
                     )
                  ),
       SizedBox(width:width*0.05),
                 ResponsiveWidget.isMediumScreen(context)? SizedBox():
                 Expanded( flex: 2,
                     child: SingleChildScrollView(
                            child: Column(children: [
                        Obx((){
                          return  Reviews(pandit: true,swastik: panditDetailContrller.userModel.value.swastik,raters: panditDetailContrller.userModel.value.raters,reviewers: panditDetailContrller.userModel.value.reviewers, uid: '', ServiceId: '',);
                        })
                       ],),
                     )
                  )
                 ]
               );
                 },
               )
             
             ),
             ),
     )
             ,ResponsiveWidget.isMediumScreen(context)?Obx((){return Reviews(pandit: true,swastik: panditDetailContrller.userModel.value.swastik,raters: panditDetailContrller.userModel.value.raters,reviewers: panditDetailContrller.userModel.value.reviewers, ServiceId: '', uid: '',);}):SizedBox()
             
             ]
       ),
           ),
         );
   
       },
     )
   
   );
  }

  Column sideMenu(DetailSideMenu _,String name) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               InkWell(
                onTap: (){
                  _.updateSelected("$name");
                  print('${detailSideMenu.select.value.selected}');
                },
                child: Obx((){
                  return  Text1(max: 12, data: "$name", min: 11,clr:detailSideMenu.select.value.selected == "$name"?Colors.orangeAccent:Colors.black54);
                })),
               SizedBox(height:10),
              
            ],
          );
  }

  Container serviceCard(double height, BuildContext context, double width,String puja,String detail,String time,var price,String id,String image,String offer,String id2,var np) {
    return Container(
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
                                           Text('\₹$np',style:GoogleFonts.aBeeZee(color:Colors.redAccent,fontSize:10,decoration: TextDecoration.lineThrough)),
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
                                         padding:  EdgeInsets.only(top:height*0.13,left:ResponsiveWidget.isMediumScreen(context)?5:width*0.018,right:ResponsiveWidget.isMediumScreen(context)?2 : width*0.01,),
                                         child: Column(
                                          
                                           children:[
                                             InkWell(
                                               onTap: (){
                                               Get.toNamed('/description?uid=${Get.parameters['id']}&uname=${Get.parameters['user']}&offer=$offer&id2=$id2&sid=$id&name="${panditDetailContrller.userModel.value.name}"');
                                                
                                               },
                                               child: Container(
                                                alignment: Alignment.center,
                                                 height: height*0.04,width: width*0.1,
                                                 decoration: BoxDecoration(
                                                   color: Colors.white,
                                                  boxShadow: [BoxShadow(color:Colors.grey,blurRadius:10)]
                                                 ),
                                                 child: Text1(max: 11,min: 10,data: "Book Now",clr:Colors.green)
                                                 ),
                                             ),
                                              
                                                 Text1(max: 9,min: 7,data: "Samagri in stock",clr:Colors.black54),
                                               
                                           ]
                                         ),
                                       )
                                     ],
                                   ))
                               ]
                             )
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


class PanditDetailController extends GetxController{
   Rx<BMModal> userModel = BMModal(swastik: 0.0,verified: false).obs;
 
    initializeBModalModel(String userId)  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('Avaliable_pundit')
        .doc(userId)
        .get()
        .then((doc) =>BMModal.fromSnapshot(doc));
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

                                        icon?Icon(iconData,size:12,color:Colors.white):SizedBox(),

                                        icon?SizedBox(width:5):SizedBox(),
                                          Text1(data: "$FirstText",max: 12,min: 8,clr: Colors.white,weight: FontWeight.w600,),
                                      ],),
                                      SizedBox(height:5),
                                       Text1(data: "$SecondText",max: 10,min: 8,clr: Colors.white54,weight: FontWeight.w100),
                                    ]
                                  );
  }

}

class DetailSideMenu extends GetxController{
  // final String value;
  // DetailSideMenu({required this.value});
  var select = DetailSelectedItem(selected: "All",item: 0).obs;
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