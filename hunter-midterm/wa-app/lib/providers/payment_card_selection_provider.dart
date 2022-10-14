import 'package:flutter/cupertino.dart';
class PaymentCardSelectionProvider extends ChangeNotifier{
  int _activeCardIndex = 0;

  int get activeCardIndex => _activeCardIndex;
  set  activeCardIndex(int value){
    _activeCardIndex= value;
    notifyListeners();
  }
}