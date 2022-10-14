// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/models/me_response.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/producer_provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/routes.dart';

class Helpers {
  static Future<void> redirectUser(
      {required BuildContext context,
      bool isRegistering = false,
      required User user
      //required SharedPreferences preferences

      }) async {
    UserProvider uProvider = Provider.of<UserProvider>(context, listen: false);
    uProvider.user = user;
    uProvider.authenticated = true;

    MeResponse? meResponse = await getUserData(context);
    if (meResponse != null) {
      String token = await user.getIdToken();

      final box = GetStorage();
      box.write(tokenKey, token);

      //-------------------------------- project initial flow code ------------------------------
      projectInitialFlowCode(
          userInfo: meResponse, context: context, isRegistering: isRegistering);
    }
  }

  static Future<MeResponse?> getUserData(BuildContext context) async {
    MeResponse? resposne;

    UserProvider uProvider = Provider.of<UserProvider>(context, listen: false);
    uProvider.user;

    await uProvider.getUserInfo().then((userInfo) async {
      if (userInfo!.accountType == null) {
        resposne = userInfo;
        return resposne;
      }

      if (Provider.of<ProducerProvider>(context, listen: false).isProducer) {
        await Provider.of<ScScriptProvider>(context, listen: false)
            .getUserMarketplaceScripts()
            .then((value) {
          // Provider.of<ScreenWriterProvider>(context, listen: false)
          //     .getCurrentStatusData(context);
          resposne = userInfo;
        }).catchError((error) {
          ShowSnackBar.showSnackBar(
              context: context, title: "Something went wrong!");
        });
      } else {
        await Provider.of<ScScriptProvider>(context, listen: false)
            .getUserScripts()
            .then((value) {
          // Provider.of<ScreenWriterProvider>(context, listen: false)
          //     .getCurrentStatusData(context);
          resposne = userInfo;
        }).catchError((error) {
          ShowSnackBar.showSnackBar(
              context: context, title: "Something went wrong!");
        });
      }
    });

    return resposne;
  }

  static void showAppDialog(
      {required BuildContext context,
      Widget? widget,
      bool dismissible = false}) {
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) {
          return Center(
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                //this right here
                child: StatefulBuilder(builder: (context, setState) {
                  SizeConfig().init(MediaQuery.of(context).size);
                  return widget ?? loadingWidget();
                })),
          );
        });
  }

  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  static Future<SharedPreferences> getPref() {
    return SharedPreferences.getInstance();
  }

  static Future<void> launchInWebViewWithJavaScript(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    )) {
      throw 'Could not launch $url';
    }
  }

  static projectInitialFlowCode(
      {required MeResponse userInfo,
      required bool isRegistering,
      required BuildContext context}) {
    // for the first time account is created

    if (isRegistering || userInfo.accountType == null) {
      Navigator.of(context).pop();
      context.beamToNamed(Routes.selectedSideScreen);
    } else {
      if (userInfo.accountType == 'writer_non_program') {
        Provider.of<ScreenWriterProvider>(context, listen: false)
            .isScreenWriter = false;
        context.beamToNamed(Routes.screenWriterViewMainScreen);
      } else if ((userInfo.verified == null || userInfo.verified == false)) {
        switch (getUserType(userInfo.accountType!)) {
          case 1:
            context.beamToNamed(Routes.screenWriterApplicationForm);
            break;
          case 2:
          case 3:
            context.beamToNamed(Routes.producerApplicationForm);
            break;
        }
      } else if (userInfo.verified == true) {
        switch (getUserType(userInfo.accountType!)) {
          case 1:
            context.beamToNamed(Routes.screenWriterViewMainScreen);
            break;
          case 2:
          case 3:
            Provider.of<ProducerProvider>(context, listen: false).isProducer =
                true;
            context.beamToNamed(Routes.producerViewMainScreen);
            break;
        }
      }
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

int getUserType(String value) {
  int _userType = -1;
  switch (value) {
    case 'writer_in_program':
      _userType = 1;
      break;
    case 'producer_guild_member':
      _userType = 2;
      break;
    case 'producer_non_guild_member':
      _userType = 3;
      break;
  }
  return _userType;
}

String getScriptStatus(Application? application) {
  if (application == null ||
      (application.acceptedAt == null && application.rejectedAt == null)) {
    return ScriptStatus.inReview;
  } else if (application.acceptedAt != null) {
    return ScriptStatus.approved;
  } else {
    return ScriptStatus.rejected;
  }
}
