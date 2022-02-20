import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'texts.dart';



class Buttons{
  Widget? button1(Color color,Color txtcolor,double height,double width,max,min,data,double radius,VoidCallback callback){
    return InkWell(
      onTap: (){
        callback();
      },
      child: Container(

        height: height,
        width: width,
        child: Center(child: Text1(clr: txtcolor,max: max, data: data, min: min)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
  Widget? button2(IconData image,Color color,Color color2,Color txtcolor,double height,double width,max,min,data,double radius,VoidCallback callback){
    return InkWell(
      onTap: (){
        callback();
      },
      child: Container(
        padding: EdgeInsets.only(left:3,right: 3),
        height: height,
        width: width,
        child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //ImageIcon(NetworkImage('$image'),color: txtcolor,),
          Icon(image,color: txtcolor,size: max,),
          Text1(clr: txtcolor,max: max, data: data, min: min)
        ],
        )),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color,color2]),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget? tag1(String tag,Color clr){
     double width= Get.width;
    double height = Get.height;
    return Container(
            height: 30,
            width: width*0.05,
            padding: EdgeInsets.only(left:5),
            decoration: BoxDecoration(
              color: clr,
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10))
            ),
            child: Center(
              child:AutoSizeText('$tag',style:GoogleFonts.abel(color:Colors.white, letterSpacing:1),maxFontSize: 14,minFontSize: 12,)
            ),
          );
  }
  Widget? tag2(Color clr){
    double width= Get.width;
    double height = Get.height;
    return Container(
            height: 30,
            width: width*0.01,
            decoration: BoxDecoration(
              color: clr,
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(80))
            ),
          );
  }
}