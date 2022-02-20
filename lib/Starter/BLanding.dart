import 'dart:typed_data';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/login_page.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/loginController.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class BLanding extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    const _url = 'https://play.google.com/store/apps/details?id=com.pujapurohit.android.infopujapurohit';
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
    locateMe()async{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      locationController.updateLat(position.latitude, position.longitude);
      // locationController.updateAddress(position.latitude.toString(),position.longitude.toString());
      Get.toNamed('/home');
    }
    ScrollController _controller = new ScrollController();
    double height  = MediaQuery.of(context).size.height;
    double width  = MediaQuery.of(context).size.width;
    final LoginController loginController = Get.put(LoginController());
    void _goToElement(int index){
      _controller.animateTo((100.0 * index), // 100 is the height of container and index of 6th element is 5
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut);
    }
    return Scaffold(
        key: _key,
        endDrawer: Container(
          height: height,
          width: width*0.3,
          child: Drawer(child: Auth()),
        ),
        backgroundColor: context.theme.backgroundColor,
        body: ResponsiveWidget.isSmallScreen(context)?MobileLanding():SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ResponsiveWidget.isMediumScreen(context)?height*0.1:height*0.2,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding:  EdgeInsets.only(top:ResponsiveWidget.isMediumScreen(context)?height*0.06:height*0.1),
                      child: Column(

                        children: [
                          Container(
                            // width: Get.width*0.38,
                            // height:Get.height*0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left:ResponsiveWidget.isMediumScreen(context)?20:40.0,right: ResponsiveWidget.isMediumScreen(context)?20:40),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/logo.png",height:ResponsiveWidget.isMediumScreen(context)? 100:138,width:ResponsiveWidget.isMediumScreen(context)? 120:148,),
                                      Spacer(),
                                      InkWell(
                                        hoverColor: Colors.white,
                                        onTap: (){
                                          _key.currentState!.openEndDrawer();
                                          loginController.signin();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top:ResponsiveWidget.isMediumScreen(context)?20: 40),
                                          color: Colors.white,
                                          padding: EdgeInsets.only(left:ResponsiveWidget.isMediumScreen(context)?15:25,right:ResponsiveWidget.isMediumScreen(context)?15: 25,top:ResponsiveWidget.isMediumScreen(context)?5: 10,bottom:ResponsiveWidget.isMediumScreen(context)?5: 10),
                                          alignment: Alignment.center,
                                          child: Text1(data: "Login", max: ResponsiveWidget.isMediumScreen(context)?12:14, min: 12,clr: Colors.black,),
                                        ),
                                      ),
                                      InkWell(
                                        hoverColor: Colors.white,
                                        onTap: (){
                                          loginController.signup();
                                          _key.currentState!.openEndDrawer();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top:ResponsiveWidget.isMediumScreen(context)?20: 40),
                                          color: Colors.black,
                                          padding: EdgeInsets.only(left:ResponsiveWidget.isMediumScreen(context)?15:25,right:ResponsiveWidget.isMediumScreen(context)?15: 25,top:ResponsiveWidget.isMediumScreen(context)?5: 10,bottom:ResponsiveWidget.isMediumScreen(context)?5: 10),
                                          alignment: Alignment.center,
                                          child: Text1(data: "Sign Up", max: ResponsiveWidget.isMediumScreen(context)?12:14, min: 12,clr: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: ResponsiveWidget.isMediumScreen(context)?height*0.01: height*0.1,),
                                Padding(
                                  padding: EdgeInsets.only(left:width*0.04),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height:50,

                                            pauseAutoPlayInFiniteScroll: true,
                                            autoPlay: true,
                                            enlargeCenterPage: false,
                                            scrollDirection: Axis.vertical,
                                            autoPlayInterval: Duration(seconds: 3),
                                          ),
                                          items:[
                                            SelectableText("जय सनातन",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 32,color: Colors.black87),),
                                            SelectableText("জয় সনাতন",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black87),),
                                            SelectableText("ஜெய் சனாதன்",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black87),),
                                            SelectableText("జై సనాతన్",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black87),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height:40,

                                            pauseAutoPlayInFiniteScroll: true,
                                            autoPlay: true,
                                            enlargeCenterPage: false,
                                            scrollDirection: Axis.vertical,
                                            autoPlayInterval: Duration(seconds: 3),
                                          ),
                                          items:[
                                            SelectableText('  Book pandit online near you.',style: TextStyle(fontSize: ResponsiveWidget.isMediumScreen(context)?20:23,color: Colors.black54,)),
                                            SelectableText('  Start your spritual journey.',style: TextStyle(fontSize: ResponsiveWidget.isMediumScreen(context)?20:23,color: Colors.black54,)),

                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:ResponsiveWidget.isMediumScreen(context)?416 :616,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                // Container(
                                                //   padding: EdgeInsets.all(5),
                                                //   alignment: Alignment.center,
                                                //   width:ResponsiveWidget.isMediumScreen(context)?width*0.2:width*0.25,
                                                //   // decoration: BoxDecoration(
                                                //   //   border: Border.all(
                                                //   //     color: Colors.orangeAccent
                                                //   //   ),
                                                //   // ),
                                                //   child: TextField(
                                                //     enabled: false,
                                                //     decoration:InputDecoration(
                                                //       border: InputBorder.none,
                                                //       hintText: " Continue your spritual journey",
                                                //       hintStyle: TextStyle(fontSize: ResponsiveWidget.isMediumScreen(context)?20:30,color: Colors.black54,)
                                                //       //suffix: Text1(data: "locate me", max: 12, min: 11)
                                                //     )
                                                //   ),
                                                // ),
                                                SizedBox(width: 18,),
                                                InkWell(
                                                  onTap:(){
                                                    locateMe();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      // borderRadius: BorderRadius.circular(10),
                                                      // gradient: LinearGradient(
                                                      //   colors: [
                                                      //    Color(0xffFD7F2C),
                                                      //     Color(0xffFD9346)
                                                      //   ]
                                                      // )
                                                    ),
                                                    alignment: Alignment.center,

                                                    width: ResponsiveWidget.isMediumScreen(context)?width*0.1:width*0.07,
                                                    height:ResponsiveWidget.isMediumScreen(context)?height*0.066: height*0.06,

                                                    child: Text1(data: "Find Purohit", max:ResponsiveWidget.isMediumScreen(context)?12:16, min: ResponsiveWidget.isMediumScreen(context)?10:14,clr: Colors.white,weight: FontWeight.bold,),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Text2(data: "    BOOK PUROHIT IN POPULAR CITIES OF INDIA", max: ResponsiveWidget.isMediumScreen(context)?12:18,clr:Colors.black45),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Center(
                                                child: RichText(
                                                  textAlign: TextAlign.end,
                                                  text: TextSpan(

                                                      style: TextStyle(
                                                          color: Colors.black, fontSize: 18),
                                                      children: <TextSpan>[
                                                        TextSpan(text: ' DELHI',
                                                            style: TextStyle(
                                                                color: Colors.black87, fontSize: ResponsiveWidget.isMediumScreen(context)?12:16,fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Get.toNamed('/location?district=Delhi');
                                                              }
                                                        ),
                                                        TextSpan(text: '  BANGLORE',
                                                            style: TextStyle(
                                                                color: Colors.black54, fontSize: ResponsiveWidget.isMediumScreen(context)?12:16,fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Get.toNamed('/location?district=Bengaluru');
                                                              }
                                                        ),
                                                        TextSpan(text: '  MUMBAI',
                                                            style: TextStyle(
                                                                color: Colors.black87, fontSize: ResponsiveWidget.isMediumScreen(context)?12:16,fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Get.toNamed('/location?district=Mumbai');
                                                              }
                                                        ),
                                                        TextSpan(text: '  LUCKNOW',
                                                            style: TextStyle(
                                                                color: Colors.black54, fontSize: ResponsiveWidget.isMediumScreen(context)?12:16,fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Get.toNamed('/location?district=Lucknow');
                                                              }
                                                        ),
                                                        TextSpan(text: '  JAIPUR',
                                                            style: TextStyle(
                                                                color: Colors.black87, fontSize: ResponsiveWidget.isMediumScreen(context)?12:16,fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                // navigate to desired screen
                                                              }
                                                        ),
                                                        TextSpan(text: '  VIEW MORE',
                                                            style: TextStyle(
                                                                color: Colors.black54, fontSize: ResponsiveWidget.isMediumScreen(context)?12:16,fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                _goToElement(18);
                                                              }
                                                        )
                                                      ]
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 30,),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Container(
                        //color: Color(0xffFFEBD3).withOpacity(0.5),
                        margin: EdgeInsets.only(top: Get.height*0.1),
                        alignment: Alignment.center,
                        width: width*0.35,
                        height:ResponsiveWidget.isMediumScreen(context)?height*0.35: height*0.55,
                        child: Image.network("https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2FGroup%202.png?alt=media&token=c9dafa09-2684-4d1b-ad1b-1452d800b13d")
                    ),
                  )
                ],
              ),
              Container(
                width: width,
                height:ResponsiveWidget.isMediumScreen(context)?300: 450,
                padding: EdgeInsets.only(left:20,right: 20,bottom: 20),
                color: Color(0xff3E251E),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Image.network("https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2FGroup%207.png?alt=media&token=56d60d23-7a32-47c2-9dc9-f14ff951dd4a",height: ResponsiveWidget.isMediumScreen(context)?120:196,),
                                SizedBox(height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.05,),
                                Text2(data: "NOW BOOK PUROHIT ONLINE", max: ResponsiveWidget.isMediumScreen(context)?11:14, clr: Colors.white,),
                                SizedBox(height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.05,),
                                Text2(data: "BOOK PUJA FOR YOURSELF AND YOUR LOVES ONES", max: ResponsiveWidget.isMediumScreen(context)?11:14, clr: Colors.white,),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Image.network("https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2FFrame.png?alt=media&token=e8954c1c-86f5-4967-8191-756c09938d1a",height: ResponsiveWidget.isMediumScreen(context)?120:196,),
                                SizedBox(height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.05,),
                                Text2(data: "GET PUROHIT NEARBY YOU ",max: ResponsiveWidget.isMediumScreen(context)?11:14, clr: Colors.white,),
                                SizedBox(height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.05,),
                                Text2(data: "TRACK YOUR SURROUNDING PUROHIT WITH OUR LATEST ETA SYSTEM", max: ResponsiveWidget.isMediumScreen(context)?11:14, clr: Colors.white,),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Image.network("https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2FGroup%205.png?alt=media&token=590b994b-1c62-41a0-b528-f532616dd2ea",height: ResponsiveWidget.isMediumScreen(context)?120:196,),
                                SizedBox(height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.05,),
                                Text2(data: "FAST DELIVERY", max: ResponsiveWidget.isMediumScreen(context)?11:14, clr: Colors.white,),
                                SizedBox(height:ResponsiveWidget.isMediumScreen(context)?height*0.03: height*0.05,),
                                Text2(data: "GET SAMGRI AND PRODUCTS WITH THE LIGHTNING FAST DELIVERY", max: ResponsiveWidget.isMediumScreen(context)?11:14, clr: Colors.white,),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
              Container(
                height: 650,
                color: Color(0xfffcfcfc),
                padding: EdgeInsets.only(left: width*0.1,),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText("Hinduism Activities in your pocket",style: GoogleFonts.openSans(fontSize:34,color: Colors.black,fontWeight: FontWeight.bold)),
                            SizedBox(height: 10,),
                            SelectableText("Book your purohit, Get your puja samagri in just on click. Book your puja products with our Puja Purohit Mart. Puja Purohit is an online service provider for online pandit booking wherein customers may select from a wide variety of Pujas such as , satyanarayan puja, griha pravesh , marriage ceremony, engagement ceremony, Laxmi puja , Ganesha puja and Durga puja, mata ki chouki and jaagran, maha mritunjya jap, havans, naming ceremony, mundan ceremony, birthday ceremony, last rite rituals and many others. Puja Purohit shall connect customers seeking such services with the relevant Pandit Jee chosen by customer itself, who shall provide the services at the customer’s doorstep/venue of choice. Puja Purohit aims to serve you for your exact and customised religious need with our well experienced Purohit's and puja samagri at reasonable prices and struggle free service. Customers can book Pandit ji for pooja online. On completion of the service, the Customers may provide us with reviews and feedbacks for the Service Provider. ",style: GoogleFonts.aBeeZee(fontSize: 14,color:Colors.black54,letterSpacing: 1.5,wordSpacing: 2.0),textAlign: TextAlign.justify,),
                            SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: (){
                                      _launchInBrowser(_url);
                                    },
                                    child: Image.asset("assets/images/google-play-badge.png",height: height*0.1,))
                              ],
                            )
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:height*0.2),
                              child: Image.network("https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2F1626627424375%201.png?alt=media&token=8f672abb-9468-4fa6-8640-39633ea11f67",height: height*0.6,width: width*0.2,),
                            ),
                            SizedBox(width: 10,),
                            Padding(
                              padding: EdgeInsets.only(bottom:height*0.29),
                              child: Image.network("https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2F1626627304499%201.png?alt=media&token=c82ef1b8-5101-4323-b43f-6573d0d86214",height: height*0.8,width: width*0.2,),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              ResponsiveWidget.isSmallScreen(context)? SizedBox():NewBottomBar()

            ],
          ),
        )

    );
  }

}

class MobileLanding extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final LocationController locationController = Get.put(LocationController());
    const _url = 'https://play.google.com/store/apps/details?id=com.pujapurohit.android.infopujapurohit';
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
    locateMe()async{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      locationController.updateLat(position.latitude, position.longitude);
      // locationController.updateAddress(position.latitude.toString(),position.longitude.toString());
      Get.toNamed('/home');
    }
    return Scaffold(
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: height*0.65,
              width: width,
              color: Colors.white,
              child:  CarouselSlider(
                options: CarouselOptions(
                  height: height*0.65,

                  pauseAutoPlayInFiniteScroll: true,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items:[
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2Fscooter.png?alt=media&token=e98414f9-69d9-4b74-884b-8ac07e1dfaf4',
                    fit: BoxFit.contain,
                  ),
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2F1.png?alt=media&token=1715d0c9-1860-4ad4-8299-fa98cafb2153',
                    fit: BoxFit.contain,
                  ),
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/website%2F2.png?alt=media&token=c25b8347-780d-4d5f-95b9-0ff383a8ddf4',
                    fit: BoxFit.contain,
                  ),


                ],
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding:EdgeInsets.only(left:width*0.1,right: width*0.1,bottom: width*0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height:90,

                      pauseAutoPlayInFiniteScroll: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 3),
                    ),
                    items:[
                      SelectableText("Help us in reviving our culture",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black87),),
                      SelectableText("India's first intercity pandit booking platform",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black87),),
                      SelectableText("Easy online and cod payments available",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black87),),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Text2(data: "Continue your spritual journey", max: 12, clr: Colors.black54,),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      locateMe();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.orange,
                      child: Text4(data: "SETUP YOUR LOCATION", max: 12, min: 12,clr: Colors.white,weight: FontWeight.bold,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.to(PhoneLogin());
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'Have an account?',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 12),
                          children: <TextSpan>[
                            TextSpan(text: ' Login',
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 12),

                            )
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  MobileBottomBar()
                ],
              ),
            )
          ],
        ),
      )

      ,
    );
  }
}

class PhoneLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){Get.back();}, icon: Icon(CupertinoIcons.back))
            ],
          ),
          SizedBox(height: 5,),
          Container(
              height: height*0.8,
              child: Auth())
        ],
      ),
    );
  }

}
//var googlePlace = GooglePlace("AIzaSyCHlPJMsHXuk5Khs0FbOhGavgKy2BPV5m8", proxyUrl: 'cors-anywhere.herokuapp.com');