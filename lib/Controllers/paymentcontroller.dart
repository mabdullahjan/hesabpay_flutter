import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {
  RxString redirectUrl = ''.obs;

  Future<void> createPaymentSession(List<Map<String, dynamic>> items) async {
    String api_key =
        'Your API KEY Here';
    String endpoint =
        'https://api-sandbox.hesab.com/api/v1/payment/create-session';

    Map<String, String> headers = {
      'Authorization': 'API-KEY $api_key',
      'Content-Type': 'application/json',
    };

    String payload = jsonEncode({'items': items});

    http.Response response =
        await http.post(Uri.parse(endpoint), headers: headers, body: payload);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      redirectUrl.value = jsonResponse['url'];
    } else {
      throw Exception('Failed to create payment session');
    }
  }
}
