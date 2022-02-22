import 'package:flutter/material.dart';
import 'package:pujapurohit/Widgets/texts.dart';

import '../constants.dart';

class CategoryCard extends StatelessWidget {
  final String? svgSrc;
  final String? title;
  final Function? press;
  final String? clr;
  const CategoryCard({
    this.clr,
    this.svgSrc,
    this.title,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xffFFFAF3),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              press!();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  SizedBox(
                      height: height * 0.15,
                      child: Image.network(
                        svgSrc!,
                        fit: BoxFit.fill,
                      )),
                  Spacer(),
                  Text1(
                    data: title!,
                    max: 12,
                    min: 10,
                    clr: Colors.black54,
                    weight: FontWeight.w600,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
