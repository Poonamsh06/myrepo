import 'package:flutter/material.dart';
import 'package:pujapurohit/colors/light_colors.dart';


class UpcomingListCard extends StatelessWidget {
  
  final String? image;
  final String? name;
  final String? date;
  final String? bottomText;
  final IconData? icn;
  final VoidCallback? tap;
  UpcomingListCard({this.image,this.name,this.date,this.bottomText,this.icn,this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:tap,
      child: Container(
        margin: EdgeInsets.only(left: 24, bottom: 40),
        height: 200,
        width: 180,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                 color: LightColors.kPalePink.withOpacity(0.1),
                // color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 30,
              child: Container(
                height: 100,
                width: 100,
                child: Image.network(
                  '$image',
                  width: 150,
                ),
              ),
            ),
            Positioned(
              top: 120,
              child: Container(
               
                height: 105,
                width: 185,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                     child: Text('$name',style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,fontWeight: FontWeight.bold
                          ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:10.0,right: 15),
                      child: Row(
                        children: [
                          Expanded(
                                                      child: Text('$date',style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11
                            ),),
                          ),
                        
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:10.0,right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                                child: Text('$bottomText',style: TextStyle(
                                color: LightColors.kDarkYellow,
                                fontSize: 11
                            ),),
                          ),
                          
                          Expanded(
                            flex: 1,
                            child: Icon(icn,color: LightColors.kDarkYellow,size: 11,))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

