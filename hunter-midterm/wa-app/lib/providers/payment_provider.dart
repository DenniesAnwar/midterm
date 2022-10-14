
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/network/init_retrofit.dart';
import 'package:wa_app/network/models/subscription.dart';
import 'package:wa_app/services/functions/helpers.dart';
class PaymentProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value){
    _isLoading = value;
    notifyListeners();
  }
  Future<SubscriptionResponseURL?> subscribePlan(Map<String,dynamic>data) async {
    final client = InitRetrofit.apiService;
    SubscriptionResponseURL? _subscription;
    await client!.scriptPaymentSubscription(data).then((value) {
      _subscription = value;
      Helpers.launchInWebViewWithJavaScript(value.checkoutUrl!);
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return _subscription;
  }
}