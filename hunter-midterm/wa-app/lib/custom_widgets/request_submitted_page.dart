// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/routes.dart';

class RequestSubmittedPage extends StatelessWidget {
  const RequestSubmittedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 850,
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Your Submission request is under processing. We will inform you when processed.',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth > 1400 ? 28 : 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _loadBackToHome(context),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

_loadBackToHome(BuildContext context) => InkWell(
      child: Buttons.customPrimaryButton(
        onPressed: () {
          Navigator.of(context).pop();
          context.beamToNamed(Routes.login);
        },
        title: 'Logout',
        fontWeight: FontWeight.w500,
        buttonHeight:  SizeConfig.screenWidth > 1400 ? 42 : 35,
        buttonWidth:  SizeConfig.screenWidth > 1400 ? 130 : 100,
        buttonColor: Colors.red,
        textColor: Colors.white,
        fontSize: SizeConfig.screenWidth > 1400 ? 22 : 14,
      ),
    );
