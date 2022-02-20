import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pujapurohit/Functions/ReverseGeocode.dart';
import 'package:pujapurohit/SignIn/auth_controller.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:pujapurohit/colors/light_colors.dart';
import 'package:pujapurohit/controller/LocationController.dart';
import 'package:pujapurohit/controller/UserController.dart';
import 'dart:html' as html;
class LocationChange extends StatefulWidget{
  final double? lati;
  final double? longi;
  final String? addr;
  LocationChange({this.lati,this.longi,this.addr});
  @override
  _LocationChangeState createState() => _LocationChangeState();
}

class _LocationChangeState extends State<LocationChange> {
  double height = Get.height;
  double width = Get.width;
   //___________________Maps Code_________________________//
  GoogleMapController? googleMapController;
  BitmapDescriptor? mapMarker;
  double? lat;
  double? lng;
  String? addresss;
  List<Marker> myMarker =[];
  void customMarker()async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 50)),'assets/images/location.png');
  }
    _handleTap(LatLng tappedPoint)async{
 String address = await AsistentMethod.searchCoordinateAddress(tappedPoint.latitude.toString(),tappedPoint.longitude.toString());

    setState(() {
     // addresss = address;
      lat = tappedPoint.latitude;
      lng = tappedPoint.longitude;
      myMarker=[];
      myMarker.add(
          Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            icon: mapMarker!
          )
      );
    });
   
  }

  getLocation()async{
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   // String address = await AsistentMethod.searchCoordinateAddress(position.latitude.toString(),position.longitude.toString());
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 14.5,target: LatLng(position.latitude,position.longitude))));
      setState(() {
      lat = position.latitude;
      lng = position.longitude;
     // addresss = address;
       myMarker=[];
      myMarker.add(
          Marker(
            markerId: MarkerId('autolocate'),
            position: LatLng(position.latitude,position.longitude),
            icon: mapMarker!
          )
      );
    });
  }
  @override
  void initState() {
    setState(() {
      lat = widget.lati;
      lng = widget.longi;
      addresss = widget.addr;
    });
    customMarker();
    super.initState();
  }
  AuthController  authController = Get.find();
  @override
  Widget build(BuildContext context) {
     double height = Get.height;
      return Scaffold(
        body:  Row(
            children:[
               Expanded(
                 flex: 2,
                child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: height*0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(
                        flex: 4,
                  child: Container(
                   height: height*0.06,
                   width:200,  
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20),
                   ),
                   child: Center(
                     child: TextFormField( 
                                             
                         onChanged:(value){},                               
                     style: GoogleFonts.aBeeZee(color:Colors.black54,fontSize: 12),
                     decoration:InputDecoration(
                         prefixIcon: Icon(Icons.location_on,size: 12,),
                         hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize: 12),
                     hintText: 'Search for area',
                     border: InputBorder.none
                     )
                     ),
                   ),
                              ),
                      ),
                          SizedBox(width:10),
                           Expanded(
                             flex: 1,
                                                      child: SizedBox(
                       height: 35,width: 35,
                       child: FloatingActionButton(
                        backgroundColor: Colors.white,
                         child: Icon(Icons.gps_fixed_outlined,color: LightColors.kDarkYellow,),
                       onPressed: (){
                       getLocation();                        
                                  
                                 },),
                     ),
                           )
                        ],
                      ),
                ),
                Text1(data: "Do you want to continue with:\n$addresss",max: 14,min: 12,clr: Colors.grey,weight: FontWeight.w300,),
                SizedBox(height:10),
                ElevatedButton(onPressed: ()async{
                await FirebaseFirestore.instance.collection('users').doc('${authController.user!.uid}').update({
                    'lat':lat.toString(),
                    'lng':lng.toString(),
                    'address':addresss
                }).whenComplete(() {
                  //Get.toNamed('/');
                  html.window.location.reload();
                });
              
                }, child: Text1(data: "Continue",max: 12,min: 11,clr: Colors.white,),style: ElevatedButton.styleFrom(primary:Colors.orangeAccent,shape: StadiumBorder()), )
              ],
            ),
              ),
               ),
               




              Expanded(
                flex: 5,
                      child: Container(
              
              child:
                GoogleMap(
                onMapCreated: (controller) => googleMapController = controller,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(zoom: 14,target: LatLng(lat!,lng!),tilt: 50 ),
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
                markers:Set.from(myMarker),
                onTap: _handleTap,            
              )
            
            ),
              ),
                
                
             
               
            ]
              ),
          
      );
  }
   
   
  
}