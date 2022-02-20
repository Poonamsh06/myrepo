import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/trendingModal.dart';

class TrendingController extends GetxController{
Rxn<List<TrendingModal>> trendingList = Rxn<List<TrendingModal>>();

  List<TrendingModal>? get trending => trendingList.value;
@override
void onInit(){
    trendingList.bindStream(trendingStream()); 
    super.onInit();
}
 Stream<List<TrendingModal>> trendingStream() {
    return FirebaseFirestore.instance
        .collection("PujaPurohitFiles")
        .doc("commonCollections")
        .collection("trending").orderBy("num",descending:true).limit(10)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TrendingModal> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TrendingModal.fromSnapshot(element));
      });
      return retVal;
    });
  }
}