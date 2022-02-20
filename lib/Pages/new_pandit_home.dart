import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Models/BModal.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/SignIn/login_page.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/bottombar.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:pujapurohit/controller/CommonController.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'package:pujapurohit/controller/loginController.dart';
import 'package:url_launcher/link.dart';
import 'PanditSection/Controllers/date_contrller.dart';
import 'PanditSection/Controllers/pandits_controller.dart';
import 'PanditSection/Controllers/trending_controller.dart';
import 'PanditSection/Controllers/upcomig_event.dart';
import 'PanditSection/Widgets/cards.dart';
import 'PanditSection/Widgets/image_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

import 'location_change.dart';

class NewPanditHome extends StatefulWidget{
 
  
  
  @override
  _NewPanditHomeState createState() => _NewPanditHomeState();
}

class _NewPanditHomeState extends State<NewPanditHome> {
  DateTime _currentdate = DateTime.now();
@override
  // void initState() {
  //   super.initState();
  //   double height  = MediaQuery.of(context).size.height;
  //   double width = MediaQuery.of(context).size.width;
  //    WidgetsBinding.instance!.addPostFrameCallback((_) async {
  //     await showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => new AlertDialog(            
  //             content: Image.network('https://user-images.githubusercontent.com/51439795/96189834-e9888680-0f49-11eb-8c57-5ee8fb00cbdf.png'),
              
  //           ),
  //     );
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    String _formatdate = DateFormat.yMMMd().format(_currentdate);
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    AuthController authController = Get.find();
    UserController userController = Get.put(UserController());
    LoginController loginController = Get.put(LoginController());
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    var ScreenSize= MediaQuery.of(context).size;
   return Scaffold(
     //backgroundColor: Colors.white,
     appBar: PreferredSize(preferredSize: Size(ScreenSize.width,height*0.099,), 
      child:TopTabs()
      
      
      ),
     body:
     GetX<DateController>(
       init: Get.put(DateController()),
       builder: (DateController dateController){
        if(dateController.userModel.value.background!=null){
          return 
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:ResponsiveWidget.isSmallScreen(context)?width*0.05: width*0.1),
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      //  Expanded(
                      //    flex: 1,
                      //    child: Topbar('Offers','https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/New%20App%2FGift-box-pink---vector-PNG-removebg-preview.png?alt=media&token=6881a7a9-777f-4fcd-9eea-fb97ab7f7ee4','offers')),                      
                     //  SizedBox(width:10),
                        Expanded(
                           flex: 1,
                           child: TopBar(name:'Calender',image:'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/NewAppFiles%2Ftopbars%2FOnline%20calendar-amico%20(1).png?alt=media&token=46e017ce-63eb-42b7-a8b5-281bc2e1d850',tap:'calender')),
                       SizedBox(width:10),
                      //  Expanded(
                      //      flex: 1,
                      //      child: TopBar(name:'Varat & Upavas',image:'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/NewAppFiles%2Ftopbars%2F25-251511_mix-fruit-vector-png-transparent-png-removebg-preview.png?alt=media&token=520b471b-041d-485a-a597-bfaecdc4fdf6',tap:'varat')),
                       SizedBox(width:10),
                       Expanded(
                           flex: 1,
                           child: TopBar(name:'Pujan Vidhi',image:'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/NewAppFiles%2Ftopbars%2FProcessing-rafiki%20(2).png?alt=media&token=dc2c3e8a-22f7-4ac3-bb5d-58d02fbab3e9',tap:'pujanvidhi')),
                       SizedBox(height:10),
                       Expanded(
                           flex: 1,
                           child: TopBar(name:'Facts/Article',image: 'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/NewAppFiles%2Ftopbars%2FSharing%20articles-rafiki.png?alt=media&token=51fde7f6-940a-4ba0-b915-16b5d33c24e6', tap:'article')),
                     
                       SizedBox(height:10),
                       
                        Expanded(
                           flex: 1,
                           child: TopBar(name:'Muhurat',image: 'https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/NewAppFiles%2Ftopbars%2FTime%20management-bro.png?alt=media&token=9b57c040-c94b-42da-b3e4-6b0d1a793f7d',tap:'muhurat')),
                      
                                        
                     ],
                      ),
                  ) ,  

                   StreamBuilder<QuerySnapshot>(
                             stream: FirebaseFirestore.instance.collection('PujaPurohitFiles/sliders/second').snapshots(),
                             builder: (context, snapshot) {
                               if(snapshot.data == null){
                                 return Center(child: SizedBox(height: 50,child: Loader(),),);
                               }
                                List<String> imgList = [];
                               List<Widget> imageSliders = imgList.map((item) => Container(height:200,width:100,child: Image.network(item, fit: BoxFit.cover,)),).toList();
                               List<Widget> sliders = [];                             
                               for(var i in snapshot.data!.docs){
                                 final imageData = sliderOffers(context, height, width,i.get('link'),i.get('image'),);
                                 sliders.add(imageData);                                      }
                             
                               return CarouselSlider(
                                 options: CarouselOptions(
                                   height:ResponsiveWidget.isSmallScreen(context)?height*0.22:ResponsiveWidget.isMediumScreen(context)?height*0.35: height*0.5,
                                     pauseAutoPlayInFiniteScroll: true,
                                     pauseAutoPlayOnTouch: true,
                                     autoPlayInterval: Duration(seconds: 3),
                                     autoPlay: true,
                                     enlargeCenterPage: true
                                 ),
                                 items: sliders,
                               );
                             }
                           ),
                        SizedBox(height: 15,),
                  Container(
                     padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 0:width*0.1,right:ResponsiveWidget.isSmallScreen(context)? 0: width*0.1,),
                        height:ResponsiveWidget.isSmallScreen(context)?height*0.3: height*0.4,
                        width: width,
                       // color: Colors.white,
                       // padding: EdgeInsets.only(left:width*0.1,right: width*0.05),
                        child: GetX<UpcomingEventController>(
                          init: Get.put<UpcomingEventController>(UpcomingEventController()),
                          builder: (UpcomingEventController upcomingController) {
                         if (upcomingController != null && upcomingController.upcomings != null) {
                           return  ListView.builder(
                             scrollDirection: Axis.horizontal,
                             shrinkWrap: true,
                             itemCount: upcomingController.upcomingList.value!.length,
                             itemBuilder: (_, index) {
                               return scrollImage(upcomingController.upcomings![index].link!,width,height,upcomingController.upcomings![index].image!,context);
                             },
                           );
                         } else {
                           return Center(child: SizedBox(
                               height: 50,width: 50,
                               child: Loader()));
                         }
                          },
                        ),
                         ),
                          SizedBox(height: 20,),           
                  Padding(padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 0: width*0.1,right:ResponsiveWidget.isSmallScreen(context)? 0: width*0.1),
                  child: customHeading(context,'Purohit','Near you...'),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                   padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 0: width*0.1,right: ResponsiveWidget.isSmallScreen(context)? 0:width*0.1,bottom: 40),
                  child: GetX<PanditController>(
                    init: Get.put<PanditController>(PanditController(lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'))),
                    builder: (PanditController panditController) {
                      if (panditController != null && panditController.pandits != null) {
                        return ResponsiveWidget.isSmallScreen(context) ?ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: panditController.panditList.value!.length,
                            itemBuilder: (_, index) {
                              return NewPanditCard(bModal: panditController.pandits![index]);
                            },
                          ):
                          GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                       crossAxisCount: ResponsiveWidget.isMediumScreen(context)?3:4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: ResponsiveWidget.isMediumScreen(context) ?1:2,

                                  ),  
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: panditController.panditList.value!.length,
                                itemBuilder: (_, index) {
                                  return NewPanditCard(bModal: panditController.pandits![index]);
                                }, 
                              );
                          
                      } else {
                        return Center(child: SizedBox(
                            height: 50,width: 50,
                            child: Loader()));
                      }
                    },
                  ),
                    )
                ,
                 ResponsiveWidget.isSmallScreen(context)?MobileBottomBar():NewBottomBar()
                ]
            ),
          );
        }
        else{
          return Center(child: Text('Loading...'),);
        }
       },
     )

   );
}


Widget sliderOffers(BuildContext context, double height, double width,String link,String img) {
    return Link(
      target:LinkTarget.blank,
      uri: Uri.parse('$link'),
      builder: (_,followlink){
        return InkWell(
          hoverColor: Colors.white,
          onTap: followlink,
          child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //margin:EdgeInsets.all(ResponsiveWidget.isSmallScreen(context)?20:40),
                            height:ResponsiveWidget.isSmallScreen(context)?height*0.25:ResponsiveWidget.isMediumScreen(context)?height*0.4: height*0.5,
                            width: ResponsiveWidget.isLargeScreen(context)?width*0.7 :width*0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: NetworkImage('$img'),
                            fit: BoxFit.fill
                            )),
                          ),
                        ],
                      ),
        );
      },
    );
  }

 
  Widget scrollImage(String link,double width,double height,String image,BuildContext context) {
    
    return Link(
     //ri: Uri.parse('http://localhost:50183/#/detail?detail=$link'), 
      uri: Uri.parse('http://pujapurohit.in/#/detail?id=$link'), 
      target: LinkTarget.blank,
      builder: (context,followlink){
        return InkWell(
          onTap: followlink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HoverWidget(
                onHover: (event){},
                hoverChild: Stack(
                  children: [
                    Container(
                         height:height*0.4,
                         margin: EdgeInsets.all(30),
                         decoration: BoxDecoration(
                         color: Colors.white,
                        //image: DecorationImage(image: NetworkImage('$image'),fit: BoxFit.fill)
                            ),
                            child: Image.network(image,height: height*0.1,)
                            ),
                  ],
                ),
                child: Container(
                     height:height*0.3,
                     margin: EdgeInsets.all(30),
                     decoration: BoxDecoration(
                     color: Colors.white,
                    //image: DecorationImage(image: NetworkImage('$image'),fit: BoxFit.fill)
                        ),
                        child: Image.network(image)
                        ),
              ),
            ],
          ),
        );
      });
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



class TopTabs extends StatelessWidget{
   AuthController authController = Get.find();
   // UserController userController = Get.put(UserController());
    LoginController loginController = Get.put(LoginController());
    
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: Color(0xffFFFAF3),
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
                        onTap:(){Get.toNamed('/home');},
                        child: Image.asset('assets/images/logo.png',fit: BoxFit.fill,height: 60,width: 60,),
                      ),
                      SizedBox(width:10),
                       
                       
                    ],
                  ),
                 ResponsiveWidget.isSmallScreen(context)? Row(children: [
                   SizedBox(width: 20,),
                   Icon(LineIcons.search,size: 18,color: Colors.black54,),
                   SizedBox(width: 20,),
                   IconButton(icon: Icon(LineIcons.user,color: Colors.black54,size: 18,),onPressed: (){
                     Get.toNamed('/account');
                   },),
                   
                 ],):Row(
                    children: [
                      SizedBox(width: 20,),
                      ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.search, max: 12, data: 'Search', min: 8,color: Colors.black54,weight: FontWeight.bold,),
                      SizedBox(width: 20,),
                      authController.user!=null?
                      InkWell(
                        onTap: (){
                          Get.toNamed('/account');
                        },
                        child: ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.user, max: 12, data: '${authController.user!.displayName}', min: 8,color: Colors.black54,weight: FontWeight.bold))
                      :
                      InkWell(
                        onTap: (){
                          loginController.signin();
                          Get.to(Auth());

                        },
                        child: ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.user, max: 12, data: 'Sign In', min: 8,color: Colors.black54,weight: FontWeight.bold),
                      ),
                      
                      SizedBox(width: 20,),
                      ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.shoppingBag, max: 12, data: 'Cart', min: 8,color: Colors.black54,weight: FontWeight.bold),
                    ],
                  )
                ],
              ),
            ),
          );
  }

}
class TopBar extends StatelessWidget{
  final String? name;
  final String? image;
  final String? tap;
  TopBar({this.name,this.image,this.tap});
  @override
  Widget build(BuildContext context) {
   return Link(
      uri: Uri.parse('http://pujapurohit.in/#/$tap'),
      target: LinkTarget.blank,
      builder: (context,followlink){
        return InkWell(
            onTap: followlink,
            hoverColor: Colors.transparent,
          child: HoverWidget(
            onHover: (event){},
            hoverChild:  Container(
            alignment: Alignment.center,
                        height:120,width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Container(
                              height: ResponsiveWidget.isSmallScreen(context)?28:65,width: ResponsiveWidget.isSmallScreen(context)?28:65,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage('$image'),
                                fit: BoxFit.fill
                                )
                              ),
                            ),
                            SizedBox(height:10),
                            Text2(data: "$name", max: ResponsiveWidget.isSmallScreen(context)?10:14,)
                          ]
                        ),
                      ),
            child: Container(
              alignment: Alignment.center,
                          height:100,width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Container(
                                height: ResponsiveWidget.isSmallScreen(context)?25:65,width: ResponsiveWidget.isSmallScreen(context)?25:65,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage('$image'),
                                  fit: BoxFit.fill
                                  )
                                ),
                              ),
                              SizedBox(height:10),
                              Text2(data: "$name", max: ResponsiveWidget.isSmallScreen(context)?8:12,)
                            ]
                          ),
                        ),
          ),
    );
        },
    );
  }

}
class NewPanditCard extends StatelessWidget{
  final String? name;
  final String? uid;
  final BMModal bModal;
  NewPanditCard({required this.bModal, this.name,this.uid});
  
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;
    final UserController userController = Get.put(UserController());
    GeoPoint geoPoint = bModal.location!['geopoint'];
    double distanceInMeters = Geolocator.distanceBetween(double.parse('${userController.userModel.value.lat}'),double.parse('${userController.userModel.value.lng}'), geoPoint.latitude, geoPoint.longitude);
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: (){
        FareBreakup farebreakup = Get.put(FareBreakup());
        farebreakup.pandit(bModal.image!, bModal.name!, bModal.number!, bModal.token!,bModal.uid!,double.parse('${(distanceInMeters/1000).toStringAsFixed(2)}'));
        CommonController commonController = Get.put(CommonController());
        commonController.updatePandit(bModal.uid!);
        Get.toNamed('/profile?puid=${bModal.uid}');
      },
      child: HoverWidget(
        onHover: (event){},
        hoverChild: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xff181c2c)),            
            boxShadow: [
              BoxShadow(
                color: LightColors.shadowColor,
                blurRadius: 20
              )
            ]
          ),
         
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 80,width: 80,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.white,blurRadius: 20)],
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('${bModal.image}'),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ],
                   ),
      
                    SizedBox(height: 15,),
                    Row(
                      children: [
                      Text1(max: 12, data: '${bModal.name}', min: 12,weight: FontWeight.w600,),
                      SizedBox(width:10),
                      bModal.verified?Icon(Icons.verified,size: 13,color: Color(0xff34B7F1),):SizedBox()
                    ],),
                    SizedBox(height:10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        rating(),
                        SizedBox(width:10),
                        Icon(Icons.circle,color: Colors.black54,size: 2,),
                        SizedBox(width:10),
                        Text1(max: 10, data: '${bModal.city}', min: 10,clr: Colors.black54,),
                        SizedBox(width:10),
                        Icon(Icons.circle,color: Colors.black54,size: 2,),
                        SizedBox(width:10),
                        Text1(max: 10, data: '${bModal.state}', min: 10,clr: Colors.black54,),
                        SizedBox(width:10),
                        Icon(Icons.circle,color: Colors.black54,size: 2,),
                        SizedBox(width:10),
                        Text1(max: 10, data: '${(distanceInMeters/1000).toStringAsFixed(2)} KM', min: 10,clr: Colors.black54,),
                      ],
                    ),
                  ],
                ),
              ),
      
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
      
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 80,width: 80,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.white,blurRadius: 20)],
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('${bModal.image}'),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ],
                   ),
      
                    SizedBox(height: 15,),
                    Row(
                      children: [
                      Text1(max: 12, data: '${bModal.name}', min: 12,weight: FontWeight.w600,),
                      SizedBox(width:10),
                      bModal.verified?Icon(Icons.verified,size: 13,color: Color(0xff34B7F1),):SizedBox()
                    ],),
                    SizedBox(height:10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        rating(),
                        SizedBox(width:10),
                        Icon(Icons.circle,color: Colors.black54,size: 2,),
                        SizedBox(width:10),
                        Text1(max: 10, data: '${bModal.city}', min: 10,clr: Colors.black54,),
                        SizedBox(width:10),
                        Icon(Icons.circle,color: Colors.black54,size: 2,),
                        SizedBox(width:10),
                        Text1(max: 10, data: '${bModal.state}', min: 10,clr: Colors.black54,),
                        SizedBox(width:10),
                        Icon(Icons.circle,color: Colors.black54,size: 2,),
                        SizedBox(width:10),
                        Text1(max: 10, data: '${(distanceInMeters/1000).toStringAsFixed(2)} KM', min: 10,clr: Colors.black54,),
                      ],
                    ),
                  ],
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
Widget rating(){
    var swastik = bModal.swastik;
    int? rates = bModal.raters;
    double? overall_rate=swastik!/rates!;
    if(overall_rate!>=4){
      return newrate(overall_rate,Colors.green);
    }
    if(overall_rate >=3 && overall_rate<4){
      return  newrate(overall_rate,Colors.orangeAccent);
    }
   return  newrate(overall_rate>=0?bModal.swastik!:0, Colors.green);

 
   
}

  Container newrate(double overall_rate,Color clr) {
    return Container(
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(5),),
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Row(children: [
        Icon(Icons.star,color:Colors.white,size:12),
        SizedBox(width:2),
        Text1(max: 12, data: overall_rate==0.0?'5.0':'${overall_rate.toStringAsFixed(1)}', min: 11,clr: Colors.white,)
      ],),
    );
  }
}




class ModifiedTextIcon extends StatelessWidget{
  String data;
  double max;
  Color? color;
  double min;
  FontWeight? weight;
  IconData icondata;
  Color? iconColor;
  ModifiedTextIcon({this.iconColor, required this.icondata,required this.max,required this.data,required this. min,this.color,this.weight});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(icondata,color: iconColor,),
        SizedBox(width:5),
        AutoSizeText('$data',maxFontSize: max,minFontSize: min,style: GoogleFonts.aBeeZee(color: color,fontWeight: weight,letterSpacing: 1),),
      ],
    );
  }

}