import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer>loadData() async{
    return Timer(Duration(seconds: 5), onDoneLoading);}
      onDoneLoading() async {
    Get.offAndToNamed('/home');
  }
  @override
  void initState() {
   loadData();
    super.initState();
  }
  @override
 Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =  MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:Colors.white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      height: 100,width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png')
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    SelectableText('Puja Purohit',style: GoogleFonts.aBeeZee(fontSize: ResponsiveWidget.isSmallScreen(context)?16:20,fontWeight: FontWeight.w600,)),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      height: 2,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SelectableText("India's first intercity online pandit booking platform",style: GoogleFonts.aBeeZee(fontSize:ResponsiveWidget.isSmallScreen(context)?12:16),),
                    SizedBox(height: 20,),
                    SizedBox(
                      height:50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ResponsiveWidget.isSmallScreen(context)?20:30,
                            child: Image.asset('icons/flags/png/in.png', package: 'country_icons')),
                          SizedBox(width: 10,),
                          SelectableText("Made in India",style: GoogleFonts.aBeeZee(fontSize: 16),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}