import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/bottombar.dart';
import 'package:url_launcher/link.dart';

class Offer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    String offerId = Get.parameters['offer']!;
    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        children: [      
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                  StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('PujaPurohitFiles/sliders/second').doc('$offerId').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.data == null){
                      return SizedBox(
                        height:50,
                        child: Center(
                          child: Loader(),
                        ),
                      );
                    }

                     Map<String,dynamic>? terms;
                      List<String> eligibility =[];
                      List<Widget> l1=[];
                      List<Widget> l2=[];
                      List<Widget> l3=[];
                     
                    for(var i in snapshot.data!.get('T&CEnglish')){
                      terms = i;
                    }
                    for(var o in terms!['Offer eligibility :']){                
                      final wids =   Text2(data: "• $o", max: 12);
                      l1.add(wids);
                    }
                     for(var o in terms['Offer duration :']){                
                      final wids =   Text2(data: "• $o", max: 12);
                      l2.add(wids);
                    }
                     for(var o in terms['Rewards']){                
                      final wids =   Text2(data: "• $o", max: 12);
                      l3.add(wids);
                    }
                   
                    return Column(
                      children: [

                        Image.network('${snapshot.data!.get('image1')}'),
                        SizedBox(height:20),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text2(data: "Terms and Conditions to avail this offer:", max:14,clr:Colors.black87),
                        ),
                        SizedBox(height:10),
                        Padding(
                           padding: const EdgeInsets.only(left:20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text2(data: "Offer duration", max: 12),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: l2,)      ,
                                SizedBox(height:15),
                              Text2(data:"Offer Eligibility", max: 12),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: l1,),
                                 SizedBox(height:15),
                               Text2(data:"Rewards", max: 12),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: l3,),
                                SizedBox(height:20)                            
                            ],
                          ),
                        ),

                        BottomBar(),
                      ],
                    );
                  }
                ),

              
              ],
            ),
          ),
        ],
      )
    );
  }

  Link socialButton(IconData icn,String link) {
    return Link(
                     target: LinkTarget.blank,
                     uri: Uri.parse('$link'),
                     builder: (context, snapshot) {
                       return IconButton(icon: Icon(icn,size: 24,color: Colors.white,),onPressed: (){},);
                     }
                   );
  }

}