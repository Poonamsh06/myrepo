import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';

import 'package:pujapurohit/Models/BModal.dart';


class PanditController extends GetxController{
  final double lat;
  final double lng;
  PanditController({required this.lat,required this.lng});
   Geoflutterfire geo = Geoflutterfire();
    //GeoFirePoint center = geo.point(latitude: 26.1387827, longitude: 85.3601984);
     
    double radius = 15;
    String field = 'location';
    
Rxn<List<BMModal>> panditList = Rxn<List<BMModal>>();

  List<BMModal>? get pandits => panditList.value;
@override
void onInit(){
    panditList.bindStream(panditStream()); 
    super.onInit();
}
 Stream<List<BMModal>> panditStream() {
   GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
   final reference = FirebaseFirestore.instance.collection('Avaliable_pundit');
    final stream = geo.collection(collectionRef: reference).within(center: center, radius: radius, field: field);
   
   return stream
        .map((query) {
          
      List<BMModal> retVal = [];
      query.forEach((element) {
        retVal.add(BMModal.fromSnapshot(element));
      });
      return retVal..shuffle();
    });
  }

  Stream<List<BMModal>> panditKeywordStream(String where,String what) {
   GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
   final reference = FirebaseFirestore.instance.collection('Avaliable_pundit').where(where,isEqualTo:what);
    final stream = geo.collection(collectionRef: reference).within(center: center, radius: radius, field: field);
   
   return stream
        .map((query) {
          
      List<BMModal> retVal = [];
      query.forEach((element) {
        retVal.add(BMModal.fromSnapshot(element));
      });
      return retVal..shuffle();
    });
  }
}

class PanditDetailController extends GetxController{
  final String uid;
  PanditDetailController({required this.uid});
  Rx<BMModal> userModel = BMModal(swastik: 0.0,verified: false).obs;


  @override
  void onInit(){
    initializePanditModel();

    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  initializePanditModel()  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('Avaliable_pundit')
        .doc('$uid')
        .get()
        .then((doc) => BMModal.fromSnapshot(doc));
  }


}
class PanditKeywordController extends GetxController{
  final double lat;
  final double lng;
  final String what;
  PanditKeywordController({required this.lat,required this.lng,required this.what});
   Geoflutterfire geo = Geoflutterfire();
    //GeoFirePoint center = geo.point(latitude: 26.1387827, longitude: 85.3601984);
     
    double radius = 15;
    String field = 'location';
    
Rxn<List<BMModal>> panditList = Rxn<List<BMModal>>();

  List<BMModal>? get pandits => panditList.value;
@override
void onInit(){
    panditList.bindStream(panditKeywordStream()); 
    super.onInit();
}

  Stream<List<BMModal>> panditKeywordStream() {
   GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
   final reference = FirebaseFirestore.instance.collection('Avaliable_pundit').where('PujaKeywords',arrayContains: what);
    final stream = geo.collection(collectionRef: reference).within(center: center, radius: radius, field: field);
   
   return stream
        .map((query) {
          
      List<BMModal> retVal = [];
      query.forEach((element) {
        retVal.add(BMModal.fromSnapshot(element));
      });
      return retVal..shuffle();
    });
  }
}