import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/init_retrofit.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_menu_items.dart';

class ProducerProvider extends ChangeNotifier {
  int _activeWidgetIndex = 0;
  bool _isProducer = false;
  bool get isProducer => _isProducer;
  set isProducer(value) {
    _isProducer = value;
    notifyListeners();
  }

  Widget _activeWidget =
      ProducerSideMenuOptions.producerSideMenuButtons[0].loadWidget;
  Widget _prevWidget =
      ProducerSideMenuOptions.producerSideMenuButtons[0].loadWidget;

  int get activeWidgetIndex => _activeWidgetIndex;
  set activeWidgetIndex(int value) {
    _activeWidgetIndex = value;
    notifyListeners();
  }

  Widget get activeWidget => _activeWidget;
  set activeWidget(Widget value) {
    _activeWidget = value;
    notifyListeners();
  }

  Widget get prevWidget => _prevWidget;
  set prevWidget(Widget value) {
    _prevWidget = value;
    notifyListeners();
  }

  Future<void> producerApplicationRequest(
      BuildContext context, Map<String, dynamic> data) async {
    final client = InitRetrofit.apiService;

    await client!.uploadProducerFormData(data).then((value) {
      Navigator.of(context).maybePop();
      ShowSnackBar.showSnackBar(
          context: context, title: 'form is uploaded successfully');
    }).catchError((onError) {
      Navigator.of(context).maybePop();
      ShowSnackBar.showSnackBar(
          context: context, title: 'Something went wrong!');
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }
}
