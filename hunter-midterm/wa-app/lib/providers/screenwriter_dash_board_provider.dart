import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wa_app/custom_widgets/log_out_dialog.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/init_retrofit.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_menu_items.dart';

class ScreenWriterProvider extends ChangeNotifier {
  int _activeWidgetIndex = 0;
  Widget _activeWidget =
      ScreenWriterViewSideMenuOptions.screenWriterSideMenuButtons[0].loadWidget;
  bool _isScreenWriter = true;

  bool get isScreenWriter => _isScreenWriter;
  set isScreenWriter(value) {
    _isScreenWriter = value;
    notifyListeners();
  }

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

  Future<dynamic> screenWriterApplicationRequest(
      BuildContext context, Map<String, dynamic> data) async {
    final client = InitRetrofit.apiService;

    await client!.uploadScreenWriterFormData(data).then((value) {
      showApplicationSuccessDialog(context: context, isRejected: false);
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
