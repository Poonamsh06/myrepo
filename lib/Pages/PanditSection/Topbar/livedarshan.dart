import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pujapurohit/Widgets/texts.dart';

class LiveDarshan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Text1(data:"Live Darshan",max:12,min:11)
        ]
      ),
    );
  }

}