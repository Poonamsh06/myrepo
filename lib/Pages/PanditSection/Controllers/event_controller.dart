

import 'package:get/get.dart';

class EventController extends GetxController{
  var eventData = EventData().obs;

  updateData(String image,String name,List<dynamic> age,List<dynamic> gender){
    eventData.update((val) {
      val!.image = image;
      val.name = name;
      val.age = age;
      val.gender= gender;
    });
  }
  updatePrevious(String bigs,String youtube,String place,String status,String image,String name,String  about,String duration,String totalDays ,List<dynamic> top3,List<dynamic> participants){
    eventData.update((val) {
      val!.about = about;
      val.image = image;
      val.name = name;
      val.top3 = top3;
      val.duration = duration;
      val.totalDays = totalDays;

      val.status = status;
      val.place = place;
      val.participants = participants;
      val.youtube = youtube;
      val.bigs = bigs;
    });

  }
  updateUpcoming(String bigs,String youtube,String puja,dynamic price,String note,List<dynamic> age,List<dynamic> gender,String place,String status,String image,String name,String  about,String duration,String totalDays ,List<dynamic> participants,List<dynamic> terms){
    eventData.update((val) {
      val!.about = about;
      val.image = image;
      val.name = name;
      val.duration = duration;
      val.totalDays = totalDays;
      val.status = status;
      val.place = place;
      val.participants = participants;
      val.terms = terms;
      val.age = age;
      val.gender= gender;
      val.note = note;
      val.price = price;
      val.puja = puja;
      val.youtube = youtube;
      val.bigs = bigs;
      
    });
  }
  updateLive(String BigS,String youtube,dynamic price,String note,List<dynamic> age,List<dynamic> gender,String place,String status,String image,String name,String  about,String duration,String totalDays ,List<dynamic> participants,List<dynamic> terms){
    eventData.update((val) {
      val!.about = about;
      val.image = image;
      val.name = name;
      val.duration = duration;
      val.totalDays = totalDays;
      val.status = status;
      val.place = place;
      val.participants = participants;
      val.terms = terms;
      val.age = age;
      val.gender= gender;
      val.note = note;
      val.price = price;
      val.youtube = youtube;
      val.bigs = BigS;
    });
  }
  updateParticipants(List<dynamic> p){
    eventData.value.participants1 = p;
  }
}
class EventData{
  String? bigs;
  String? youtube;
  String? puja;
  String? image;
  String? name;
  String? status;
  String? note;
  String? place;
  String? duration;
  String? about;
  String? totalDays;
  List<dynamic>? top3;
  List<dynamic>? terms;
  dynamic price;
  List<dynamic>?participants;
  List<dynamic>?participants1;
  List<dynamic>? age;
  List<dynamic>? gender;
  EventData({this.bigs,this.youtube,this.puja,this.participants1,this.totalDays,this.top3,this.image,this.name,this.age,this.gender,this.note,this.status,this.place,this.duration,this.about,this.terms,this.participants});
}

class EventControllerPayment extends GetxController{
  var paymentData = EventPaymentData().obs;

  updatePayment(String name, String age, String image, String gender, String event,int num,String puja,List<dynamic> participant1){
      paymentData.update((val) {
        val!.name = name;
        val.age = age;
        val.image = image;
        val.gender = gender;
        val.event = event;
        val.num = num;
        
        val.puja = puja;
        val.participants1 = participant1;
      });
  }
}

class EventPaymentData{
  String? name;
  String? age;
  String? image;
  String? gender;
  String? event;
  String? puja;
  int? num;
  
  List<dynamic>? participants1;
  EventPaymentData({this.participants1, this.puja,this.name,this.age,this.image,this.gender,this.event,this.num});
}