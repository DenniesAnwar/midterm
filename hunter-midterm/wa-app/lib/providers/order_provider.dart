import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wa_app/network/models/order_response.dart';
import 'package:wa_app/utills/constants.dart';

import '../network/init_retrofit.dart';
import '../services/functions/helpers.dart';

class OrderProvider extends ChangeNotifier {
  OrderResponse? _orderResp;

  OrderResponse? get orderResp => _orderResp;

  Future<OrderResponse?> getOrders() async {
    final client = InitRetrofit.apiService;
    await client!.getOrders().then((value) {
      _orderResp = value;
      for (var script in _orderResp!.orderData!) {
        if (script.checkoutAmount != null) {
          var status = _scriptStatus(script.checkoutUntil!, script.period!);
          script.dataModel!.isExpired = status['isExpired'];
          script.dataModel!.willExpireIn = status['willExpireIn'];
        }
      }
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
    return _orderResp;
  }

  Map<String, dynamic> _scriptStatus(String date, String period) {
    bool isExpired = false;
    String willExpireIn = "Expired";

    DateTime checkoutDate = DateTime.parse(date);
    bool is6Month = period == ScriptPurchaseDuration.sixMonthSubscriptions;

    DateTime expiryDate =
        Jiffy(checkoutDate).add(months: is6Month ? 6 : 12).dateTime;

    willExpireIn = Jiffy(expiryDate).fromNow();

    if (willExpireIn.contains('year')) {
      willExpireIn = 'in 12 months';
    }
    if (willExpireIn.contains('ago')) {
      willExpireIn = 'Expired';
      isExpired = true;
    }

    return {'willExpireIn': willExpireIn, 'isExpired': isExpired};
  }
}
