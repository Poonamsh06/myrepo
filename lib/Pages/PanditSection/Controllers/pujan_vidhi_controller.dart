import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pujapurohit/Models/PujanVidhiModal.dart';
import 'package:pujapurohit/Models/serviceModal.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/PujanVidhi/pujan_vidhi.dart';



class PujanVidhiController extends GetxController{

  var pujanModal = PujanVidhiModel().obs;

   updateName(String keyword,String name,String image,String duration,String description,String bg,String state){
     pujanModal.value.name = name;
     pujanModal.value.image = image;
     pujanModal.value.avgDuration = duration;
     pujanModal.value.description = description;
     pujanModal.value.bg = bg;
     pujanModal.value.keyword = keyword;
     pujanModal.value.state = state;
   }

   updateSamagri(List<Samagriss>samagri){
     pujanModal.value.samagris =samagri;
   }




  }


class PujanVidhiControllerDetailController extends GetxController{
  final String uid;
  final String sid;
  PujanVidhiControllerDetailController({required this.uid,required this.sid});
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