import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/date_contrller.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'dart:math' as Math;
import 'dart:ui' as ui;
class Calender extends StatelessWidget{



  var months = ['January','Feburary','March','April','May','June','July','August','September','October','November','December'];
  DateTime current = DateTime.now();
  @override
  Widget build(BuildContext context) {

    DateController dateController = Get.put(DateController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final double _borderRadius = 24;
    return Scaffold(
      body: Row(
        children:[
          Expanded(
            flex:2,
            child: Container(
              color:LightColors.color6,
              child: Stack(
                  children: [
                   Obx((){
                     return  Positioned(
                      top: height*0.1,
                      left:width*0.05,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                             Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${dateController.userModel.value.moon}'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(75.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: LightColors.color6)
                                        ]),
                                  ),
                                  SizedBox(height:10),
                            Text1(data: "${dateController.userModel.value.date}", max: 14, min: 12,clr: LightColors.color9,),
                            SizedBox(height:10),
                            Text1(data: "${dateController.userModel.value.detail}", max: 14, min: 12,clr: LightColors.color9,)
                        ]
                      ),
                    );
                   }),
                    Positioned(
                      top: height*0.32,
                      left: 30,right: 0,bottom: 0,
                      child: Text1(data: "Calenders", max: 14, min: 11,clr:LightColors.color9 ,)),
                     
                    Positioned(
                      top: height*0.38,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Container( 
                           margin: EdgeInsets.all(5),                           
                                decoration: BoxDecoration(
                                  color: LightColors.color9,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(10),
                                child:  Text1(data: "Hindu Calender", max: 12, min: 11,clr: Colors.white),
                              ),
                              Container( 
                           margin: EdgeInsets.all(5),                           
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(10),
                                child:  Text1(data: "Tamil Calender", max: 10, min: 9,clr: Colors.white)
                              ),
                        ],
                      ))
                  ],
              ),
            )
          ),
           Expanded(
            flex:6,
            child:Container(
              height: height,
              padding: EdgeInsets.only(left:60,right: 60,top: 40,bottom: 5),
             color: LightColors.color6,
             child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children:[
                   Obx((){
                     return Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        IconButton(icon: Icon(Icons.arrow_back_ios,color: LightColors.color9,),iconSize: 18,onPressed: (){
                        if(dateController.month>1){
                           dateController.month--;
                         }
                         else{
                           dateController.month.update((val) {
                              val =0;
                           });
                         }
                       },),
                       
                       Text1(data: "${months.elementAt(dateController.month.value - 1)} 2021", max: 36, min: 32,clr:LightColors.color9,weight:FontWeight.bold),
                      
                       IconButton(icon: Icon(Icons.arrow_forward_ios,color: LightColors.color9,),iconSize: 18,onPressed: (){
                         if(dateController.month<12){
                           dateController.month++;
                         }
                         else{
                           dateController.month.update((val) {
                              val =0;
                           });
                         }
                       },),
                     ],);
                   }),
                     SizedBox(height:20),



                     Obx((){
                       return  Container(
                        height: height*0.8,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('PujaPurohitFiles/commonCollections/Calender/HinduCalender/2021/2021/${months.elementAt(dateController.month.value - 1)}').orderBy("date").snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.data == null){
                              return Center(child: CircularProgressIndicator());
                            }
                            List<Widget> cards=[];
                            for(var i in snapshot.data!.docs){
                               final name = i.get('name');
                                final image = i.get('image');
                                final color1 = i.get('color1');
                                final color2 = i.get('color2');
                                final date = i.get('date');
                                final year = i.get('year');
                                final month = i.get('month');
                                final vikram = i.get('vikram');
                                final englishDate = i.get('english');
                              final cardWidget = calenderItems(date, month, year, name, image, vikram, color1, color2, _borderRadius,englishDate);
                              cards.add(cardWidget);
                            }
                            return ResponsiveWidget.isSmallScreen(context) ?ListView(
                              scrollDirection: Axis.vertical,
                              children: cards,
                              shrinkWrap: false,
                            ):GridView.count(
                              crossAxisSpacing: 50,
                              crossAxisCount: ResponsiveWidget.isMediumScreen(context)?2:3,
                            children: cards,
                            shrinkWrap: true,
                            );
                          }
                        ),
                      );
                     })
                 ]
               ),
             ),
            )
          )
        ]
      ),
    );
  }

  Widget calenderItems(int date,String month,String year,String name,String image,String vikram,String color1,String color2,double _borderRadius,String english){
    return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(_borderRadius),
                                      gradient: LinearGradient(colors: [
                                        Color(int.parse('$color1')),
                                        Color(int.parse('$color2')),
                                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: CustomPaint(
                                      size: Size(100, 150),
                                      painter: CustomCardShapePainter(_borderRadius,
                                           Color(int.parse('$color1')), Color(int.parse('$color2')),)
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Image.network(
                                            '${image}',
                                            height: 84,
                                            width: 84,
                                          ),
                                          flex: 2,
                                        ),
                                        SizedBox(width:10),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text1(data: name, max: 14, min: 12,clr:Colors.white),
                                              SizedBox(height:5),
                                             Text1(data: '$month $year', max: 14, min: 12,clr:Colors.white),
                                              SizedBox(height: 16),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        CupertinoIcons.calendar,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Flexible(
                                                        child: Text1(data: vikram, max: 12,clr: Colors.white,min: 11,)
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        CupertinoIcons.calendar,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Flexible(
                                                          child: Text1(data: english, max: 12,clr: Colors.white,min: 11,)
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '$date',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Avenir',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
  }

}
class Slide2Clipper extends CustomClipper<Path>{
  
  @override
  Path getClip(Size size) {
     var path = Path();
     var radius = 40.0;
     double degToRad(num deg) => deg * (Math.pi / 180.0);
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/2, size.height, size.width, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, 0);
     
    path.close();
    
     

     return path;
    }
  
    @override
    bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

}



class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}