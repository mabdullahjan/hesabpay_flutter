import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabpay_gateway/Controllers/paymentcontroller.dart';
import 'package:hesabpay_gateway/paymentpage.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter WebView Example',
      home: FutureBuilder(
        future: paymentController.createPaymentSession([
          {'name': 'Item 1', 'price': 5},
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return PaymentPage(url: paymentController.redirectUrl.value);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
