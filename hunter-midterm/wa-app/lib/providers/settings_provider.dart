import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/init_retrofit.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/settings/widgets/sc_settings_side_menu_options.dart';
class SettingsProvider extends ChangeNotifier{
  int _activeWidgetIndex = 0;
  Widget _activeWidget = SharedSettingsOptions.dashBoardButtons[0].loadWidget;

  int get activeWidgetIndex => _activeWidgetIndex;
  set  activeWidgetIndex(int value){
    _activeWidgetIndex= value;
    notifyListeners();
  }


  Widget get  activeWidget => _activeWidget;
  set  activeWidget(Widget value){
    _activeWidget = value;
    notifyListeners();
  }

  Future<void> updateActiveStatus(BuildContext context,Map<String,dynamic> data) async {
    final client = InitRetrofit.apiService;
    await client!.updateUserName(data).then((value) async {
      ShowSnackBar.showSnackBar(context: context, title: 'Status updated');
    }).catchError((onError) {
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