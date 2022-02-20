import 'dart:html';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:js';
//conditional import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';
import 'package:pujapurohit/Models/BookingModal.dart';

import 'package:pujapurohit/Payments/ui_fake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:pujapurohit/Widgets/texts.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Pages/PanditSection/Controllers/booking_controller.dart';

class RazorPayWeb extends StatefulWidget {
  final BookingModal? bookingModal;
  final int? bookingId;
  final String? uid;
  final bool cod;
  RazorPayWeb({this.bookingId,this.bookingModal,this.uid,required this.cod});

  @override
  _RazorPayWebState createState() => _RazorPayWebState();
}
class _RazorPayWebState extends State<RazorPayWeb> {
  final code = OTP.generateTOTPCodeString('JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);





  
  void codCheckout()async{
     double samagri_amount_paid = widget.bookingModal!.Due +widget.bookingModal!.transaction;
    double travel_charge = widget.bookingModal!.pdistance!*3;
    double vtravel_charge = widget.bookingModal!.samagri!?widget.bookingModal!.vdistance!*3:0.0;
    double total_travel_charge = travel_charge.roundToDouble()+vtravel_charge.roundToDouble();
    
    await FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/notification/${widget.bookingModal!.bookingId}').set({
      'token':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'sender':"Booking Confirmed by ${widget.bookingModal!.client}",
      'image':widget.bookingModal!.pic,
      'content':"Visit sharp at ${widget.bookingModal!.time} on ${widget.bookingModal!.date}",
    });
    await FirebaseFirestore.instance.doc('Bookings/${widget.bookingId}').set({
      'ConfirmPayment':false,
      'refundmoney':widget.bookingModal!.refundmoney,
      'refunded':false,
      'online':false,
      'refund':false,
      'deliver':false,
      'benefit':widget.bookingModal!.benefit,
      'dt':widget.bookingModal!.dt,
      'timestrap':widget.bookingModal!.timestamp,
      'samagri_price':widget.bookingModal!.samagri_price,
      'samagri':widget.bookingModal!.samagri,
      'otp':widget.bookingModal!.otp,
      'pandituid':widget.bookingModal!.pandituid,
      'serviceId':widget.bookingModal!.serviceId,
      'btoken':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'Location':widget.bookingModal!.Location,
      'Link':widget.bookingModal!.Location,
      'client':widget.bookingModal!.client,
      'pic':widget.bookingModal!.pic,
      'service':widget.bookingModal!.service,
      'bookingId':widget.bookingModal!.bookingId,
      'pandit':widget.bookingModal!.pandit,
      'price':widget.bookingModal!.puja_charge,
      'convineancefee':widget.bookingModal!.convineancefee,
      'request':widget.bookingModal!.request,
      'rejected':widget.bookingModal!.rejected,
      'puja_status':widget.bookingModal!.puja_status,
      'rating':widget.bookingModal!.rating,
      'swastik':widget.bookingModal!.swastik,
      'date':widget.bookingModal!.date,
      'time':widget.bookingModal!.time,
      'payment orderid':'',
      'payment id':'',
      'cod':true,
      'contact':widget.bookingModal!.contact,
      'AmountPaid':widget.bookingModal!.samagri!?0.0:widget.bookingModal!.Due+total_travel_charge.roundToDouble(),
      'Due':widget.bookingModal!.samagri!?widget.bookingModal!.Due+total_travel_charge.roundToDouble():0.0,
      'payment':true,
    });
    await FirebaseFirestore.instance.doc('RBOOKING/${widget.bookingModal!.bookingId}').delete();
    await FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/puja_offering/${widget.bookingModal!.bookingId}').delete();
    await FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/upComingPuja/${widget.bookingModal!.bookingId}').set({
      'ConfirmPayment':false,
      'refundmoney':widget.bookingModal!.refundmoney,
      'refunded':false,
      'online':false,
      'refund':false,
      'deliver':false,
      'benefit':widget.bookingModal!.benefit,
      'dt':widget.bookingModal!.dt,
      'timestrap':widget.bookingModal!.timestamp,
      'samagri_price':widget.bookingModal!.samagri_price,
      'samagri':widget.bookingModal!.samagri,
      'otp':widget.bookingModal!.otp,
      'pandituid':widget.bookingModal!.pandituid,
      'serviceId':widget.bookingModal!.serviceId,
      'btoken':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'Location':widget.bookingModal!.Location,
      'Link':widget.bookingModal!.Location,
      'client':widget.bookingModal!.client,
      'pic':widget.bookingModal!.pic,
      'service':widget.bookingModal!.service,
      'bookingId':widget.bookingModal!.bookingId,
      'pandit':widget.bookingModal!.pandit,
      'price':widget.bookingModal!.puja_charge,
      'convineancefee':widget.bookingModal!.convineancefee,
      'request':widget.bookingModal!.request,
      'rejected':widget.bookingModal!.rejected,
      'puja_status':widget.bookingModal!.puja_status,
      'rating':widget.bookingModal!.rating,
      'swastik':widget.bookingModal!.swastik,
      'date':widget.bookingModal!.date,
      'time':widget.bookingModal!.time,
      'payment orderid':'',
      'payment id':'',
      'cod':true,
      'contact':widget.bookingModal!.contact,
      'AmountPaid':widget.bookingModal!.samagri!?0.0:widget.bookingModal!.Due+total_travel_charge.roundToDouble(),
      'Due':widget.bookingModal!.samagri!?widget.bookingModal!.Due+total_travel_charge.roundToDouble():0.0,
      'payment':true,
    });
    await FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/paymentHistory/${widget.bookingModal!.bookingId}').set({
      'ConfirmPayment':false,
      'refundmoney':widget.bookingModal!.refundmoney,
      'refunded':false,
      'online':false,
      'refund':false,
      'deliver':false,
      'benefit':widget.bookingModal!.benefit,
      'dt':widget.bookingModal!.dt,
      'timestrap':widget.bookingModal!.timestamp,
      'samagri_price':widget.bookingModal!.samagri_price,
      'samagri':widget.bookingModal!.samagri,
      'otp':widget.bookingModal!.otp,
      'pandituid':widget.bookingModal!.pandituid,
      'serviceId':widget.bookingModal!.serviceId,
      'btoken':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'Location':widget.bookingModal!.Location,
      'Link':widget.bookingModal!.Location,
      'client':widget.bookingModal!.client,
      'pic':widget.bookingModal!.pic,
      'service':widget.bookingModal!.service,
      'bookingId':widget.bookingModal!.bookingId,
      'pandit':widget.bookingModal!.pandit,
      'price':widget.bookingModal!.puja_charge,
      'convineancefee':widget.bookingModal!.convineancefee,
      'request':widget.bookingModal!.request,
      'rejected':widget.bookingModal!.rejected,
      'puja_status':widget.bookingModal!.puja_status,
      'rating':widget.bookingModal!.rating,
      'swastik':widget.bookingModal!.swastik,
      'date':widget.bookingModal!.date,
      'time':widget.bookingModal!.time,
      'payment orderid':'',
      'payment id':'',
      'cod':true,
      'contact':widget.bookingModal!.contact,
      'AmountPaid':widget.bookingModal!.samagri!?0.0:widget.bookingModal!.Due+total_travel_charge.roundToDouble(),
      'Due':widget.bookingModal!.samagri!?widget.bookingModal!.Due+total_travel_charge.roundToDouble():0.0,
      'payment':true,
    });
    FirebaseFirestore.instance.collection('users/${widget.bookingModal!.clientuid}/bookings').doc('${widget.bookingModal!.bookingId}').update({
      'vendor':widget.bookingModal!.samagri!?widget.bookingModal!.vendor_uid:"No samagri",
      'vendor_otp':widget.bookingModal!.samagri!?code:"No Samagri",
      'payment_orderId':'',
      'paymentId':'',
      'AmountPaid':widget.bookingModal!.samagri!?0.0:widget.bookingModal!.Due+total_travel_charge.roundToDouble(),
      'Due':widget.bookingModal!.samagri!?widget.bookingModal!.Due+total_travel_charge.roundToDouble():0.0,
      'payment':true,
      'deliver':false,
      'online':true,
    }).whenComplete((){
      Get.back();
      Get.snackbar("", "Booking confirmed");
    });
  }
  @override
  Widget build(BuildContext context) {
      //double ab = widget.bookingModal!.service_charge;
      double ab = widget.bookingModal!.Due.roundToDouble();
     int price =(double.parse('${ab}')*100.roundToDouble()).toInt();
    //register view factory
    ui.platformViewRegistry.registerViewFactory("rzp-html",(int viewId) {
      IFrameElement element=IFrameElement();
//Event Listener
       window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if(element.data=='MODAL_CLOSED'){
          Navigator.pop(context);
        }else if(element.data=='SUCCESS'){
          print('PAYMENT SUCCESSFULL!!!!!!!');
           double transaction = widget.bookingModal!.Due*0.0225;

     double samagri_amount_paid = widget.bookingModal!.Due +widget.bookingModal!.transaction;
     FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/notification/${widget.bookingModal!.bookingId}').set({
      'token':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'sender':"Booking Confirmed by ${widget.bookingModal!.client}",
      'image':widget.bookingModal!.pic,
      'content':"Visit sharp at ${widget.bookingModal!.time} on ${widget.bookingModal!.date}",
    });
     FirebaseFirestore.instance.doc('Bookings/${widget.bookingId}').set({
      'ConfirmPayment':false,
      'cancel':widget.bookingModal!.cancel,
      'refundmoney':widget.bookingModal!.refundmoney,
      'refunded':false,
      'online':true,
      'refund':false,
      'deliver':false,
      'benefit':widget.bookingModal!.benefit,
      'dt':widget.bookingModal!.dt,
      'timestrap':widget.bookingModal!.timestamp,
      'samagri_price':widget.bookingModal!.samagri_price,
      'samagri':widget.bookingModal!.samagri,
      'otp':widget.bookingModal!.otp,
      'pandituid':widget.bookingModal!.pandituid,
      'serviceId':widget.bookingModal!.serviceId,
      'btoken':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'Location':widget.bookingModal!.Location,
      'Link':widget.bookingModal!.Location,
      'client':widget.bookingModal!.client,
      'pic':widget.bookingModal!.pic,
      'service':widget.bookingModal!.service,
      'bookingId':widget.bookingModal!.bookingId,
      'pandit':widget.bookingModal!.pandit,
      'price':widget.bookingModal!.puja_charge,
      'convineancefee':widget.bookingModal!.convineancefee,
      'request':widget.bookingModal!.request,
      'rejected':widget.bookingModal!.rejected,
      'puja_status':widget.bookingModal!.puja_status,
      'rating':widget.bookingModal!.rating,
      'swastik':widget.bookingModal!.swastik,
      'date':widget.bookingModal!.date,
      'time':widget.bookingModal!.time,
      'payment orderid':'web payment',
      'payment id':'web payment',
      'cod':false,
      'contact':widget.bookingModal!.contact,
      'AmountPaid':widget.bookingModal!.samagri!?samagri_amount_paid:widget.bookingModal!.Due,
      'Due':0.0,
      'payment':true,
    });
     FirebaseFirestore.instance.doc('RBOOKING/${widget.bookingModal!.bookingId}').delete();
     FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/puja_offering/${widget.bookingModal!.bookingId}').delete();
     FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/upComingPuja/${widget.bookingModal!.bookingId}').set({
      'ConfirmPayment':false,
      'refundmoney':widget.bookingModal!.refundmoney,
      'cancel':widget.bookingModal!.cancel,
      'refunded':false,
      'online':true,
      'refund':false,
      'deliver':false,
      'benefit':widget.bookingModal!.benefit,
      'dt':widget.bookingModal!.dt,
      'timestrap':widget.bookingModal!.timestamp,
      'samagri_price':widget.bookingModal!.samagri_price,
      'samagri':widget.bookingModal!.samagri,
      'otp':widget.bookingModal!.otp,
      'pandituid':widget.bookingModal!.pandituid,
      'serviceId':widget.bookingModal!.serviceId,
      'btoken':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'Location':widget.bookingModal!.Location,
      'Link':widget.bookingModal!.Location,
      'client':widget.bookingModal!.client,
      'pic':widget.bookingModal!.pic,
      'service':widget.bookingModal!.service,
      'bookingId':widget.bookingModal!.bookingId,
      'pandit':widget.bookingModal!.pandit,
      'price':widget.bookingModal!.puja_charge,
      'convineancefee':widget.bookingModal!.convineancefee,
      'request':widget.bookingModal!.request,
      'rejected':widget.bookingModal!.rejected,
      'puja_status':widget.bookingModal!.puja_status,
      'rating':widget.bookingModal!.rating,
      'swastik':widget.bookingModal!.swastik,
      'date':widget.bookingModal!.date,
      'time':widget.bookingModal!.time,
      'payment orderid':'web payment',
      'payment id':'web payment',
      'cod':false,
      'contact':widget.bookingModal!.contact,
      'AmountPaid':widget.bookingModal!.samagri!?samagri_amount_paid:widget.bookingModal!.Due,
      'Due':0.0,
      'payment':true,
    });
     FirebaseFirestore.instance.doc('punditUsers/${widget.bookingModal!.pandituid}/paymentHistory/${widget.bookingModal!.bookingId}').set({
      'ConfirmPayment':false,
      'refundmoney':widget.bookingModal!.refundmoney,
      'cancel':widget.bookingModal!.cancel,
      'refunded':false,
      'online':true,
      'refund':false,
      'deliver':false,
      'benefit':widget.bookingModal!.benefit,
      'dt':widget.bookingModal!.dt,
      'timestrap':widget.bookingModal!.timestamp,
      'samagri_price':widget.bookingModal!.samagri_price,
      'samagri':widget.bookingModal!.samagri,
      'otp':widget.bookingModal!.otp,
      'pandituid':widget.bookingModal!.pandituid,
      'serviceId':widget.bookingModal!.serviceId,
      'btoken':widget.bookingModal!.btoken,
      'utoken':widget.bookingModal!.utoken,
      'clientuid':widget.bookingModal!.clientuid,
      'Location':widget.bookingModal!.Location,
      'Link':widget.bookingModal!.Location,
      'client':widget.bookingModal!.client,
      'pic':widget.bookingModal!.pic,
      'service':widget.bookingModal!.service,
      'bookingId':widget.bookingModal!.bookingId,
      'pandit':widget.bookingModal!.pandit,
      'price':widget.bookingModal!.puja_charge,
      'convineancefee':widget.bookingModal!.convineancefee,
      'request':widget.bookingModal!.request,
      'rejected':widget.bookingModal!.rejected,
      'puja_status':widget.bookingModal!.puja_status,
      'rating':widget.bookingModal!.rating,
      'swastik':widget.bookingModal!.swastik,
      'date':widget.bookingModal!.date,
      'time':widget.bookingModal!.time,
      'payment orderid':'web payment',
      'payment id':'web payment',
      'cod':false,
      'contact':widget.bookingModal!.contact,
      'AmountPaid':widget.bookingModal!.samagri!?samagri_amount_paid:widget.bookingModal!.Due,
      'Due':0.0,
      'payment':true,
    });
    FirebaseFirestore.instance.collection('users/${widget.bookingModal!.clientuid}/bookings').doc('${widget.bookingModal!.bookingId}').update({
      'vendor':widget.bookingModal!.samagri!?widget.bookingModal!.vendor_uid:"No samagri",
      'vendor_otp':widget.bookingModal!.samagri!?code:"No Samagri",
      'payment_orderId':'web payment',
      'paymentId':'web payment',
      'AmountPaid':widget.bookingModal!.samagri!?samagri_amount_paid:widget.bookingModal!.Due,
      'Due':0.0,
      'payment':true,
      'deliver':false,
      'online':true,
    });

    Get.back();
    Get.back();
    Get.snackbar("Info", 'Payment sucessfully received');
        }
      });

     // element.requestFullscreen();
      element.src='assets/payment.html?name=${widget.bookingModal!.service}&price=$price&email=${widget.bookingModal!.email}&contact=${widget.bookingModal!.contact}';
      element.style.border = 'none';
      
      
     // element.height = '${(Get.height*0.7).toString()}';
      //element.width = '${(Get.width*0.7).toString()}';
      
      return element;
    });
   
   
   
   
    double transaction = widget.bookingModal!.Due*0.0225;
    double travel_charge = widget.bookingModal!.pdistance!*3;
    double vtravel_charge = widget.bookingModal!.samagri!?widget.bookingModal!.vdistance!*3:0.0;
    double total_travel_charge = travel_charge.roundToDouble()+vtravel_charge.roundToDouble();
    return Scaffold(
      backgroundColor: Colors.white,
    //   body: Builder(builder: (BuildContext context) {
    //       return Column(
    //         children: [
    //           HtmlElementView(viewType: 'rzp-html'),
    //         ],
    //       );
    // })
    body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetX<BookingDetailController>(
            initState:(data)=> Get.put(BookingDetailController()).initializePanditModel(widget.bookingId!, '${widget.uid}'),
            builder: (BookingDetailController bookingDetailController){
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text1(data: "Checkout", max: 24, min: 22,weight: FontWeight.bold,),
                      SizedBox(height: 10,),
                      Text1(data: "${bookingDetailController.bookingModel.value.service}", max: 14, min: 12,clr: Colors.grey,),
                      SizedBox(height: 10,),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 2.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 80,width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('${bookingDetailController.bookingModel.value.service_image}')
                                )
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text1(data: "Purohit : ${bookingDetailController.bookingModel.value.pandit}", max: 11, min: 9,clr: Colors.grey,),
                                  SizedBox(height:10),
                                  Text1(data: "Boking date : ${bookingDetailController.bookingModel.value.date}\nTime: ${bookingDetailController.bookingModel.value.time}", max: 11, min: 9,clr: Colors.grey,),
                                  SizedBox(height:10),
                                  Text1(data: "Address : ${bookingDetailController.bookingModel.value.Location}", max: 11, min: 9,clr: Colors.grey,)
                                ],
                              )),

                        ],
                      ),
                      SizedBox(height:10),
                      Text1(data: "FareBreakup", max: 14, min: 12,clr: Colors.black54,),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 2.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(height:20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text1(data: "Pujan Charge", max: 12, min: 11,clr: Colors.grey,),
                                SizedBox(height: 5,),
                                widget.bookingModal!.samagri!?Text1(data: "Samagri charge", max: 12, min: 11,clr: Colors.grey,):Text1(data: "Convineance Fee", max: 12, min: 11,clr: Colors.grey,),
                                SizedBox(height:5),
                                widget.cod?Text1(data: "Traveling charge", max: 12, min: 11,clr: Colors.grey,):widget.bookingModal!.samagri!?Text1(data: "Transaction charge", max: 12, min: 11,clr: Colors.grey,):SizedBox(),
                                SizedBox(height: 10,),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 2.0,
                                  dashColor: Colors.grey,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                SizedBox(height: 10,),
                                Text1(data: "Total Fee", max: 12, min: 11,clr: Colors.grey,),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text1(data: "\₹ ${bookingDetailController.bookingModel.value.puja_charge}", max: 12, min: 11,clr: Colors.grey,),
                                SizedBox(height: 5,),
                                Text1(data: "\₹ ${widget.bookingModal!.samagri!?bookingDetailController.bookingModel.value.samagri_price:bookingDetailController.bookingModel.value.convineancefee}", max: 12, min: 11,clr: Colors.grey,),
                                SizedBox(height:5),
                                widget.cod?Text1(data: "\₹ ${total_travel_charge.roundToDouble()}", max: 12, min: 11,clr: Colors.grey,):widget.bookingModal!.samagri!?Text1(data: "\₹ ${transaction.roundToDouble()}", max: 12, min: 11,clr: Colors.grey,):SizedBox(),
                                SizedBox(height: 10,),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 2.0,
                                  dashColor: Colors.grey,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                SizedBox(height: 10,),
                                Text1(data: widget.cod?"\₹ ${(bookingDetailController.bookingModel.value.Due)+total_travel_charge.roundToDouble()}":widget.bookingModal!.samagri!?"\₹ ${'${(bookingDetailController.bookingModel.value.Due + transaction.roundToDouble())}'}":"\₹ ${bookingDetailController.bookingModel.value.Due}", max: 12, min: 11,clr: Colors.grey,),
                              ],
                            ))
                      ],),


                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: (){
                            widget.cod?codCheckout():
                            
                            Get.defaultDialog(
                              title: "Payment",
                              content:
                               Container(
                              height: Get.height*0.7,
                              width: Get.width*0.8,
                              child: HtmlElementView(viewType: 'rzp-html')),);
                           
                              //  WebView(
                              //   initialUrl:'',
                              //   javascriptMode:JavascriptMode.unrestricted,
                              //   onWebViewCreated:(WebViewController webViewController){
                              //   _webViewController = webViewController;
                              //   _loadHtmlFileAsset();
                              //   } ,
                              // )
                             
                          }, child: Text1(data: widget.cod?"Confirm":"Pay / Confirm", max: 14, min: 12,clr: Colors.white,),style: ElevatedButton.styleFrom(primary: Colors.orangeAccent,shape: StadiumBorder()),),
                        ],
                      )
                    ],
                  )
                ],
              );
            },
          )
        ),
    
    
    );
  }
  // _loadHtmlFileAsset()async{
  //  String htmlContent = await rootBundle.loadString('assets/payment.html');
  //  _webViewController!.loadUrl(Uri.dataFromString(htmlContent,mimeType : 'payment/html',encoding:Encoding.getByName('utf-8')).toString());
  // }
}


class WebViewTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: InkWell(
      onTap: (){
        launch('assets/payment.html?name=hii');
      },
      child: Text("hi")),
  );
  }

}