import 'package:get/get.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/controller/LocationController.dart';



class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(() => LocationController(),); // here!
    Get.put<AuthController>(AuthController(), permanent: true);

  }
}
