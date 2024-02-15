import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

abstract class PaymentManager {
  static Future<void> makePayment(var amount, String currency) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    } catch (e, s) {
      log('exception:$e$s');
      throw Exception(e.toString());
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Shoppy",
      ),
    );
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    var response = await http.post(
      Uri.parse(
        'https://api.stripe.com/v1/payment_intents',
      ),
      headers: {
        'Authorization': 'Bearer ${dotenv.load(fileName: "assets/.env")}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'amount': amount,
        'currency': currency,
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      log(response.body);
      throw 'Failed to register as a customer.';
    }
  }
}
