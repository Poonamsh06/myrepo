import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/CalenderModal.dart';

class CalenderController extends GetxController{
  final int month;
  CalenderController({required this.month});
  Rx<CalenderModel> userModel =CalenderModel().obs;
  Rxn<List<CalenderModel>>calenderList = Rxn<List<CalenderModel>>();
  
  List<CalenderModel>? get serviceTop => calenderList.value;
  @override
  void onInit(){
   
    calenderList.bindStream(trendingStream()); 
    super.onInit();
  }
  @override
  void onClose(){
    
    super.onClose();
  }
  Stream<List<CalenderModel>> trendingStream() {
    
    return FirebaseFirestore.instance
        .collection("PujaPurohitFiles")
        .doc("commonCollections")
        .collection("Calender").doc('2021').collection('${month}').orderBy("date")
        .snapshots()
        .map((QuerySnapshot query) {
      List<CalenderModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(CalenderModel.fromSnapshot(element));
      });
      return retVal;
    });
  }
  initializeUserModel()  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('PujaPurohitFiles')
        .doc('commonCollections').collection('Calender').doc('2021')
        .get()
        .then((doc) => CalenderModel.fromSnapshot(doc));
  }

 
}