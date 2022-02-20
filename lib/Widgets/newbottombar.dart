import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/serving_cities.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

class NewBottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height  = MediaQuery.of(context).size.height;
    double width  = MediaQuery.of(context).size.width;
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
    return    Container(
                    padding: EdgeInsets.only(left: width*0.1,right: width*0.1),
                    color: Color(0xfff8f8f8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.08,),
                        Row(
                          children: [
                            Text('Puja',style: GoogleFonts.aclonica(color: Colors.black54,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),),
                          SizedBox(width: 10,),
                      Text('Purohit',style: GoogleFonts.aclonica(color: Colors.black54,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),),
                          ],
                        ),
                        SizedBox(height: height*0.05,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1(data: "COMPANY", max: 24, min: 20,clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                SizedBox(height: 15,),
                                bottom_tabs("WHO WE ARE"),
                                SizedBox(height: 10,),
                                bottom_tabs("Blog"),
                                SizedBox(height: 10,),
                                bottom_tabs("Careers"),
                                SizedBox(height: 10,),
                                bottom_tabs("Report Fraud"),
                                SizedBox(height: 10,),
                                bottom_tabs("Contatct"),
                                SizedBox(height: 10,),
                                bottom_tabs("Investor Relations"),
                                SizedBox(height: 10,)
                              ],
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1(data: "FOR PARTNERS", max: 24, min: 20,clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                SizedBox(height: 15,),
                                bottom_tabs("Become Purohit"),
                                SizedBox(height: 10,),
                                bottom_tabs("Register Jagrata Band"),
                                SizedBox(height: 10,),
                                bottom_tabs("Temple Applications"),
                                SizedBox(height: 10,),
                                
                              ],
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1(data: "FOR YOU", max: 24, min: 20,clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                SizedBox(height: 15,),
                                bottom_tabs("Privacy"),
                                SizedBox(height: 10,),
                                bottom_tabs("Terms"),
                                SizedBox(height: 10,),
                                bottom_tabs("Security"),
                                SizedBox(height: 10,),
                                bottom_tabs("FAQ"),
                                SizedBox(height: 10,),
                                
                              ],
                            ),
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text2(data: "Social Links", max: 24, clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://twitter.com/infopujapurohit') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.twitter));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.facebook.com/infopujapurohit') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.facebook));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.instagram.com/infopujapurohit') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.instagram));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.linkedin.com/company/75550525') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.linkedin));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.youtube));
                                      }),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){
                                      _launchInBrowser(_url);
                                    },
                                    child: Image.asset("assets/images/google-play-badge.png",height: height*0.07,)),
                                  SizedBox(height: 10,),
                                  Text2(data: "© 2021 Puja Purohit", max: 24,clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                  
                              ],
                            ),

                          ],
                        ),
                        Divider(color: Colors.grey,thickness: 1.0,),
                        SizedBox(height: 20,),
                        Text1(data: "WE SERVE IN", max: 24, min: 20,clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              
                              child: SizedBox(
                                
                                child: GetX<CitiesController >(
                                init: Get.put<CitiesController>(CitiesController()),
                                builder: (CitiesController citiesController) {
                                  if (citiesController != null && citiesController.serviceTop != null) {
                                   int total_len = citiesController.serviceTop!.length;
                                    return GridView.builder(
                                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(  
                                          crossAxisCount: ResponsiveWidget.isMediumScreen(context)?3:4,
                                          crossAxisSpacing: ResponsiveWidget.isMediumScreen(context)?80:50,
                                         
                                          childAspectRatio: ResponsiveWidget.isMediumScreen(context)? 4:6,
                                      ),  
                                      physics: NeverScrollableScrollPhysics(),
                                      //scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: citiesController.serviceTop!.length,
                                      itemBuilder: (_,index){
                                        return serving_cities('${citiesController.serviceTop![index].name}', citiesController.serviceTop![index].lat!, citiesController.serviceTop![index].lng!);
                                      }, );
                                     
                                      
                                  } else {
                                    return Center(child: SizedBox(
                                        height: 50,width: 50,
                                        child: Loader()));
                                  }
                                                  },
                                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
    );
  }

  Widget bottom_tabs(String data) {
    return Link(uri: Uri.parse(""), builder: (_,link){
      return InkWell(
      onTap:link,
      hoverColor: Colors.transparent,
      child: HoverWidget(
        onHover: (event){},
        hoverChild:Text1(data: "$data", max: 24, min: 20,clr: Colors.black54,) ,
        child: Text1(data: "$data", max: 22, min: 18,clr: Colors.black54,)),
    );
    });
  }

  Widget serving_cities(String city,double lat, double lng){
    LocationController locationController = Get.put(LocationController());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Link(uri: Uri.parse('http://pujapurohit.in/#/location?district=$city'), builder: (_,link){
        return InkWell(
        onTap: link,
        child: HoverWidget(
          onHover: (event){},
          hoverChild:Text1(data: "$city", max: 24, min: 20,clr: Colors.black54,weight: FontWeight.w200,) ,
          child: Text1(data: "$city", max: 22, min: 18,clr: Colors.black54,weight: FontWeight.w200,)));
      })
    );
  }

}

class MobileBottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height  = MediaQuery.of(context).size.height;
    double width  = MediaQuery.of(context).size.width;
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
    return Column(
      children: [
         Text2(data: "Social Links", max: 14, clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://twitter.com/infopujapurohit') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.twitter));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.facebook.com/infopujapurohit') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.facebook));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.instagram.com/infopujapurohit') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.instagram));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.linkedin.com/company/75550525') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.linkedin));
                                      }),
                                       Link(
                                        target: LinkTarget.blank,
                                        uri:Uri.parse('https://www.youtube.com/channel/UCtCe77a3YY6NR3snGPvhlxg') , builder: (_,link){
                                        return InkWell(
                                          onTap: link,
                                          child: Icon(LineIcons.youtube));
                                      }),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){
                                      _launchInBrowser(_url);
                                    },
                                    child: Image.asset("assets/images/google-play-badge.png",height: height*0.07,)),
                                  SizedBox(height: 10,),
                                  Text2(data: "© 2021 Puja Purohit", max: 14,clr: Colors.black87,weight: FontWeight.bold,space: 2.0,),
                                  
      ],
    );
  }

}