import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/serving_cities.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';

import '../new_pandit_home.dart';
import 'Controllers/pandits_controller.dart';
import 'pandit_home.dart';
import 'Widgets/responsive.dart';
import 'package:hovering/hovering.dart';
class CustomCity extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
     final _key = GlobalKey<ScaffoldState>();
    String? district = Get.parameters['district'];
    return Scaffold(
      key: _key,
      body: GetX<CityController>(
        init: Get.put(CityController(district: district!)),
        builder: (CityController cityController){
          if(cityController.userModel.value.lat==null){
            return Center(child: SizedBox(height: 100,width: 100,child: Loader(),));
          }

          
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
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                           Expanded(
                             flex: 3,
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text2(data: "Experienced purohit in ${cityController.userModel.value.name}, ready to serve you", max: ResponsiveWidget.isMediumScreen(context)? 24:28,clr: Colors.white,weight: FontWeight.w600,),
                                  SizedBox(height: 20,),
                                  Text2(data: "About the cultural events in ${cityController.userModel.value.name}", max: 24,clr: Colors.white,weight: FontWeight.w600,),
                                  SizedBox(height: 20,),
                                  Text2(data: "${cityController.userModel.value.about_agra }", max: 16,clr: Colors.white,),
                               ],
                             ),
                           ),
                           Expanded(
                             flex: 2,
                             child: SizedBox())
                         ],)
                       ],
                     ),
            ),
            SizedBox(height: height*0.05,),
            Padding(
               padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)?5:width*0.06,right: ResponsiveWidget.isSmallScreen(context)?5:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 
                   Text2(data: "Where we find some popular puja", max: ResponsiveWidget.isMediumScreen(context)? 24:28,clr: Colors.black87,weight: FontWeight.w600,),
                   SizedBox(height: 20,),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,                            
                            itemCount: cityController.userModel.value.pujas!.length,
                            itemBuilder: (_,index){
                              return popular_puja("${cityController.userModel.value.pujas![index]['name']}","#satyanarayan");
                            }),
                         
                        ],
                      ),
                    ),
                   
                ],
              ),
              SizedBox(height: height*0.1,),
              Text2(data: "Purohit in and around ${cityController.userModel.value.name}", max: ResponsiveWidget.isMediumScreen(context)? 24:28,clr: Colors.black87,weight: FontWeight.w600,),
              SizedBox(height: height*0.05,),
              Padding(
                    padding:  EdgeInsets.only(bottom:40.0,left:10,right:10),
                    child: GetX<PanditController>(
                      init: Get.put<PanditController>(PanditController(lat:cityController.userModel.value.lat!,lng: cityController.userModel.value.lng!  )),
                      builder: (PanditController panditController) {
                        if (panditController != null && panditController.pandits != null) {
                          return ResponsiveWidget.isSmallScreen(context) ?ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: panditController.panditList.value!.length,
                              itemBuilder: (_, index) {
                                return PanditCard(bModal: panditController.pandits![index],lat:23.0225,lng: 72.5714);
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
                                    return PanditCard(bModal: panditController.pandits![index],lat:23.0225,lng: 72.5714);
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
                 ],
              ),
            ),
           ResponsiveWidget.isSmallScreen(context)? SizedBox():NewBottomBar()
          ],
        ),
      );
    
    
        }
      )
    );
  }

  Padding popular_puja(String puja,String keyword) {
    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        hoverColor: Colors.white,
                        onTap: (){
                            
                            //html.window.location.reload();
                        },
                        child: Text1(data: "$puja", max: 22, min: 18,clr: Colors.black54,)),
                    );
  }
}