import 'package:flutter/foundation.dart';
import 'package:wa_app/utills/constants.dart';

class ProducerScriptPurchaseProvider extends ChangeNotifier{
  String _checkout='';
  String _successUrl=CheckoutUrls.refreshUrl;
  String _cancelUrl=CheckoutUrls.retrunUrl;
  String _period='';
  String _scriptId='';

  String get scriptId => _scriptId;
  String get checkout => _checkout;
  String get successUrl => _successUrl;
  String get cancelUrl => _cancelUrl;
  String get period => _period;

  set scriptId (value) {
    _scriptId=value;
    notifyListeners();
  }
  set checkout (value) {
    _checkout=value;
    notifyListeners();
  }
  set successUrl (value) {
    _successUrl=value;
    notifyListeners();
  }
  set cancelUrl (value) {
    _cancelUrl=value;
    notifyListeners();
  }
  set period (value) {
    _period=value;
    notifyListeners();
  }

}


