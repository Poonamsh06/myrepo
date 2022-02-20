import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/reviews.dart';
import '../new_pandit_home.dart';
import 'Controllers/service_top.dart';
import 'profile.dart';
import 'Widgets/image_view.dart';
import 'Widgets/responsive.dart';

class ServiceDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    double height= MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String panditid= Get.parameters['pid']!;
    String serviceid= Get.parameters['sid']!;
    var screenSize= MediaQuery.of(context).size;
    return Scaffold(
     appBar:PreferredSize(preferredSize: Size(screenSize.width,height*0.099,), 
      child: TopTabs()
      ),
      body: GetX<ServiceDetailController>(
        init: Get.put<ServiceDetailController>(ServiceDetailController(uid:panditid,sid:serviceid)),
        builder: (ServiceDetailController serviceDetailController){
          if(serviceDetailController.userModel.value.image == null){
            return Center(child: Loader(),);
          }
          var swastik = serviceDetailController.userModel.value.swastik;
          int? rates = serviceDetailController.userModel.value.raters;
          double? overallRate=swastik!/rates!;
          return Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                height:  ResponsiveWidget.isSmallScreen(context)? width<=380?height*0.38:height*0.3:height*0.35,
                 width: width,
                 color: Color(0xff181c2c),
                 //padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)?5:width*0.06,right: ResponsiveWidget.isSmallScreen(context)?5:30,top: height*0.02,bottom: 10),
                 padding: EdgeInsets.symmetric(horizontal: width*0.08),
                 margin: EdgeInsets.only(bottom: height*0.04),
                 child: Row(
                   children:[
                     Expanded(
                       flex: 1,
                       child: Obx((){
                         return Container(
                         margin:  ResponsiveWidget.isMediumScreen(context)? EdgeInsets.all(0.0):EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)?10:width*0.06,right:width*0.01),
                         height:ResponsiveWidget.isSmallScreen(context)?height*0.12:width==1024?height*0.2:height*0.25,
                         
                         width: width*0.1,
                         decoration: BoxDecoration(
                           color:Colors.white,
                           shape: ResponsiveWidget.isSmallScreen(context)?BoxShape.circle:BoxShape.rectangle,
                           image: DecorationImage(image: NetworkImage("${serviceDetailController.userModel.value.image}"),
                           fit: BoxFit.fill,
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
                          //var swastik =pandDetailController.userModel.value.swastik;
                          //var raters =  pandDetailController.userModel.value.raters;                           
                           return Column(
                             
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text1(data: "${serviceDetailController.userModel.value.service}", max: 18, min: 16,weight: FontWeight.bold,clr: Colors.white,),
                                SizedBox(height:5),
                                Text1(data: "by : ${Get.parameters['pandit']}", max: 11, min: 10,clr: Colors.white,),
                                SizedBox(height:5),
                                Text1(data: "Pujan Vidhi", max: 11, min: 10,clr: Colors.white,),
                                SizedBox(height:5),
                                Text1(data: "Samagri Detail", max: 11, min: 10,clr: Colors.white,),
                             SizedBox(height:20),
                             Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child:MiniBox(icon: true, FirstText: "${swastik<=0?0.0:overallRate!.toStringAsFixed(1)}", SecondText: "${serviceDetailController.userModel.value.raters} ratings",iconData: CupertinoIcons.star,)),
                          Expanded(
                              flex: 2,
                              child: MiniBox(icon: true, FirstText: "${serviceDetailController.userModel.value.time}", SecondText: "Duration",iconData: Icons.watch_later_outlined,)),
                          Expanded(
                              flex: 2,
                              child: MiniBox(icon: true, FirstText: "${serviceDetailController.userModel.value.subscriber}", SecondText: "Served",iconData: Icons.work,)),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Get.bottomSheet(
                                        Container(
                                            color: Colors.white,
                                            child: Reviews(pandit: false, uid: Get.parameters['pid']!, ServiceId: serviceDetailController.userModel.value.serviceId!,swastik: double.parse("${serviceDetailController.userModel.value.swastik}"),reviewers: serviceDetailController.userModel.value.reviewers,raters:serviceDetailController.userModel.value.raters,)
                                        ),
                                        enableDrag: false
                                    );
                                  },
                                  child: MiniBox(icon: true, SecondText: "Reviews", FirstText: "${serviceDetailController.userModel.value.reviewers}",iconData: Icons.reviews,))),


                        ],
                      ),
                                 SizedBox(height:15), 

                                 ResponsiveWidget.isSmallScreen(context)? SizedBox():SingleChildScrollView(child: details(serviceDetailController,context))
                     
                           ]
                         );
                         })
                       ) ),
                        SizedBox(width:width*0.05),
                   
                   ]
                 )
                 ),          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? 0:width*0.1),
                  child: Column(children: [
                     Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: ResponsiveWidget.isSmallScreen(context)?details(serviceDetailController,context) :SizedBox(),
                   )      ,                    
                     
                      
                      
                      SizedBox(height:15),
                      ResponsiveWidget.isSmallScreen(context)?learnWatch():SizedBox(),
                      
                      SizedBox(height: 10,),
                      ResponsiveWidget.isSmallScreen(context)?Reviews(pandit: false, uid: Get.parameters['pid']!, ServiceId: serviceDetailController.userModel.value.serviceId!,swastik: double.parse("${serviceDetailController.userModel.value.swastik}"),reviewers: serviceDetailController.userModel.value.reviewers,raters:serviceDetailController.userModel.value.raters,):SizedBox(),
                      ResponsiveWidget.isSmallScreen(context)?SizedBox():
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: learnWatch()),
                          Expanded(
                            flex: 1,
                            child: Reviews(pandit: false, uid: Get.parameters['pid']!, ServiceId: serviceDetailController.userModel.value.serviceId!,swastik: double.parse("${serviceDetailController.userModel.value.swastik}"),reviewers: serviceDetailController.userModel.value.reviewers,raters:serviceDetailController.userModel.value.raters,))
                        ],
                      ),
                  ],),
                ),
                    SizedBox(height: 100,)


                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: (){
                        String keyword=serviceDetailController.userModel.value.keyword.toString().substring(1);

                       if(authController.user==null){
                         Get.toNamed('/account');
                         Get.snackbar("Login", "Please Login to proceed booking",backgroundColor: Colors.white,padding: EdgeInsets.all(20),colorText: Colors.grey,duration:Duration(seconds: 3));

                       }
                       else{
                         FareBreakup farebreakup = Get.put(FareBreakup());
                         farebreakup.service(serviceDetailController.userModel.value.price,serviceDetailController.userModel.value.serviceId!,serviceDetailController.userModel.value.service!,serviceDetailController.userModel.value.image!,serviceDetailController.userModel.value.np!);
                         Get.toNamed("/address?keyword=$keyword");
                       }
                      },
                      child: Container(
                        
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text1(data: "Continue Booking", max: 14, min: 12,clr: Colors.white,weight: FontWeight.w600,),
                      ),
                    ),
                  )
              )
            ],
          );
        },
      ),
    );

    
  }

  Widget learnWatch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text1(data: "Note:\nWe are commited to provide transparency between our purohits and yajman.\nLearn how to book :- ", max: 12, min: 11,clr:Colors.grey,weight: FontWeight.w600,),
                        SizedBox(height: 10,),
                        Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:MiniBox(icon: true, FirstText: "Learn", SecondText: "Written Steps",iconData: CupertinoIcons.book,)),
                          Expanded(
                              flex: 1,
                            child: MiniBox(icon: true, FirstText: "Watch", SecondText: "Explained Video",iconData: Icons.tv,)),
                      ],
                    ),
                      ],
                    ),
    );
  }

  Widget details(ServiceDetailController serviceDetailController,BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  ResponsiveWidget.isSmallScreen(context)?  SizedBox():DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength: double.infinity,
                                    lineThickness: 1.0,
                                    dashLength: 2.0,
                                    dashColor: Colors.grey,
                                    dashRadius: 0.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  SizedBox(height: 10,),
                                  Text1(data: "Benefit ***Claimed by Purohit***", max: 12, min: 11,clr: Colors.grey,weight: FontWeight.bold,),
                                  SizedBox(height: 5,),
                                  Text1(data: "${serviceDetailController.userModel.value.benefit}", max: 12, min: 11,clr:Colors.grey),
                                  SizedBox(height: 10,),
                                  Text1(data: "Additional Detail", max: 12, min: 11,clr:Colors.grey,weight: FontWeight.bold,),
                                  SizedBox(height: 5,),
                                  Text1(data: "${serviceDetailController.userModel.value.detail}", max: 12, min: 11,clr:Colors.grey),
                                  SizedBox(height:15),
 
                                  ],                                  
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

}