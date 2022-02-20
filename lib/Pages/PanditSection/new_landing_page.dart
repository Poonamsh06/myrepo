
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/colors/light_colors.dart';

import '../new_pandit_home.dart';
import 'account.dart';

class NewLandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    var screenSize= MediaQuery.of(context).size;
    final AuthController authController = Get.find();
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size(screenSize.width,height*0.099,),
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
                          onTap:(){Get.toNamed('/home');},
                          child: Image.asset('assets/images/logo.png',fit: BoxFit.fill,height: 60,width: 60,),
                        ),
                        SizedBox(width:10),
                          SizedBox(height: height*0.4,
                            child:InkWell(
                              onTap: (){
                                Get.to(Account());
                             //Get.toNamed('/account');
                             // Get.snackbar("Login", "Please login to avail location change feature",backgroundColor: Colors.white,padding: EdgeInsets.all(20),colorText: Colors.grey,duration:Duration(seconds: 3));
                                
                              },
                              child:  Container(
                                  width: width*0.4,
                                  child: Row(
                                  children: [
                                //  ResponsiveWidget.isSmallScreen(context)?Expanded(child: Text1(max: 9, data: "${locationController.location.value.address}", min: 8, clr: Colors.black54,)):Text1(max: 9, data: "${locationController.location.value.address}", min: 8, clr: Colors.black54,),                                  
                                  //SizedBox(width:5),
                                    Text1(max: 12, data: "India", min: 11,weight:FontWeight.bold,clr:Colors.black),
                                    SizedBox(width:5),
                                    Icon(Icons.home,color:LightColors.kDarkYellow,size:12)
                                  ],
                              ),
                           )
                            )
                          ),
                          SizedBox(width:10),                
                      ],
                    ),
                   ResponsiveWidget.isSmallScreen(context)? Row(children: [
                     SizedBox(width: 20,),
                     Icon(LineIcons.search,size: 18,color: Colors.black54,),
                     SizedBox(width: 20,),
                     IconButton(icon: Icon(LineIcons.user,color: Colors.black54,size: 18,),onPressed: (){
                     //  Get.toNamed('/account');
                     Get.to(Account());
                     },),
                     
                   ],):Row(
                      children: [
                        SizedBox(width: 20,),
                        ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.search, max: 12, data: 'Search', min: 8,color: Colors.black54,weight: FontWeight.bold,),
                        SizedBox(width: 20,),
                        InkWell(
                          onTap: (){
                          // Get.toNamed('/account');
                          Get.to(Account());

                          },
                          child: ModifiedTextIcon(iconColor: Colors.black54,icondata: LineIcons.user, max: 12, data: 'Sign In', min: 8,color: Colors.black54,weight: FontWeight.bold),
                        ),
                        
                        SizedBox(width: 20,),
                        InkWell(
                          onTap: (){
                                            if (Get.isDarkMode)
                    Get.changeThemeMode(ThemeMode.light);
                  else
                    Get.changeThemeMode(ThemeMode.dark);
                          },
                          child: ModifiedTextIcon(iconColor: Colors.black54,icondata: Get.isDarkMode?Icons.light_mode:Icons.dark_mode, max: 12, data: 'Theme', min: 8,color: Colors.black54,weight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
      ),
     
     
      backgroundColor: context.theme.backgroundColor,
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Jumbotron(),
              //SizedBox(height:ResponsiveWidget.isMediumScreen(context)?0.0:height*0.05),
              
              Jumbotron2(),
              SizedBox(height:ResponsiveWidget.isSmallScreen(context)?10:height*0.1),
              ResponsiveWidget.isSmallScreen(context)?
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [                                    
                    shadowContainer('700+','Active Pandits',context),
                     SizedBox(height:20),
                    shadowContainer('200+','Vendors',context),
                     SizedBox(height:20),
                     shadowContainer('100+','Puja Variety',context),
                      SizedBox(height:20),
                    shadowContainer('1 k+','Served',context),
                ],
              ):
              
              Padding(
                padding: EdgeInsets.only(left: width*0.2,right: width*0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shadowContainer('700+','Active Pandits',context),
                    shadowContainer('200+','Vendors',context),
                     shadowContainer('100+','Puja Variety',context),
                    shadowContainer('1 k+','Served',context),
                   
                  
                  ],
                ),
              ),                         
              SizedBox(height: height*0.1),
            ],
          ),
        ),
      ),
    );
  }

  Container shadowContainer(String txt1, String txt2,BuildContext context) {
    return Container(
      alignment: Alignment.center,
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius:ResponsiveWidget.isSmallScreen(context)? 10:20,
                          color: LightColors.KDarkYellow2
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text("$txt1",style: TextStyle(color:LightColors.KDarkYellow2,fontWeight: FontWeight.w800,fontSize: 28)),
                        SizedBox(height: 5,),
                        Text("$txt2",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 15)),
                        
                      ],
                    ),
                  );
                  
  }
  

}

class Jumbotron extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
     bool isTab(BuildContext context) => MediaQuery.of(context).size.width < 1300 && MediaQuery.of(context).size.width >= 650;
     bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1300;
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: <Widget>[
          Expanded(
          
            child: Padding(
              padding: EdgeInsets.only(right: !isMobile(context) ? 40:0),
              child: Column(
                mainAxisAlignment: !isMobile(context) ? MainAxisAlignment.start:MainAxisAlignment.center,
                crossAxisAlignment: !isMobile(context) ? CrossAxisAlignment.start:CrossAxisAlignment.center,
                children: <Widget>[
                  if (isMobile(context))
                   Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/Landing%20Page%2F1.png?alt=media&token=5c564a9e-21ea-4b99-8dee-c1c4d1d5c6f6',height: size.height * 0.3,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Discover the\n',
                          style: TextStyle(
                            fontSize: isDesktop(context) ? 60 : 32,
                            fontWeight: FontWeight.w800,
                            color: Color(0XFF282828)
                          )
                        ),
                        TextSpan(
                          text: "Best Purohits",
                          style: TextStyle(
                            fontSize: isDesktop(context) ? 60 : 32,
                            fontWeight: FontWeight.w800,
                            color: LightColors.KDarkYellow2
                          )
                        ),
                      ]
                    )
                  ),

                  SelectableText(
                    'Around You',
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 60 : 32,
                      fontWeight: FontWeight.w800
                    ),
                    
                  ),

                  // SelectableText(
                  //   'Online Today!',
                  //   style: TextStyle(
                  //     fontSize: isDesktop(context) ? 60 : 32,
                  //     fontWeight: FontWeight.w800
                  //   ),
                  // ),

                  SizedBox(height: 10),

                  SelectableText(
                    'Help us in reviving the Sanatan Culture in every heart.',
                    textAlign: isMobile(context) ? TextAlign.center:TextAlign.start,
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 32 : 18,
                      fontWeight: FontWeight.w300
                    ),
                  ),

                  SizedBox(height: 10),

                  Wrap(
                    runSpacing: 10,
                    children: <Widget>[
                      MainButton(
                        title: 'GET STARTED',
                        clr: LightColors.KDarkYellow2,
                        tapEvent: () {},
                      ),

                      SizedBox(width: 10),

                      MainButton(
                        title: 'WATCH VIDEO',
                        clr: Color(0xFF2b478b),
                        tapEvent: () {},
                      )
                    ],
                  )
                ],
              ),
            )
          ),

          if (isDesktop(context) || isTab(context))
            Expanded(
            
              child: Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/Landing%20Page%2F1.png?alt=media&token=5c564a9e-21ea-4b99-8dee-c1c4d1d5c6f6',height: size.height * 0.7,),
            )
        ],
      )
    );
  }
}

class MainButton extends StatelessWidget{
  final String? title;
  final VoidCallback? tapEvent;
  final Color? clr;
  MainButton({
    this.title,this.tapEvent,this.clr
  });
  @override
  Widget build(BuildContext context) {
   return ElevatedButton(onPressed: tapEvent, child: Text1(data: "$title", max: 12, min: 11,clr: Colors.white,
   ),
   style: ElevatedButton.styleFrom(primary: clr,shape: StadiumBorder())
   );
  }

}

class Jumbotron2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
     bool isTab(BuildContext context) => MediaQuery.of(context).size.width < 1300 && MediaQuery.of(context).size.width >= 650;
     bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1300;
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 10,left: 20),
      child: Row(
        children: <Widget>[
           if (isDesktop(context) || isTab(context))
            Expanded(
              child: Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/Landing%20Page%2F2.1.png?alt=media&token=7bb99dd6-b8ac-4bbf-995a-e2cfc352b7d1',height: size.height * 0.7,),
            ),
            SizedBox(width: 20,),
           
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: !isMobile(context) ? 40:0),
              child: Column(
               mainAxisAlignment: !isMobile(context) ? MainAxisAlignment.start:MainAxisAlignment.center,
                crossAxisAlignment: !isMobile(context) ? CrossAxisAlignment.end:CrossAxisAlignment.center,
                children: <Widget>[
                  if (isMobile(context))
                   Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/Landing%20Page%2F2.1.png?alt=media&token=7bb99dd6-b8ac-4bbf-995a-e2cfc352b7d1',height: size.height * 0.3,),
                 
                   SelectableText(
                     'Save Your Time',
                    
                     style: TextStyle(
                       fontSize: isDesktop(context) ? 60 : 32,
                       fontWeight: FontWeight.w800
                     ),
                     
                   ),
                  //SizedBox(height: 10),
                   SelectableText(
                     'Get Puja Samagri',
                    
                     style: TextStyle(
                       color: LightColors.KDarkYellow2,
                       fontSize: isDesktop(context) ? 60 : 32,
                       fontWeight: FontWeight.w800
                     ),
                     
                   ),

                    SizedBox(height: 10),
                  SelectableText(
                    'At Your Doorstep',
                   
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 60 : 32,
                      fontWeight: FontWeight.w800
                    ),
                    
                  ),

                  SizedBox(height: 10),
                  SelectableText(
                    'Free shipment for all your essential puja items.',
                    //textAlign: isMobile(context)?TextAlign.center:TextAlign.end,
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 36 : 18,
                      fontWeight: FontWeight.w300
                    ),
                    
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ),

         
        ],
      )
    );
  }
}

