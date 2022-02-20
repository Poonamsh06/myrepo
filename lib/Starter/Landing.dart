import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Functions/ReverseGeocode.dart';

import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/starter_controller.dart';
import 'package:pujapurohit/SignIn/login_page.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';

import 'package:pujapurohit/Widgets/bottombar.dart';
import 'package:pujapurohit/Widgets/youtube_player.dart';
import 'package:pujapurohit/colors/light_colors.dart';

import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/loginController.dart';


import 'package:url_launcher/link.dart';

import 'package:url_launcher/url_launcher.dart';

class Landing extends StatelessWidget{
  LoginController loginController = Get.put(LoginController());

   
  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.find();
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
   StarterController starterController = Get.put(StarterController());
   
    var screenSize = MediaQuery.of(context).size;
    
   
    const _url = 'https://play.google.com/store/apps/details?id=com.pujapurohit.android.infopujapurohit';

  getLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    locationController.updateLat(position.latitude, position.longitude);
   // locationController.updateAddress(position.latitude.toString(),position.longitude.toString());
    Get.toNamed('/home');
  }
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
    TextEditingController phone = TextEditingController();
    return Scrollbar(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _key,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Obx((){
                 return  Container(              
                  width: screenSize.width,
                  child:starterController.skip.value?Column(
                    children: [
                       Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){
                                  starterController.updateValue();
                                }, child: Text1(data: "SKIP",clr: Colors.grey,max: 14,min: 12,))
                              ],
                            ),
                            SizedBox(height:10),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: Get.height*0.7,
                        width: ResponsiveWidget.isSmallScreen(context)?screenSize.width*0.9:screenSize.width*0.5,
                        child:Auth()
                      ),
                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: ResponsiveWidget.isSmallScreen(context)?screenSize.width:screenSize.width*0.5,                     
                        child: Padding(
                          padding: EdgeInsets.only(left:16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap:(){},
                                    child: Image.asset('assets/images/logo.png',fit: BoxFit.fill,height: 100,width: 100,),
                                  ),
                                  SizedBox(width: screenSize.width*0.2,),
                                  // Expanded(
                                  //   child: TextButton(onPressed: (){
                                  //     loginController.signin();
                                  //     _key.currentState!.openEndDrawer();
                                  //   },
                                  //       child: AutoSizeText('Login',style: TextStyle(color: Colors.black),maxFontSize: 18,) ),
                                  // ),
                                  // Expanded(
                                  //     child: InkWell(
                                  //       onTap: (){
                                  //         loginController.signup();
                                  //          _key.currentState!.openEndDrawer();
                                  //       },
                                  //       child: Container(
                                  //         height: 50,width: 70,
                                  //         color: LightColors.kDarkYellow,
                                  //         child: Center(child: Text('SignUp',style: TextStyle(fontSize: 18,color: Colors.white),),heightFactor: 10,),
                                  //       ),
                                  //     )
                                  // )
                                ],
                              ),
                              ResponsiveWidget.isSmallScreen(context)? SizedBox(height: screenSize.height*0.01,):SizedBox(),
                                  ResponsiveWidget.isSmallScreen(context)? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                                        width:screenSize.width*0.7 ,
                                                          height: screenSize.height*0.3,
                                                          child: YoutubeAppDemo(id: "X19FYK5Q684")
                                                        
                                                        ),
                                    ],
                                  ):SizedBox(),
                              //SizedBox(height: screenSize.height*0.2,),
                              Row(
                                children: [
                                  ResponsiveWidget.isSmallScreen(context) ?AutoSizeText('जय सनातन',maxFontSize: ResponsiveWidget.isSmallScreen(context)?20:40,minFontSize:ResponsiveWidget.isSmallScreen(context)?16: 30,style:  TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),):AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        TypewriterAnimatedText('जय सनातन',textStyle: TextStyle(fontSize:ResponsiveWidget.isSmallScreen(context)?20: 40,color: Colors.black54,fontWeight: FontWeight.bold)),
                                      ]

                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child:
                                  SelectableText('Book experienced purohit near you.',style: TextStyle(fontSize: ResponsiveWidget.isSmallScreen(context)?20:30,color: Colors.black54,))),
                                ],
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: (){
                                  getLocation();
                                       
                                 
                                },
                                                                child: Container(
                                  color: LightColors.kDarkYellow,
                                  height: screenSize.height*0.08,
                                  width: ResponsiveWidget.isSmallScreen(context)?screenSize.width*0.7:screenSize.width*0.44,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded
                                      (
                                        child: Center(child: Text1(max: 14, data: "Locate Me", min: 12,clr:Colors.white)),
                                      //    child: Container(
                                      //   color: Colors.green,
                                      //   margin: EdgeInsets.all(5),
                                      //   width: screenSize.width*0.2,
                                      //   child: ModifiedText(max: 12, data: "Choose on Map", min: 11,color:Colors.white),
                                      //   // child: TextFormField(
                                      //   //   controller: phone,
                                      //   //   decoration: InputDecoration(                                              
                                      //   //       border: InputBorder.none,
                                      //   //       hintText: 'Enter your location'
                                      //   //   ),
                                      //   // ),
                                      // )
                                      ),
                                      Expanded(
                                        
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                           // Icon(Icons.gps_fixed_outlined,color: Color(0xffffbd59),),
                                            SizedBox(width: 5,),
                                            Expanded(
                                              child: InkWell(
                                                onTap: ()async{                                                                                                
                                                              
                                                          starterController.updateValuetrue();    
                                                                                                      },
                                                child: Container(
                                                  height:screenSize.height*0.08,width:ResponsiveWidget.isSmallScreen(context)? screenSize.width*0.09:screenSize.width*0.05,
                                                  color: Colors.white,
                                                  child: Center(child: Text1(max: 14, data: "Log In", min: 12,clr:Colors.black),),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height*0.05,),
                              SelectableText('Online Pandit booking Platform',style: TextStyle(color: Colors.grey,wordSpacing: 2.0,fontSize: ResponsiveWidget.isSmallScreen(context)?20:30),),
                              SizedBox(height: 10,),
                              SelectableText('Book purohit/pandit in minimum cost with puja purohit',style: TextStyle(fontSize: ResponsiveWidget.isSmallScreen(context)?12:16,fontWeight: FontWeight.bold,color: Colors.black54),)
                            ],
                          ),
                        ),
                      ),
                      ResponsiveWidget.isSmallScreen(context)?SizedBox():Container(
                        margin:EdgeInsets.only(top: Get.height*0.1,left: 20),
                        width: screenSize.width*0.45,
                        //color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Image.network('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2FVectors%2FPandits%20standing%20with%20phone.png?alt=media&token=2069f246-e000-4fa2-a153-91160bd87bb9',fit: BoxFit.cover,),
                            Container(
                                  width:screenSize.width*0.45 ,
                                  height: screenSize.height*0.7,
                                  child: YoutubeAppDemo(id: "X19FYK5Q684")
                                
                                )
                          ],
                        ),
                      )
                    ],
                  ),
                );
               }),
              
                SizedBox(height: screenSize.height*0.01,),
                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Stack(
                    children: [
                      Container(
                        
                        width: screenSize.width,
                        child: Image.network('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fsales%2Fdelivery5.jpg?alt=media&token=9e8403b0-9b89-4020-af30-78d283165ea4',fit: BoxFit.fill,),
                      ),
                      ResponsiveWidget.isSmallScreen(context) ?SelectableText('Free Samagri Delivery',style:  TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.bold),):AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText('Free Samagri Delivery',textStyle: TextStyle(fontSize:  40,color: Colors.black54,fontWeight: FontWeight.bold)),
                          ]

                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height*0.01,),
                Padding(padding: EdgeInsets.only(left:16),
                  child: Container(
                    width: screenSize.width,
                    child: Row(
                      children: [
                        Container(
                          width: screenSize.width*0.45,
                          child: Padding(
                            padding: const EdgeInsets.only(left:16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ResponsiveWidget.isSmallScreen(context) ?AutoSizeText('Hinduism Activities in your Pocket',maxFontSize:ResponsiveWidget.isSmallScreen(context)?20: 40,minFontSize: ResponsiveWidget.isSmallScreen(context)?16:30,style:  TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),): AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      TypewriterAnimatedText('Hinduism Activities in your Pocket',textStyle: TextStyle(fontSize: 40,color: Colors.black54,fontWeight: FontWeight.bold)),
                                    ]
                                ),
                                SizedBox(height: screenSize.height*0.02,),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: SelectableText('Book your purohit, Get your pujan samagri in just one click\nCall premium astrologers in minimum cost, with all new Puja Purohit App.',style: TextStyle(color: Colors.black54,fontSize: ResponsiveWidget.isSmallScreen(context)?18:24)),
                                ),
                                SizedBox(height: screenSize.height*0.02,),
                                SizedBox(
                                  height: screenSize.height*0.1,
                                  width: screenSize.width*0.5,
                                  child: InkWell(
                                      onTap: (){
                                        _launchInBrowser(_url);
                                      },
                                      child: Image.asset('assets/images/google-play-badge.png')),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.width*0.50,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                    height: screenSize.height*0.7,
                                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fsales%2F1617822997578.png?alt=media&token=32bfa13d-17f5-441f-9f38-cc1b9a1978cc')),
                              ),
                              Expanded(
                                child: Container(
                                    height: screenSize.height*0.7,
                                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fsales%2Fsmartmockups_kn7uog18.png?alt=media&token=0297f9f4-5140-45cc-be6e-d48366ad86e1')),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height*0.05,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BottomBar()
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
