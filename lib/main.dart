import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pujapurohit/Pages/PanditSection/contest.dart';
import 'package:pujapurohit/Pages/PanditSection/Controllers/event_controller.dart';
import 'package:pujapurohit/Pages/PanditSection/custom_city.dart';
import 'package:pujapurohit/Pages/PanditSection/detail.dart';
import 'package:pujapurohit/Pages/PanditSection/new_landing_page.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/calender.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/livedarshan.dart';
import 'package:pujapurohit/Pages/PanditSection/Topbar/muhurat.dart';
import 'package:pujapurohit/Pages/Services/database.dart';
import 'package:pujapurohit/Pages/location_change.dart';
import 'package:pujapurohit/SignIn/starter_controller.dart';
import 'package:pujapurohit/SignIn/update.dart';
import 'package:pujapurohit/Starter/blanding.dart';
import 'package:pujapurohit/Starter/landing.dart';
import 'package:pujapurohit/Starter/splash_screen.dart';
import 'package:pujapurohit/Widgets/youtube_player.dart';
import 'package:pujapurohit/construction.dart';
import 'package:pujapurohit/controller/loaderController.dart';
import 'Pages/new_pandit_home.dart';
import 'Pages/PanditSection/account.dart';
import 'Pages/PanditSection/Event/event_detail.dart';
import 'Pages/PanditSection/Event/event_registration.dart';
import 'Pages/PanditSection/Event/events.dart';
import 'Pages/PanditSection/Event/image_view.dart';
import 'Pages/PanditSection/pandit_home.dart';
import 'Pages/PanditSection/profile.dart';
import 'Pages/PanditSection/service_detail.dart';
import 'Pages/PanditSection/Topbar/PujanVidhi/pujan_vidhi.dart';
import 'Pages/PanditSection/Topbar/PujanVidhi/screens/details_screen.dart';
import 'Pages/PanditSection/Topbar/article.dart';
import 'Pages/PanditSection/Topbar/offers.dart';
import 'Pages/PanditSection/Widgets/image_view.dart';
import 'Pages/PanditSection/Topbar/live.dart';
import 'Pages/PanditSection/Widgets/themes.dart';
import 'Pages/booking.dart';
import 'Pages/search_places.dart';
import 'SignIn/auth_controller.dart';
import 'Widgets/loader.dart';
import 'bindings/LocationBinding.dart';
import 'colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controller/LocationController.dart';
import 'controller/UserController.dart';
import 'controller/loginController.dart';
void main()async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());
    });
  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) => MyApp(),
  // ),);
}


class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //builder: DevicePreview.appBuilder,
      theme: Themes.light,
      //darkTheme: Themes.dark,
    initialBinding: LocationBinding(),
    //home: ImageTest(),
    initialRoute: '/home',
      title: "Book pandit Online, Online Pandit, Booking Pandit for Puja, Marriage, Katha,Pandit nearby you",

      getPages: [
        // GetPage(name: '/', page:()=>SplashScreen()),
        // GetPage(name: '/landing', page:()=>Landing()),
        GetPage(name: '/home', page:()=>IsLocated()),
        GetPage(name: '/profile', page:()=> Profile()),
        GetPage(name: '/serviceDetail', page:()=>ServiceDetail()),
        GetPage(name: '/address', page: ()=>AddressPage()),
        GetPage(name: '/samagri', page: ()=>Samagri()),
        GetPage(name: '/account', page:()=>Account()),
        GetPage(name: '/booking', page:()=>BookingFinish()),
        GetPage(name: '/locationchange', page: ()=>LocationChange()),
        GetPage(name: '/bookings', page:()=>Booking()),
        GetPage(name: '/live', page: ()=>Live()),
        GetPage(name: '/offer', page: ()=>Offer()),
        GetPage(name: '/muhurat', page: ()=>Mahurat()),
        GetPage(name: '/pujanvidhi', page: ()=>PujaVidhi()),
        GetPage(name: '/pujanvidhidetail', page: ()=>PujanDetailsScreen()),
        GetPage(name: '/steps', page: ()=>Steps()),
        GetPage(name: '/article', page: ()=>Varat()),
        GetPage(name: '/calender', page: ()=>Calender())    ,
        GetPage(name: '/livedarshan', page: ()=>LiveDarshan()),
        GetPage(name: '/varat', page: ()=>Varat()),
        GetPage(name: '/detail', page: ()=>Detail()),
        GetPage(name: '/articledetail', page: ()=>ArticleDetail()),
        //GetPage(name: '/searchplaces', page: ()=>SearchPlaces()),
        // GetPage(name: '/contest', page: ()=>Contest()),
        // GetPage(name: '/DetailView', page: ()=>DetailView()),
        GetPage(name: '/location', page:()=> CustomCity()),
         GetPage(name: '/event', page: ()=>Events()),
        GetPage(name:'/eventDetail',page:()=>EventDetail()),
        GetPage(name: '/imageview', page:()=>ImageView()),
        GetPage(name: '/registration', page:()=> RegistrationForm() ),
         GetPage(name: '/success', page:()=> SuccessPage()),
      ],
    );
  }
}

class IsLocated extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    LocationController locationController = Get.put(LocationController());
    LoginController loginController = Get.put(LoginController());
    AuthController authController =Get.put(AuthController());
    //UserController userController = Get.put(UserController());
    return Obx((){
    
      if(authController.user!=null){
       if(authController.user!.photoURL==null || authController.user!.displayName==null){
          return Update();
       }
        

        //final UserController userController = Get.put(UserController());

        if(authController.user!.photoURL!=null && authController.user!.displayName!=null){
         // locationController.updateLat(double.parse('${userController.userModel.value.lat}'), double.parse('${userController.userModel.value.lng}'));
          //locationController.updateAddress(locationController.location.value.lat.toString(),locationController.location.value.lng.toString());
          return NewPanditHome();
        }
         else{
         return Container(
             color: Colors.white,
             child: Center(child: Loader(),));
        }
      
    }
    if(locationController.location.value.lat!= null){
     // locationController.updateAddress(locationController.location.value.lat.toString(),locationController.location.value.lng.toString());
      //locationController.updateLat(double.parse('source'), lng)
      return Obx((){
     return locationController.location.value.lat!=null?Provider<Database>(create: (_)=>FirestoreDatabase(),child: PanditHome(),):Landing();
   });
    }
    return BLanding();
   });
   
  
   
  }

}


class SuccessPage extends StatefulWidget {
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  final EventControllerPayment eventControllerPayment = Get.put(EventControllerPayment());

  final AuthController authController = Get.put(AuthController());

  final LoadController loadController = Get.put(LoadController());

  String index = Get.parameters["id"]!;
  @override
  void initState() {
    FirebaseFirestore.instance.doc("PujaPurohitFiles/events/${eventControllerPayment.paymentData.value.event}/${authController.user!.uid}").set({
                                                    'name': "${eventControllerPayment.paymentData.value.name}",
                                                    'age':"${eventControllerPayment.paymentData.value.age}",
                                                    'votes':0,
                                                    'voters':FieldValue.arrayUnion([]),
                                                    'image':"${eventControllerPayment.paymentData.value.image}",
                                                    'vote':false,
                                                    'gender':"${eventControllerPayment.paymentData.value.gender}",
                                                    'event':"${eventControllerPayment.paymentData.value.event}",
                                                    'num':FieldValue.increment(eventControllerPayment.paymentData.value.participants1!.length+1),
                                                    'id':authController.user!.uid,
                                                    'puja':"${eventControllerPayment.paymentData.value.puja}",
                                                    'payment':true,
                                                  }).whenComplete(() async{
                                                    // List<dynamic> participants1 = eventControllerPayment.paymentData.value.participants1!;
                                                    // List<dynamic> total_V= participants1;
                                                    // participants1.add(authController.user!.uid);
                                                    // await FirebaseFirestore.instance.doc('/PujaPurohitFiles/events').update(({
                                                    //   '${eventControllerPayment.paymentData.value.name}P':total_V
                                                    // }));
                                                    
                                                    loadController.updateLoad();
                                                  });
               
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 200,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Payment Received',
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx((){
                return loadController.load.value.active?SizedBox(height: 50,width: 50, child: Loader(),):

                 ElevatedButton(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Click here to submit application",style: Theme.of(context).textTheme.headline5,),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.orangeAccent,shape: StadiumBorder()),
                        onPressed: ()async{
                              loadController.updateLoad();
                              Get.offAndToNamed('/eventDetail?event=$index');
                        },
                        );
            
            
              })
            ],
          )
        ],
      ),
    );
  }
}