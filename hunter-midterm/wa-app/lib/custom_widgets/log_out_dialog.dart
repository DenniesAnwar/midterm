// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_general_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/routes.dart';
import 'package:wa_app/utills/styles.dart';

showApplicationSuccessDialog(
    {required BuildContext context, required bool isRejected}) {
  SizeConfig().init(MediaQuery.of(context).size);

  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Card(
            child: Container(
              height: 420,
              width: 800,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Center(
                            child: tickMark(
                                hSize: 42.25, vSize: 42.25, icoSize: 35),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            iconSize: 22,
                            icon: const Icon(
                              Icons.close,
                              color: kIconColor,
                              size: 22,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      isRejected
                          ? 'Submission Rejected'
                          : 'Submission Successful',
                      style: kProfileNameTextStyle.copyWith(
                        color: isRejected ? Colors.red : kGreenColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    if (isRejected)
                      const Text(
                        'Your Submission request is rejected',
                        textAlign: TextAlign.center,
                      )
                    else
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "DO I QUALIFY FOR A PRODUCER  MEMBERSHIP?",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Our membership is currently limited to industry professionals, primary producers, and financiers. Also, you don\'t have to be a Union member to be a part of our WoAccelerator Producer membership. We only approve and give membership to those who can materially advance a writer\'s career.',
                            textAlign: TextAlign.center,
                            style: TextStyle(height: 2),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text:
                                      'After applying to be a part of our membership, we may ask to schedule an interview personally handled by our team. Expect to receive a notification about your application within a few days, and if you do not hear back from us in that time, feel free to',
                                  style: TextStyle(height: 2),
                                ),
                                TextSpan(
                                  style: const TextStyle(
                                      fontSize: 16,
                                      height: 2,
                                      color: kPrimaryColor),
                                  text: ' contact us!',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => launch(
                                          "https://woaccelerator.com/contact.html",
                                          webOnlyWindowName: '_self',
                                        ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    _loadBackToHome(context),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

_loadBackToHome(BuildContext context) => InkWell(
      onTap: () async {
        launch(
          "https://woaccelerator.com",
          webOnlyWindowName: '_self',
        );
        // context.beamToNamed(Routes.producerApplicationForm);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: Container(
        width: 300,
        height: 40,
        decoration: BoxDecoration(
            color: gradientColor, borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Text(
            "Go back to website",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: 16),
          ),
        ),
      ),
    );
