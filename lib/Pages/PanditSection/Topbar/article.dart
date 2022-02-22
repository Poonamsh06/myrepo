import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pujapurohit/Pages/PanditSection/Widgets/responsive.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/loader.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/Widgets/newbottombar.dart';
import 'package:pujapurohit/colors/light_colors.dart';

import '../../new_pandit_home.dart';

class Varat extends StatefulWidget {
  @override
  _VaratState createState() => _VaratState();
}

class _VaratState extends State<Varat> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String somesnaps =
        'Healty safe cotton motoposatima evergreen samphonisis got healness too the organiyaplanophisis. Update to avagardo ultaplosis';
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(
            width,
            height * 0.099,
          ),
          child: TopTabs()),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: height,
                    width: width,
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    decoration: BoxDecoration(

                        ),
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .doc('PujaPurohitFiles/Article')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Loader();
                          }
                          List<dynamic> articles =
                              snapshot.data!.get('articles');
                          articles
                              .sort((a, b) => (b["time"]).compareTo(a["time"]));
                          return ResponsiveWidget.isSmallScreen(context)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: articles.length,
                                  itemBuilder: (_, index) {
                                    List<dynamic> content =
                                        articles[index]['content'];
                                    List<dynamic> likes =
                                        articles[index]['likes'];
                                    return articleCards(
                                        articles[index],
                                        likes,
                                        width,
                                        height,
                                        somesnaps,
                                        articles[index]['img'],
                                        articles[index]['title'],
                                        articles[index]['sender'],
                                        articles[index]['sender_img'],
                                        content[0]['data'],
                                        content,
                                        articles[index]['time'],
                                        articles[index]['views']);
                                    //return Text("hi");
                                  })
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        ResponsiveWidget.isMediumScreen(context)
                                            ? 2
                                            : 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio:
                                        ResponsiveWidget.isMediumScreen(context)
                                            ? 0.5
                                            : 0.5,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: articles.length,
                                  itemBuilder: (_, index) {
                                    List<dynamic> content =
                                        articles[index]['content'];
                                    List<dynamic> likes =
                                        articles[index]['likes'];
                                    return articleCards(
                                        articles[index],
                                        likes,
                                        width,
                                        height,
                                        somesnaps,
                                        articles[index]['img'],
                                        articles[index]['title'],
                                        articles[index]['sender'],
                                        articles[index]['sender_img'],
                                        content[0]['data'],
                                        content,
                                        articles[index]['time'],
                                        articles[index]['views']);
                                  },
                                );
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column articleCards(
      dynamic articles,
      List<dynamic> likes,
      double width,
      double height,
      String somesnaps,
      String image,
      String title,
      Sender,
      SenderImg,
      String firstpara,
      List<dynamic> content,
      Timestamp time,
      var views) {
    final ArticleController articleController = Get.put(ArticleController());
    final AuthController authController = Get.put(AuthController());
    DateTime date = time.toDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(

            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage('$SenderImg'),
              ),
              title: Text1(
                data: "$Sender",
                max: 14,
                min: 12,
                weight: FontWeight.bold,
              ),
              subtitle: Text1(
                data:
                    "${DateFormat.yMMMEd().format(date)},${DateFormat.jm().format(date)}",
                max: 12,
                min: 10,
                clr: Colors.black54,
              ),

            ),
          ),
        ),
        SizedBox(
          height: height * .01,
        ),
        Container(
          height: height * 0.3,
          width: width * 0.85,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: NetworkImage('$image'), fit: BoxFit.contain)),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 20),
          child: Column(
            children: [
              Text(
                '$title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "${firstpara.substring(0, 100)}... ",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 12, color: Colors.black54),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'View more',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 11,
                              color: LightColors.color5,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {


                              articleController.updateSomeData(
                                  title,
                                  Sender,
                                  SenderImg,
                                  time,
                                  content,
                                  views,
                                  image,
                                  articles['likes'].length);

                              Get.toNamed('/articledetail');
                            })
                    ]),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ArticleController extends GetxController {
  var articleData = ArticleData().obs;

  updateSomeData(var title, var sender, var senderImage, Timestamp time,
      List<dynamic> content, var views, String img, var likes) {
    articleData.value.contents = content;
    articleData.value.title = title;
    articleData.value.sender = sender;
    articleData.value.senderImage = senderImage;
    articleData.value.time = time;
    articleData.value.views = views;
    articleData.value.img = img;
    articleData.value.likes = likes;
  }
}

class ArticleData {
  String? img;
  var title;
  var likes;
  var sender;
  var senderImage;
  Timestamp? time;
  bool? liked;
  var totalLikes;
  var views;
  List<dynamic>? contents;

  ArticleData(
      {this.likes,
      this.img,
      this.title,
      this.sender,
      this.senderImage,
      this.time,
      this.liked,
      this.totalLikes,
      this.contents,
      this.views});
}

class ArticleDetail extends StatelessWidget {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // DateTime date = articleController.articleData.value.time!.toDate();
    String somesnaps =
        'Healty safe cotton motoposatima evergreen samphonisis got healness too the organiyaplanophisis. Update to avagardo ultaplosis';
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(
            width,
            height * 0.099,
          ),
          child: TopTabs()),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 10, right: width * 0.1),
                  child: SizedBox(
                      width: width * 0.85,
                      child: Obx(() {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                '${articleController.articleData.value.senderImage}'),
                          ),
                          title: Text1(
                            data:
                                "${articleController.articleData.value.sender}",
                            max: 14,
                            min: 12,
                            weight: FontWeight.bold,
                          ),
                          subtitle: Text1(
                            data: "",
                            max: 12,
                            min: 10,
                            clr: Colors.black54,
                          ),
                        );
                      })),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: width * 0.1, right: width * 0.1),
                    child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${articleController.articleData.value.title}',
                            style: TextStyle(
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 18
                                        : 36,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.black54,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text1(
                                data:
                                    '${articleController.articleData.value.likes}',
                                max: 11,
                                min: 10,
                                clr: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                CupertinoIcons.eye_fill,
                                color: Colors.black54,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text1(
                                data:
                                    '${articleController.articleData.value.views}',
                                max: 11,
                                min: 10,
                                clr: Colors.black,
                              ),
                            ],
                          )
                        ],
                      );
                    })),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return SizedBox(
                      height: height * 0.25,
                      child: Image.network(
                        '${articleController.articleData.value.img}',
                        fit: BoxFit.fill,
                      ));
                }),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ResponsiveWidget.isSmallScreen(context)
                          ? 10
                          : width * 0.1,
                      right: ResponsiveWidget.isSmallScreen(context)
                          ? 10
                          : width * 0.1),
                  child: Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: articleController
                            .articleData.value.contents!.length,
                        itemBuilder: (_, index) {
                          return articlePara(
                              width,
                              height,
                              somesnaps,
                              articleController
                                  .articleData.value.contents![index]['data'],
                              articleController
                                  .articleData.value.contents![index]['type'],
                              articleController
                                  .articleData.value.contents![index]['bold'],
                              context);
                        });
                  }),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? MobileBottomBar()
                    : NewBottomBar(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding articlePara(double width, double height, String somesnaps,
      String data, String type, bool bold, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: width * 0.1, bottom: 15),
      child: type == 'txt'
          ? Text(data,
              style: TextStyle(
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 20,
              ))
          : SizedBox(
              height: height * 0.25,
              child: Image.network(
                '${data}',
                fit: BoxFit.contain,
              )),
    );
  }
}
