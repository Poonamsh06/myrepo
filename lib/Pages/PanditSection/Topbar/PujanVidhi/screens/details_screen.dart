import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/pandits_controller.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/pujan_vidhi_controller.dart';
import 'package:pujapurohit/Pages/PanditSection/detail.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/PujanVidhi/constants.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'package:get/get.dart';
class PujanDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final PujanVidhiController pujanVidhiController = Get.put(PujanVidhiController());
    final VidhiController vidhiController = Get.put(VidhiController());
    final AuthController authController = Get.put(AuthController());
    final LocationController locationController = Get.put(LocationController());

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Obx((){
            return Container(
                alignment: Alignment.centerRight,
                height: size.height * .4,
                decoration: BoxDecoration(
                  color: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),
                ),
                child:Obx((){
                  return  Container(
                    width: size.width*0.4,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${pujanVidhiController.pujanModal.value.image}'),

                        )
                    ),
                  );
                })
            );
          }),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Obx((){
                      return Text1(
                        data: '${pujanVidhiController.pujanModal.value.name}',
                        max: 30,min: 28,clr: Colors.black54,weight: FontWeight.bold,
                      );
                    }),
                    SizedBox(height: 10),
                    Obx((){
                      return Text1(
                        data: '${pujanVidhiController.pujanModal.value.avgDuration}',
                        max: 12,min: 11,clr: Colors.black54,weight: FontWeight.bold,
                      );
                    }),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .45,
                        height: size.height*0.22,// it just take 60% of total width
                      child: Obx((){
                        return SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text1(
                              data: '${pujanVidhiController.pujanModal.value.description}',
                              max: ResponsiveWidget.isSmallScreen(context)? 12:16,min: 11,clr: Colors.black54,
                            ),
                          ),
                        );
                      })
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                     height: size.height*0.08,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SessionCard(
                          pagenum: 0,
                          clr: '${pujanVidhiController.pujanModal.value.bg}',
                          seassionNum: 1,
                          isDone: true,
                          press: () {

                          },
                        ),
                        SessionCard(
                          pagenum: 1,
                          clr: '${pujanVidhiController.pujanModal.value.bg}',
                          seassionNum: 2,
                          press: () {
                            Get.toNamed('/steps');
                          },
                        ),
                        SessionCard(
                          pagenum: 2,
                          clr: '${pujanVidhiController.pujanModal.value.bg}',
                          seassionNum: 3,
                          press: () {
                            Get.toNamed('/steps');
                          },
                        ),
                        SessionCard(
                          pagenum: 3,
                          clr: '${pujanVidhiController.pujanModal.value.bg}',
                          seassionNum: 4,
                          press: () {
                            Get.toNamed('/steps');
                          },
                        ),
                        // SeassionCard(
                        //   clr: '${pujanVidhiController.pujanModal.value.bg}',
                        //   seassionNum: 5,
                        //   press: () {
                        //     Get.to(Steps());
                        //   },
                        // ),
                        // SeassionCard(
                        //   clr: '${pujanVidhiController.pujanModal.value.bg}',
                        //   seassionNum: 6,
                        //   press: () {
                        //     Get.to(Steps());
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text5(
                      data1: "Suggested purohit for you",
                      data2: 'आपके लिए सुझाए गए पुरोहित',
                      data3: 'আপনার জন্য প্রস্তাবিত পুওরোহিত',
                      data4: 'உங்களுக்காக பரிந்துரைக்கப்படும் புரோஹித்',
                      data5: 'మీ కోసం సూచించిన పురోహిత్',
                      data6: 'तुमच्यासाठी सुचवलेले पुरोहित',
                      data7: 'તમારા માટે સૂચિત પુરોહિત',
                      data8: 'ଆପଣଙ୍କ ପାଇଁ ପ୍ରସ୍ତାବିତ ପୁରୋହିତ |',
                      data9: 'ਤੁਹਾਡੇ ਲਈ ਸੁਝਾਏ ਗਏ ਪੁਰੋਹਿਤ',
                      data10: 'ನಿಮಗಾಗಿ ಸೂಚಿಸಿದ ಪುರೋಹಿತ್',

                      max: 12, min: 11,clr: Colors.black87,),
                    SizedBox(height: 10,),
                    // GetX<PanditKeywordController>(
                    //     init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'${pujanVidhiController.pujanModal.value.keyword}',lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'))),
                    //     builder: (PanditKeywordController panditController){
                    //       if(panditController.panditList.value!=null && panditController.pandits!=null ){
                            
                    //         if(panditController.pandits!.isEmpty == true){
                    //           return Padding(
                    //             padding: const EdgeInsets.only(top:30.0),
                    //             child: Text5(data1: "No pandit in your area doing ${pujanVidhiController.pujanModal.value.name}",
                    //                 data2: 'आपके क्षेत्र में कोई पंडित नहीं कर रहा ${pujanVidhiController.pujanModal.value.name}',
                    //                 data3: 'আপনার এলাকায় কোন পণ্ডিত করছেন না ${pujanVidhiController.pujanModal.value.name}',
                    //                 data4: 'உங்கள் பகுதியில் பண்டிதர் இல்லை ${pujanVidhiController.pujanModal.value.name}',
                    //                 data5: 'మీ ప్రాంతంలో పండిట్ లేదు ${pujanVidhiController.pujanModal.value.name}',
                    //                 data6: 'तुमच्या क्षेत्रात एकही पंडित करत नाही ${pujanVidhiController.pujanModal.value.name}',
                    //                 data7: 'તમારા વિસ્તારમાં કોઈ પંડિત નથી ${pujanVidhiController.pujanModal.value.name}',
                    //                 data8: 'ଆପଣଙ୍କ ଅଞ୍ଚଳରେ କ pand ଣସି ପଣ୍ଡିତ କରୁନାହାଁନ୍ତି | ${pujanVidhiController.pujanModal.value.name}',
                    //                 data9: 'ਤੁਹਾਡੇ ਖੇਤਰ ਵਿੱਚ ਕੋਈ ਪੰਡਤ ਨਹੀਂ ਕਰ ਰਿਹਾ ${pujanVidhiController.pujanModal.value.name}',
                    //                 data10: 'ನಿಮ್ಮ ಪ್ರದೇಶದಲ್ಲಿ ಯಾವುದೇ ಪಂಡಿತ ಮಾಡುತ್ತಿಲ್ಲ ${pujanVidhiController.pujanModal.value.name}',
                    //                 max: 18, min: 12,clr:Colors.redAccent),
                    //           );
                    //         }
                    //         if(panditController.pandits == null){
                    //           return SizedBox(
                    //             height: 200,
                    //             child: Loader(),
                    //           );
                    //         }
                    //         return SizedBox(
                    //           height: 220.0,
                    //           child: ListView.builder(
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount:panditController.panditList.value!.length,
                    //             itemBuilder: (BuildContext ctxt, int index) {
                    //               if(authController.user!=null ){
                    //                 final UserController  userController = Get.put(UserController());
                    //                 return PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'));
                    //               }
                    //               return PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'));
                                  
                                 
                    //             },
                    //           ),
                    //         );
                    //       }
                    //       else{
                    //         return SizedBox(
                    //           height: 200,
                    //           child: Loader(),
                    //         );
                    //       }
                    //     })
                  
                  
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  GetX<UserController> loggedSuggestions(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
    return GetX<UserController>(
                      init: Get.put<UserController>(UserController()),
                      builder: (UserController userController){
                        if(userController.userModel.value.lat == null){
                          return Center(child:SizedBox(height:50,child: Loader(),));
                        }
                        return   GetX<PanditKeywordController>(
                          init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'${snapshot.data!.get('pujakeyword')}',lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'))),
                          builder: (PanditKeywordController panditController) {
                            if (panditController != null && panditController.pandits != null) {
                              if(panditController.panditList.value!.isEmpty){
                                return Padding(
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: Text1(data: "No pandit in your area performing ${snapshot.data!.get('pujaname')}", max: 18, min: 12,clr:Colors.redAccent),
                                );
                              }
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      height: 220.0,
                                      child: new ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:panditController.panditList.value!.length,
                                        itemBuilder: (BuildContext ctxt, int index) {
                                          return new PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.userModel.value.lat}'),lng: double.parse('${userController.userModel.value.lng}'));
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              );

                            } else {
                              return Center(child: SizedBox(
                                  height: 50,width: 50,
                                  child: Loader()));
                            }
                          },
                        );
                      },
                    );
  }

  Widget unLoggedSuggestions(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
    return GetX<LocationController>(
      init: Get.put<LocationController>(LocationController()),
      builder: (LocationController userController){
        if(userController.location.value.lat == null){
          return Center(child:SizedBox(height:50,child: Loader(),));
        }
        return   GetX<PanditKeywordController>(
          init:  Get.put<PanditKeywordController>(PanditKeywordController(what:'${snapshot.data!.get('pujakeyword')}',lat: double.parse('${userController.location.value.lat}'),lng: double.parse('${userController.location.value.lng}'))),
          builder: (PanditKeywordController panditController) {
            if (panditController != null && panditController.pandits != null) {
              if(panditController.panditList.value!.isEmpty){
                return Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Text1(data: "No pandit in your area performing ${snapshot.data!.get('pujaname')}", max: 18, min: 12,clr:Colors.redAccent),
                );
              }
              return Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 220.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:panditController.panditList.value!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new PanditNewCard(bmModal: panditController.pandits![index],lat: double.parse('${userController.location.value.lat}'),lng: double.parse('${userController.location.value.lng}'));
                        },
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              );

            } else {
              return Center(child: SizedBox(
                  height: 50,width: 50,
                  child: Loader()));
            }
          },
        );
      },
    );
  }
}

class SessionCard extends StatelessWidget {
  final int? pagenum;
  final int? seassionNum;
  final bool? isDone;
  final VoidCallback? press;
  final String? clr;
  const SessionCard({
    this.pagenum,
    this.clr,
    this.seassionNum,
    this.isDone = false,
    this.press,
  }) ;

  @override
  Widget build(BuildContext context) {
  final VidhiController vidhiController = Get.put(VidhiController());
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                
                blurRadius: 30,
                
                color: LightColors.shadowColor ,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                vidhiController.updateInitialPage(pagenum!);
               Get.toNamed('/steps');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone! ? Color(int.parse('$clr')):Colors.white ,
                        shape: BoxShape.circle,
                        border: Border.all(color:Color(int.parse('$clr'))),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone! ? Colors.white:Color(int.parse('$clr'))
                      ,
                    ),),
                    SizedBox(width: 10),
                    Text5(
                     data1: "Step $seassionNum",
                      data2: 'चरण $seassionNum',
                      data3: 'ধাপ $seassionNum',
                      data4: 'படி $seassionNum',
                      data5: 'దశ $seassionNum',
                      data6: 'Step $seassionNum',
                      data7: 'પગલું $seassionNum',
                      data8: 'ପଦାଙ୍କ $seassionNum',
                      data9: 'ਕਦਮ $seassionNum',
                      data10: 'ಹಂತ $seassionNum',
                      max: 16,min: 14,
                      //clr: Colors.white,
                      weight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
class VidhiData {
  var initial;
  double? curentPage =0.0;
  VidhiData({required this.initial,this.curentPage});
}

class VidhiController extends GetxController{
  var vidhiData = VidhiData(initial: 0);

  updateInitialPage(int page){
    vidhiData.initial= page;
  }
  updateCurrent(double current){
    vidhiData.curentPage =current;
  }
}
class Steps extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final VidhiController vidhiController = Get.put(VidhiController());
    final PujanVidhiController pujanVidhiController = Get.put(PujanVidhiController());
  final  PageController controller = PageController(
      initialPage: vidhiController.vidhiData.initial
    );
  var currentPageValue = 0.0;
  var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value){
              controller.addListener(() {
                vidhiController.updateCurrent(currentPageValue);
                currentPageValue = controller.page!;
                print(currentPageValue);
              });
            },
            children: [
              SamagiriPage(),
              AartPage(),
              AartiPage(),
              Completion()
            ],
          ),
            // Obx((){
            //   return Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         CircleAvatar(
            //           radius:16,
            //           backgroundColor: vidhiController.vidhiData.curentPage==0.0?Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')):Colors.white,
            //           child: vidhiController.vidhiData.curentPage==0.0?Text1(data: '1', max: 12, min: 11,clr: Colors.white,):Text1(data: '1', max: 12, min: 11,clr: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),),
            //         ),
            //         DottedLine(
            //           direction: Axis.horizontal,
            //           lineLength: 30,
            //           lineThickness: 1.0,
            //           dashLength: 2.0,
            //           dashColor: Colors.grey,
            //           dashRadius: 0.0,
            //           dashGapLength: 4.0,
            //           dashGapColor: Colors.transparent,
            //           dashGapRadius: 0.0,
            //         ),
            //         Obx((){
            //           return CircleAvatar(
            //             radius:16,
            //             backgroundColor: vidhiController.vidhiData.curentPage==1.0?Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')):Colors.white,
            //             child: vidhiController.vidhiData.curentPage==1.0?Text1(data: '2', max: 12, min: 11,clr: Colors.white,):Text1(data: '2', max: 12, min: 11,clr: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),),
            //           );
            //         })
            //       ],
            //     ),
            //   );
            // }),
          Obx((){
            return Align(

              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right:15.0,bottom: 10),
                child: InkWell(
                  onTap: (){
                    controller.nextPage(duration: 300.milliseconds, curve: Curves.ease);
                  },
                  child: CircleAvatar(
                      radius: ResponsiveWidget.isSmallScreen(context)?24:30,
                      backgroundColor: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),
                      child: Icon(Icons.arrow_forward_ios_sharp,size: ResponsiveWidget.isSmallScreen(context)?12:16,color: Colors.white,)),
                ),
              ),
            );
          }),

        ],
      )
    );
  }

}

class SamagiriPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final PujanVidhiController pujanVidhiController = Get.put(PujanVidhiController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [

          Obx((){
            return Container(

                alignment: Alignment.centerRight,
                height: size.height * .3,
                decoration: BoxDecoration(
                    borderRadius:  BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                  color: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),
                ),
                child:Obx((){
                  return  Container(
                    padding: EdgeInsets.only(top:20,right: 30),
                    width: size.width*0.4,
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${pujanVidhiController.pujanModal.value.image}'),

                        )
                    ),
                  );
                })
            );
          }),
          Padding(
           padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1,right: ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1,top: size.height*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Obx((){
                  return Text1(
                    data: '${pujanVidhiController.pujanModal.value.name}',
                    max: 24,min: 20,clr: Colors.black54,weight: FontWeight.bold,
                  );
                }),
                SizedBox(height: 10),
                Text5(
                  data1: 'Samagri List',
                  data2: 'समग्री सूची',
                  data3: 'সামগ্রী তালিকা',
                  data4: 'சமகிரி பட்டியல்',
                  data5: 'సామగ్రి జాబితా',
                  data6: 'समगरी यादी',
                  data7: 'સામગ્રી યાદી',
                  data8: 'ସମାଗ୍ରି ତାଲିକା |',
                  data9: 'ਸਮਗਰੀ ਸੂਚੀ',
                  data10: 'ಸಾಮಗ್ರಿ ಪಟ್ಟಿ',
                  max: 12,min: 11,clr: Colors.black54,weight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: size.height*0.1,
                    width: size.width * .56, // it just take 60% of total width
                    child:SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text5(
                        data1: 'All samagri are customized according tour state localization.Please assemble all samgri from your end or use our samagri service to get free delivery',
                        data2: 'सभी समग्री को टूर स्टेट लोकलाइजेशन के अनुसार अनुकूलित किया गया है। कृपया अपने अंत से सभी सामगरी को इकट्ठा करें या मुफ्त डिलीवरी प्राप्त करने के लिए हमारी समग्री सेवा का उपयोग करें।',
                        data3: 'সমস্ত সামগ্রী ট্যুর স্টেট লোকালাইজেশন অনুসারে কাস্টমাইজ করা হয়েছে।',
                        data4: 'அனைத்து சமாக்ரியும் சுற்றுப்பயண மாநில உள்ளூர்மயமாக்கலின் படி தனிப்பயனாக்கப்பட்டுள்ளது. தயவுசெய்து உங்கள் முடிவில் இருந்து அனைத்து சம்கிரிகளையும் ஒன்றிணைக்கவும் அல்லது இலவச விநியோகத்தைப் பெற எங்கள் சமாக்ரி சேவையைப் பயன்படுத்தவும்',
                        data5: 'టూర్ స్టేట్ లోకలైజేషన్ ప్రకారం అన్ని సమగ్రీ అనుకూలీకరించబడ్డాయి. దయచేసి మీ ముగింపు నుండి అన్ని సమగ్రిని సమీకరించండి లేదా ఉచిత డెలివరీని పొందడానికి మా సమగ్ర సేవను ఉపయోగించండి',
                        data6: 'सर्व समगरी टूर स्टेट लोकॅलायझेशननुसार सानुकूलित केल्या आहेत. कृपया तुमच्या शेवटापासून सर्व समगरी एकत्र करा किंवा मोफत डिलिव्हरी मिळवण्यासाठी आमच्या समगरी सेवेचा वापर करा',
                        data7: 'તમામ સમાગરી પ્રવાસ રાજ્ય સ્થાનિકીકરણ અનુસાર કસ્ટમાઇઝ કરવામાં આવે છે. કૃપા કરીને તમારા અંતથી તમામ સમગ્રીને ભેગા કરો અથવા મફત ડિલિવરી મેળવવા માટે અમારી સમાગ્રી સેવાનો ઉપયોગ કરો.',
                        data8: 'ସମସ୍ତ ସମାଗ୍ରି ଟୁର୍ ଷ୍ଟେଟ୍ ଲୋକାଲାଇଜେସନ୍ ଅନୁଯାୟୀ କଷ୍ଟୋମାଇଜ୍ ହୋଇଛି | ଦୟାକରି ସମସ୍ତ ସମ୍ରିକୁ ଆପଣଙ୍କ ଶେଷରୁ ଏକତ୍ର କରନ୍ତୁ କିମ୍ବା ମାଗଣା ବିତରଣ ପାଇବାକୁ ଆମର ସମାଗ୍ରି ସେବା ବ୍ୟବହାର କରନ୍ତୁ |',
                        data9: 'ਸਾਰੇ ਸਮਗਰੀ ਟੂਰ ਸਟੇਟ ਲੋਕਲਾਈਜੇਸ਼ਨ ਦੇ ਅਨੁਸਾਰ ਅਨੁਕੂਲਿਤ ਕੀਤੇ ਗਏ ਹਨ ਕਿਰਪਾ ਕਰਕੇ ਸਾਰੇ ਸਮਗਰੀ ਨੂੰ ਆਪਣੇ ਅੰਤ ਤੋਂ ਇਕੱਠੇ ਕਰੋ ਜਾਂ ਮੁਫਤ ਡਿਲਿਵਰੀ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ ਸਾਡੀ ਸਮਗਰੀ ਸੇਵਾ ਦੀ ਵਰਤੋਂ ਕਰੋ.',
                        data10: 'ಎಲ್ಲಾ ಸಾಮಗ್ರಿಗಳನ್ನು ಪ್ರವಾಸ ರಾಜ್ಯ ಸ್ಥಳೀಕರಣದ ಪ್ರಕಾರ ಕಸ್ಟಮೈಸ್ ಮಾಡಲಾಗಿದೆ. ದಯವಿಟ್ಟು ನಿಮ್ಮ ಅಂತ್ಯದಿಂದ ಎಲ್ಲಾ ಸಮಾಗ್ರಿಯನ್ನು ಜೋಡಿಸಿ ಅಥವಾ ಉಚಿತ ವಿತರಣೆಯನ್ನು ಪಡೆಯಲು ನಮ್ಮ ಸಾಮಗ್ರಿ ಸೇವೆಯನ್ನು ಬಳಸಿ',
                        max: 12,min: 11,clr: Colors.black54,
                      ),
                    )
                ),
                SizedBox(
                  width: size.width * .5, // it just take the 50% width
                  height: size.height*0.04,
                ),
                Padding(
                  padding:EdgeInsets.only(left:size.width*0.02,right: size.width*0.02),
                  child: SizedBox(
                    height: size.height*0.68,
                    child: Obx((){
                      return pujanVidhiController.pujanModal.value.samagris!.length==0?Padding(
                        padding: const EdgeInsets.only(top:50.0),
                        child: Text1(data: "List missing,waiting for Update..", max: 14, min: 11,clr: Colors.redAccent,weight: FontWeight.bold,),
                      ):ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                          itemCount: pujanVidhiController.pujanModal.value.samagris!.length,
                          itemBuilder: (_,index){

                            return ListTile(
                              leading: InkWell(
                                onTap: (){
                                  Get.defaultDialog(
                                      title: '${pujanVidhiController.pujanModal.value.samagris![index].name}',
                                      titleStyle: GoogleFonts.aBeeZee(fontSize: 12,color: Colors.black54),
                                      content: Image.network('${pujanVidhiController.pujanModal.value.samagris![index].img}')
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),
                                  backgroundImage: NetworkImage('${pujanVidhiController.pujanModal.value.samagris![index].img}'),
                                ),
                              ),
                              title: Text1(data: '${pujanVidhiController.pujanModal.value.samagris![index].name}', max:ResponsiveWidget.isSmallScreen(context)? 14:18, min: 11,clr: Colors.black87,),
                              subtitle: Text1(data: '${pujanVidhiController.pujanModal.value.samagris![index].description}', max:ResponsiveWidget.isSmallScreen(context)? 10:12, min: 8),
                              trailing: Text1(data: '${pujanVidhiController.pujanModal.value.samagris![index].quantity}', max: ResponsiveWidget.isSmallScreen(context)?12:14, min: 11,),
                            );
                          });
                    }),
                  ),
                )
                
              ],
            ),
          ),
        ],
      )
    );
  }

}
class AartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final PujanVidhiController pujanVidhiController = Get.put(PujanVidhiController());
    final TextLanguageController textLanguageController = Get.put(TextLanguageController());
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body:Stack(
        children: [
          Obx((){
            return Container(

                alignment: Alignment.centerRight,
                height: size.height * .3,
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                  color: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),
                ),
                child:Obx((){
                  return  Container(
                    padding: EdgeInsets.only(top:20,right: 30),
                    width: size.width*0.4,
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${pujanVidhiController.pujanModal.value.image}'),

                        )
                    ),
                  );
                })
            );
          }),
          Padding(
            padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1,right: ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1,top: size.height*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Obx((){
                  return Text1(
                    data: '${pujanVidhiController.pujanModal.value.name}',
                    max: 24,min: 20,clr: Colors.black54,weight: FontWeight.bold,
                  );
                }),
                SizedBox(height: 10),
                Text1(
                  data: '${pujanVidhiController.pujanModal.value.avgDuration}',
                  max: 12,min: 11,clr: Colors.black54,weight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                SizedBox(
                    width: size.width * .56, // it just take 60% of total width
                    child:Text5(
                      data1: 'Complete below process and tap on next icon',
                      data2: 'नीचे दी गई प्रक्रिया को पूरा करें और अगले आइकन पर टैप करें',
                      data3: 'নীচের প্রক্রিয়াটি সম্পূর্ণ করুন এবং পরবর্তী আইকনে আলতো চাপুন',
                      data4: 'கீழே உள்ள செயல்முறையை முடித்து அடுத்த ஐகானைத் தட்டவும்',
                      data5: 'దిగువ ప్రక్రియను పూర్తి చేసి, తదుపరి చిహ్నాన్ని నొక్కండి',
                      data6: 'खालील प्रक्रिया पूर्ण करा आणि पुढील चिन्हावर टॅप करा',
                      data7: 'નીચેની પ્રક્રિયા પૂર્ણ કરો અને આગલા ચિહ્ન પર ટેપ કરો',
                      data8: 'ପ୍ରକ୍ରିୟା ନିମ୍ନରେ ସମ୍ପୂର୍ଣ୍ଣ କରନ୍ତୁ ଏବଂ ପରବର୍ତ୍ତୀ ଆଇକନ୍ ଉପରେ ଟ୍ୟାପ୍ କରନ୍ତୁ |',
                      data9: "ਹੇਠਾਂ ਦਿੱਤੀ ਪ੍ਰਕਿਰਿਆ ਨੂੰ ਪੂਰਾ ਕਰੋ ਅਤੇ ਅਗਲੇ ਆਈਕਨ 'ਤੇ ਟੈਪ ਕਰੋ",
                      data10: 'ಕೆಳಗಿನ ಪ್ರಕ್ರಿಯೆಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ ಮತ್ತು ಮುಂದಿನ ಐಕಾನ್ ಮೇಲೆ ಟ್ಯಾಪ್ ಮಾಡಿ',
                      max: 12,min: 11,clr: Colors.black54,
                    )
                ),
                SizedBox(
                  width: size.width * .5, // it just take the 50% width
                  height: size.height*0.14,
                ),
                SizedBox(
                  height: size.height*0.65,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.doc('PujaPurohitFiles/commonCollections/pujanVidhi/${pujanVidhiController.pujanModal.value.keyword}').snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data==null){
                        return Loader();
                      }
                      if(snapshot.data!.exists == true){
                        txtFile(List<dynamic> name, List<dynamic> how,List<dynamic> mantra){
                          return   Padding(
                              padding: const EdgeInsets.only(top:5.0),
                              child: Obx((){return
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text1(data: name[textLanguageController.langData.value.dataCode], max:ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11,weight: FontWeight.bold,),
                                    SizedBox(height: size.height*0.03,),
                                    Text1(data: how[textLanguageController.langData.value.dataCode], max: ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11),
                                    SizedBox(height: size.height*0.05,),
                                    Text1(data: mantra[textLanguageController.langData.value.dataCode], max: ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11),
                                    SizedBox(height: size.height*0.03,),
                                  ],
                                );
                              })

                          );
                        }
                        List<dynamic> vidhi = snapshot.data!.get('setps');
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: vidhi.length,
                          itemBuilder: (_,index){
                            return txtFile(vidhi[index]['name'],vidhi[index]['how'],vidhi[index]['mantra']);
                          },
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top:50.0),
                        child: Text1(data: "Data missing,waiting for Update..", max: 14, min: 11,clr: Colors.redAccent,weight: FontWeight.bold,),
                      );

                    }
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

}
class AartiPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final PujanVidhiController pujanVidhiController = Get.put(PujanVidhiController());
    final TextLanguageController textLanguageController = Get.put(TextLanguageController());
    var size = MediaQuery.of(context).size;
    return Scaffold(

        body:Stack(
          children: [
            Obx((){
              return Container(

                  alignment: Alignment.centerRight,
                  height: size.height * .3,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                    color: Color(int.parse('${pujanVidhiController.pujanModal.value.bg}')),
                  ),
                  child:Obx((){
                    return  Container(
                      padding: EdgeInsets.only(top:20,right: 30),
                      width: size.width*0.4,
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${pujanVidhiController.pujanModal.value.image}'),

                          )
                      ),
                    );
                  })
              );
            }),
            Padding(
              padding: EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1,right: ResponsiveWidget.isSmallScreen(context)? 20:size.width*0.1,top: size.height*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Obx((){
                    return Text1(
                      data: '${pujanVidhiController.pujanModal.value.name}',
                      max: 24,min: 20,clr: Colors.black54,weight: FontWeight.bold,
                    );
                  }),
                  SizedBox(height: 10),
                  Text1(
                    data: '${pujanVidhiController.pujanModal.value.avgDuration}',
                    max: 12,min: 11,clr: Colors.black54,weight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: size.width * .56, // it just take 60% of total width
                      child:Text5(
                        data1: 'Sing  Aarti after that tap on next icon',
                        data2: 'आरती गाएं उसके बाद नेक्स्ट आइकॉन पर टैप करें',
                        data3: 'এরপর আর্তি গাও পরবর্তী আইকনে আলতো চাপুন',
                        data4: 'அடுத்த ஐகானைத் தட்டவும் பிறகு ஆரத்தி பாடுங்கள்',
                        data5: 'తదుపరి ఐకాన్‌పై నొక్కిన తర్వాత ఆర్తి పాడండి',
                        data6: 'त्यानंतर आरती करा पुढील चिन्हावर टॅप करा',
                        data7: 'તે પછી આરતી ગાઓ પછીના આયકન પર ટેપ કરો',
                        data8: 'ପରବର୍ତ୍ତୀ ଆଇକନ୍ ଉପରେ ସେହି ଟ୍ୟାପ୍ ପରେ ଆରତୀ ଗାନ କରନ୍ତୁ |',
                        data9: "ਉਸ ਤੋਂ ਬਾਅਦ ਆਰਤੀ ਗਾਓ ਅਗਲੇ ਆਈਕਨ 'ਤੇ ਟੈਪ ਕਰੋ",
                        data10: 'ಮುಂದಿನ ಐಕಾನ್ ಮೇಲೆ ಟ್ಯಾಪ್ ಮಾಡಿದ ನಂತರ ಆರತಿ ಹಾಡಿ',
                        max: 12,min: 11,clr: Colors.black54,
                      )
                  ),
                  SizedBox(
                    width: size.width * .5, // it just take the 50% width
                    height: size.height*0.15,
                  ),
                  SizedBox(
                    height: size.height*0.65,
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.doc('PujaPurohitFiles/commonCollections/pujanVidhi/${pujanVidhiController.pujanModal.value.keyword}').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.data==null){
                            return Loader();
                          }
                          if(snapshot.data!.exists == true){
                            txtFile(List<dynamic> chama, List<dynamic> data,List<dynamic> why,List<dynamic> meaning){
                              return   Padding(
                                  padding: const EdgeInsets.only(top:5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text1(data: why[textLanguageController.langData.value.dataCode], max: 12, min: 11,weight: FontWeight.bold,),
                                      SizedBox(height: size.height*0.03,),
                                     ListView.builder(
                                       shrinkWrap: true,
                                         physics: NeverScrollableScrollPhysics(),
                                         itemCount: data.length,
                                         itemBuilder: (_,index){
                                           return Text('${data[index]}',textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(fontSize: 12,color: Colors.black54),);
                                         }),

                                      SizedBox(height: size.height*0.05,),
                                      Text5(
                                        data1: 'Chhama prayer',
                                        data2: 'छमा प्रार्थना',
                                        data3: 'ছামার প্রার্থনা',
                                        data4: 'சாமா பிரார்த்தனை',
                                        data5: 'ఛామ ప్రార్థన',
                                        data6: 'छामा प्रार्थना',
                                        data7: 'છમા પ્રાર્થના',
                                        data8: 'ଚାମା ପ୍ରାର୍ଥନା |',
                                        data9: 'ਛਮਾ ਪ੍ਰਾਰਥਨਾ',
                                        data10: 'ಛಾಮ ಪ್ರಾರ್ಥನೆ',
                                        max: ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11,weight: FontWeight.bold,),
                                      SizedBox(height: size.height*0.03,),
                                      Text1(data: chama[textLanguageController.langData.value.dataCode], max: ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11),
                                      SizedBox(height: size.height*0.03,),
                                      Text5(data1: 'Meaning',
                                        data2: 'अर्थ',
                                        data3: 'অর্থ',
                                        data4: 'பொருள்',
                                        data5: 'అర్థం',
                                        data6: 'अर्थ',
                                        data7: 'અર્થ',
                                        data8: 'ଅର୍ଥ',
                                        data9: 'ਭਾਵ',
                                        data10: 'ಅರ್ಥ',
                                        max: ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11,weight: FontWeight.bold,),
                                      SizedBox(height: size.height*0.03,),
                                      Text1(data: meaning[textLanguageController.langData.value.dataCode], max: ResponsiveWidget.isSmallScreen(context)? 12:16, min: 11),
                                    ],
                                  )

                              );
                            }
                            List<dynamic> vidhi = snapshot.data!.get('aarti');
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: vidhi.length,
                              itemBuilder: (_,index){
                                return txtFile(vidhi[index]['chama'],vidhi[index]['${textLanguageController.langData.value.dataCode}'],vidhi[index]['why'],vidhi[index]['meaning']);
                              },
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top:50.0),
                            child: Text1(data: "Data missing,waiting for Update..", max: ResponsiveWidget.isSmallScreen(context)? 14:18, min: 11,clr: Colors.redAccent,weight: FontWeight.bold,),
                          );

                        }
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }

}
class Completion extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/NewAppFiles%2Frandom%2FCompleted%20steps.gif?alt=media&token=5560b0dd-f6c0-4808-b494-ce9be091b0b1'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
             children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.check_circle,color: Colors.green,),
                      SizedBox(height: 5,),
                      Text1(data: "Pujan Sampan", max: 12, min:11,weight: FontWeight.bold,),
                      SizedBox(height: 5,),
                      Text1(data: 'Congratulation on completion of pujan with vedic mantra and step', max: 10, min: 8,clr: Colors.black54,),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){Get.offAllNamed('/home');}, child: Text1(data: 'HomePage', max: 12, min: 11,clr: Colors.white,),style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),primary: Colors.blue[400]
                      ),)
                    ],
                  )
                ],
              )
             ],
            ),
          )
        ],
      ),
    );
  }
  
}