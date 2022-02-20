import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:pujapurohit/Models/hinduDate.dart';

class DateController extends GetxController{
  Rx<HinduDateModel> userModel = HinduDateModel().obs;
  var month = int.parse('${DateFormat.M().format(DateTime.now())}').obs;

  @override
  void onInit(){
    initializeUserModel();
   
    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  initializeUserModel()  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('PujaPurohitFiles')
        .doc('hinduDate')
        .get()
        .then((doc) => HinduDateModel.fromSnapshot(doc));
  }

 
}

