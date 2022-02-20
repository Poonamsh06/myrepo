import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/serviceModal.dart';
import 'package:pujapurohit/Models/servicetop.dart';


class ServiceTopController extends GetxController{
  final String uid;
  ServiceTopController({required this.uid});
Rxn<List<ServiceTopModal>> serviceTopList = Rxn<List<ServiceTopModal>>();

  List<ServiceTopModal>? get serviceTop => serviceTopList.value;
@override
void onInit(){
    serviceTopList.bindStream(trendingStream()); 
    super.onInit();
}
 Stream<List<ServiceTopModal>> trendingStream() {
    return FirebaseFirestore.instance
        .collection("Avaliable_pundit")
        .doc("$uid")
        .collection("Category").orderBy("name",descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ServiceTopModal> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ServiceTopModal.fromSnapshot(element));
      });
      return retVal;
    });
  }
}

class ServiceDetailController extends GetxController{
  final String uid;
  final String sid;
  ServiceDetailController({required this.uid,required this.sid});
  Rx<ServiceModal> userModel = ServiceModal(swastik: 0.0,).obs;


  @override
  void onInit(){
    initializeServiceModel();

    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  initializeServiceModel()  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('Avaliable_pundit/$uid/puja_offering')
        .doc('$sid')
        .get()
        .then((doc) => ServiceModal.fromSnapshot(doc));
  }


}