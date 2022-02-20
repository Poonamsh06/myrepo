import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/youtube_player.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'package:url_launcher/link.dart';

class Live extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String LiveId = Get.parameters['liveId']!;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('PujaPurohitFiles/sliders/second').doc('$LiveId').snapshots(),      
        builder: (context, snapshot) {
          if(snapshot.data==null){
            return Loader();
          }
          return Stack(
            children: [
            
              Container(
                width:width,
                height:height ,
                child: Image.network('${snapshot.data!.get('bg')}',fit: BoxFit.fill,)),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Column(
                    children: [
                      Image.network('${snapshot.data!.get('image1')}'),
                      SizedBox(height:20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LineIcons.broadcastTower,color: Colors.white,size:ResponsiveWidget.isSmallScreen(context)? 16: 32,),
                            SizedBox(width:10),
                            AutoSizeText('Live will be brodcast at our social media handles website and app',style: GoogleFonts.kadwa(color: Colors.white,wordSpacing: 1.0,fontWeight: FontWeight.w100),minFontSize: ResponsiveWidget.isSmallScreen(context)? 12:24,maxFontSize: ResponsiveWidget.isSmallScreen(context)? 16:32,),
                          ],
                        ),
                      ),
                      SizedBox(height:10),
                     ResponsiveWidget.isSmallScreen(context)?Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text1(data: "Follow us :", max: 24, min: 20,clr: Colors.white,),
                            SizedBox(width:10),
                            socialButton(LineIcons.facebookF,'https://www.facebook.com/infopujapurohit/'),
                            SizedBox(width:10),
                           socialButton(LineIcons.instagram,'https://www.instagram.com/infopujapurohit/'),
                           SizedBox(width:10),
                           socialButton(LineIcons.linkedinIn,'https://in.linkedin.com/company/puja-purohit'),
                           SizedBox(width:10),
                           socialButton(LineIcons.twitter,'https://twitter.com/infopujapurohit'),
                            
                           
                          ],
                        ),
                      ):SizedBox(),
                      ResponsiveWidget.isSmallScreen(context)?SizedBox():SizedBox(height:10),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text1(data: "Subscribe us at Youtube :", max: 24, min: 20,clr: Colors.white,),
                            SizedBox(width:10),
                            socialButton(LineIcons.youtube,'https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg'),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.transparent,
                            width: width*0.7,
                                    height:ResponsiveWidget.isSmallScreen(context)?height*0.4:ResponsiveWidget.isMediumScreen(context)?height*0.6: height*0.65,
                            child: YoutubeAppDemo(id: 'OeUsyPUgftU',))
                        ],
                      ),
                      SizedBox(height:200)
                    ],
                  ),
                ),
              ),
                Align(
                alignment: Alignment.topRight,
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         ResponsiveWidget.isSmallScreen(context)? SizedBox(): Text1(data: "Follow us :", max: 24, min: 20,clr: Colors.white,),
                         ResponsiveWidget.isSmallScreen(context)? SizedBox(): SizedBox(width:10),
                         socialButton(LineIcons.youtube,'https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg'),
                         SizedBox(width:10),
                          socialButton(LineIcons.facebookF,'https://www.facebook.com/infopujapurohit/'),
                          SizedBox(width:10),
                         socialButton(LineIcons.instagram,'https://www.instagram.com/infopujapurohit/'),
                         SizedBox(width:10),
                         socialButton(LineIcons.linkedinIn,'https://in.linkedin.com/company/puja-purohit'),
                         SizedBox(width:10),
                         socialButton(LineIcons.twitter,'https://twitter.com/infopujapurohit'),
                          
                         
                        ],
                      ),
              ),
             ResponsiveWidget.isSmallScreen(context)? SizedBox(): Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         ResponsiveWidget.isSmallScreen(context)? SizedBox():Text1(data: "Subscribe us at Youtube :", max: 24, min: 20,clr: Colors.white,),
                          ResponsiveWidget.isSmallScreen(context)? SizedBox():SizedBox(width:10),
                          socialButton(LineIcons.youtube,'https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg'),
                        ],
                      ),
            ],
          );
        }
      )
    );
  }

  Link socialButton(IconData icn,String link) {
    return Link(
                     target: LinkTarget.blank,
                     uri: Uri.parse('$link'),
                     builder: (context, followlink) {
                       return IconButton(icon: Icon(icn,size: 24,color: Colors.white,),onPressed: followlink,);
                     }
                   );
  }

}