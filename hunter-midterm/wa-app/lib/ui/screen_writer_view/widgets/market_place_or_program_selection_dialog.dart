// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/routes.dart';
import 'package:wa_app/utills/styles.dart';

class WriterSelectionPage extends StatefulWidget {
  const WriterSelectionPage({Key? key}) : super(key: key);

  @override
  _WriterSelectionPageState createState() => _WriterSelectionPageState();
}

class _WriterSelectionPageState extends State<WriterSelectionPage> {
  late UserProvider _uProvider;
  bool _isLoading = true;
  @override
  void initState() {
    _uProvider = Provider.of<UserProvider>(context, listen: false);
    Future.microtask(() async {
      if (_uProvider.userInfo == null) {
        var resp = await _uProvider.getUserInfo();
        if (resp != null) {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _isLoading
              ? loadingWidget()
              : Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                        ),
                      ),
                      width: 650,
                      height: 500,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 180,
                            width: 400,
                            child: Stack(
                              children: [
                                const Positioned(
                                  bottom: 80,
                                  left: 180,
                                  child: Image(
                                    height: 55,
                                    width: 240,
                                    image: AssetImage(
                                      'assets/images/img_logo.png',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: SizeConfig.screenWidth < 760 ? 40 : 90,
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Welcome To ',
                                      children: [
                                        TextSpan(
                                            text: 'WoAccelerator',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 36,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Text(
                                  'You Have Selected Screenwriter',
                                  style: kDashWidgetBigTitleBlackStyle.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Positioned(
                                  bottom: 1,
                                  right: 65,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/icons/trace_line.png'),
                                    height: 30,
                                  ),
                                ),
                                Positioned(
                                  bottom: 23,
                                  child: Text(
                                    'Now, choose a path that suits your needs.',
                                    style:
                                        kDashWidgetBigTitleBlackStyle.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: kBorderColor, width: 1.2)),
                                  ),
                                  child: Column(
                                    children: [
                                      Buttons.customPrimaryButton(
                                          onPressed: () async {
                                            _uProvider.accountType =
                                                "writer_non_program";
                                            await _updateCurrentUser(
                                                redirectUser: () {
                                                  _redirectNonScreenWriter(
                                                      context);
                                                },
                                                data: {
                                                  "account_type":
                                                      "writer_non_program",
                                                },
                                                context: context);
                                          },
                                          buttonColor: const Color(0xff3A5659),
                                          fontSize: 14,
                                          buttonWidth: 190,
                                          buttonHeight: 45,
                                          fontWeight: FontWeight.w500,
                                          borderRoundness: 3,
                                          title: 'Submit to marketplace'),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          marketPlace,
                                          textAlign: TextAlign.justify,
                                          style: kTextFieldHintStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    children: [
                                      Buttons.customPrimaryButton(
                                          onPressed: () {
                                            _uProvider.accountType =
                                                "writer_in_program";
                                            context.beamToNamed(Routes
                                                .screenWriterApplicationForm);
                                          },
                                          buttonColor: kPrimaryColor,
                                          fontSize: 14,
                                          buttonWidth: 190,
                                          buttonHeight: 45,
                                          fontWeight: FontWeight.w500,
                                          borderRoundness: 3,
                                          title: 'Apply for the program'),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          applyProgram,
                                          textAlign: TextAlign.justify,
                                          style: kTextFieldHintStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        launch(
                            "https://woaccelerator.com/courses-details.html");
                      },
                      child: Text(
                        "Check out our courses",
                        style: kMediumTextStyle.copyWith(
                            color: kLinkColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
        ),
      ),
    );
  }
}

void _redirectNonScreenWriter(BuildContext context) {
  Provider.of<ScreenWriterProvider>(context, listen: false).isScreenWriter =
      false;
  context.beamToNamed(Routes.screenWriterViewMainScreen);
}

Future<void> _updateCurrentUser({
  required BuildContext context,
  required Map<String, String> data,
  required Function redirectUser,
}) async {
  Helpers.showAppDialog(context: context);
  await Provider.of<UserProvider>(context, listen: false)
      .updateCurrentUser(data)
      .then((value) {
    Provider.of<ScScriptProvider>(context, listen: false)
        .getUploadDialogData(context);
    redirectUser();
  });
  Navigator.of(context).maybePop();
}
