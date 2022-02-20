
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:pujapurohit/Models/BookingModal.dart';

class BookingController extends GetxController{
   final String? uid;
   final String? bookingId;
   BookingController({this.uid,this.bookingId});
  Rxn<List<BookingModal>> serviceTopList = Rxn<List<BookingModal>>();

  List<BookingModal>? get serviceTop => serviceTopList.value;
  @override
  void onInit(){
    serviceTopList.bindStream(trendingStream());
    super.onInit();
  }
  Stream<List<BookingModal>> trendingStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("bookings").orderBy("timestrap",descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<BookingModal> retVal = [];
      query.docs.forEach((element) {
        retVal.add(BookingModal.fromSnapshot(element));
      });
      return retVal;
    });
  }
}

class BookingDetailController extends GetxController{
  // final String? id;
  // PanditDetailController({this.id});
  Rx<BookingModal> bookingModel = BookingModal().obs;


  @override
  void onInit(){
   // initializePanditModel();

    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  initializePanditModel(int id,String uid)  async{
    bookingModel.value = await FirebaseFirestore.instance
        .collection('users/$uid/bookings').doc('$id')
        .get()
        .then((doc) => BookingModal.fromSnapshot(doc));
  }


}