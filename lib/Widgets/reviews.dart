import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pujapurohit/Models/serviceModal.dart';

import 'texts.dart';
class Reviews extends StatelessWidget{
  final String uid;
  final String ServiceId;
  final bool? pandit;
  final double? swastik;
  final int? raters;
  final int? reviewers;
  Reviews({required this.pandit,this.swastik,this.raters,this.reviewers,required this.uid,required this.ServiceId});
  double width = Get.width;
  double height=Get.height;

  @override
  Widget build(BuildContext context) {
    var swast= swastik;
    double overall_rate=swast!/raters!;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text1(max: 26, data: "Ratings and Reviews", min: 24,clr:Colors.black87,weight: FontWeight.bold,),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Column(
                      children:[
                        Text1(max: 14, data: swastik!<=0.0?'0.0' :"${overall_rate.toStringAsFixed(1)}", min: 12,clr:Colors.black87,weight: FontWeight.bold,),
                        SizedBox(height:5),
                       Text1(max: 12, data: "$raters Rating & $reviewers Reviews", min:  11,clr:Colors.black87),

                      ]
                  ),

                ]
            ),
            SizedBox(height: 20,),
            StreamBuilder<QuerySnapshot>(
                stream:pandit!?FirebaseFirestore.instance.collection('Avaliable_pundit/${uid}/reviews').where("type", isEqualTo:"specific").snapshots():
                FirebaseFirestore.instance.collection('Avaliable_pundit/${uid}/puja_offering/${ServiceId}/reviews').where("type", isEqualTo:"specific").snapshots()
                ,
                builder: (context, snapshot) {
                  if(snapshot.data == null){
                    return Center(child:CircularProgressIndicator());
                  }
                  final servicess = snapshot.data!.docs.reversed;

                  List<Widget> servicessWidgets=[];

                  for(var mess in servicess){
                    final name=mess.get('name');
                    final rate= mess.get('rate');
                    final raters=mess.get('raters');

                    final messWidget=  specific( context,name,rate,raters);
                    servicessWidgets.add(messWidget);

                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: servicessWidgets,

                  );
                }
            ),
            SizedBox(height:20),
            StreamBuilder<QuerySnapshot>(
                stream: pandit!?FirebaseFirestore.instance.collection('Avaliable_pundit/${uid}/reviews').where("type", isEqualTo:"review").snapshots():
                FirebaseFirestore.instance.collection('Avaliable_pundit/${uid}/puja_offering/${ServiceId}/reviews').where("type", isEqualTo:"review").snapshots()
                ,
                builder: (context, snapshot) {
                  if(snapshot.data == null){
                    return Center(child:CircularProgressIndicator());
                  }
                  if(snapshot.data!.docs.isEmpty){
                    return Center(child:Text1(data: "No reviews yet",max: 12,min: 11,clr: Colors.black54,));
                  }
                  final servicess = snapshot.data!.docs.reversed;

                  List<Widget> servicessWidgets=[];

                  for(var mess in servicess){
                    final name=mess.get('name');
                    final rate= mess.get('rate');
                    final raters=mess.get('raters');
                    final content=mess.get('content');
                    final messWidget=  contents( context,name,rate,raters,content);
                    servicessWidgets.add(messWidget);
                  }
                  return ListView(
                    children:servicessWidgets ,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                }
            )
          ],
        ),
      ),
    );
  }

  Column contents(BuildContext context,String name,var rate,var raters,String content) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            children:[
              Container(
                //padding: EdgeInsets.all(10),

                  width: 35,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text1(max: 12, data: "$rate", min: 10,clr:Colors.white),
                        Icon(Icons.star,color: Colors.white,size:12)
                      ],),
                  )
              ),
              SizedBox(width:10),
             Text1(max: 14, data: "$name", min: 12,clr:Colors.black87,weight: FontWeight.w600,),

            ]
        ),
        SizedBox(height:10),
        Text1(max: 12, data: "$content", min: 11,clr:Colors.black54),
        SizedBox(height:10),
        pandit!?SizedBox():SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  height:70,width:70,
                  decoration:BoxDecoration(
                      image:DecorationImage(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/Users%2F1ZWLOtDrYRe3IvG4bib3dmL3Mbr1%2F1?alt=media&token=db950418-3ea7-405e-8263-6e867c87e579"),fit:BoxFit.fill)
                  )
              ) ,
              Container(
                  margin: EdgeInsets.all(10),
                  height:70,width:70,
                  decoration:BoxDecoration(
                      image:DecorationImage(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/Users%2F1ZWLOtDrYRe3IvG4bib3dmL3Mbr1%2F1?alt=media&token=db950418-3ea7-405e-8263-6e867c87e579"),fit:BoxFit.fill)
                  )
              )
            ],
          ),
        )

      ],
    );
  }

  Column specific(BuildContext context,String name,var rate,var raters) {
    double overall_rate=(rate/raters);
    double overall_rate_percent=rate/raters/10;
    Color circleColor(){
      if(overall_rate_percent>0.4){
        return Colors.green;
      }
      if(overall_rate_percent>0.3 && overall_rate_percent<0.4){
        return Colors.orangeAccent;
      }
      return Colors.redAccent;
    }
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50,
          lineWidth: 5.0,
          percent: overall_rate_percent*2,
          center: Text1(max: 10, data: "${overall_rate.toStringAsFixed(1)}", min: 9,clr:Colors.black87,weight: FontWeight.bold,),
          //progressColor: overall_rate_percent>0.5?Colors.green[600]:overall_rate_percent>0.3?Colors.yellow[600]:Colors.orangeAccent[600],
          progressColor: circleColor(),
        ),
        SizedBox(height:5),
        Text1(max: 12, data: "$name", min: 11,clr:Colors.black87,),
      ],
    );
  }

}
class DescriptionController extends GetxController{
  Rx<ServiceModal> userModel = ServiceModal().obs;

  initializeBModalModel(String userId,String serviceId)  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('Avaliable_pundit/${userId}/puja_offering')
        .doc(serviceId)
        .get()
        .then((doc) =>ServiceModal.fromSnapshot(doc));
  }

}
