import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohit/Widgets/texts.dart';

class Construction extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/swastik13-8242d.appspot.com/o/appfiles%2Fanoounce.jpg?alt=media&token=01578845-9018-4c1b-9fef-4c7320cba4da'))
              ),
            
            height: height*0.5,
            
          ),
          SizedBox(height:10),
          Text2(data: "Website under Construction will be live soon", max: 24,clr:Colors.black54)
        ],
      )
    );
  }

}