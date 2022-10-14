import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/styles.dart';

class ScNotificationsSettings extends StatefulWidget {
  const ScNotificationsSettings({Key? key}) : super(key: key);

  @override
  _ScNotificationsSettingsState createState() =>
      _ScNotificationsSettingsState();
}

class _ScNotificationsSettingsState extends State<ScNotificationsSettings> {
  final ScrollController _scrollController = ScrollController();
  double hPadding = 0.0;
  bool _passwordChange = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    hPadding = SizeConfig.screenWidth < 820
        ? SizeConfig.widthMultiplier * 3.125
        : SizeConfig.widthMultiplier * 7.125;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth < 1500 ? 35 : 62.0),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 690),
                    child: _loadContentRow(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight > 700
                      ? SizeConfig.screenHeight * 0.12
                      : 73,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: hPadding,
                      right: 30,
                    ),
                    child: Buttons.customPrimaryButton(
                      onPressed: () {},
                      title: 'Save changes',
                      buttonHeight: SizeConfig.screenHeight < 680 ? 40 : 50,
                      buttonWidth: 162,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      borderRoundness: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 7.269,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadContentRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth < 820
              ? SizeConfig.widthMultiplier * 3.125
              : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenWidth < 820
                    ? SizeConfig.heightMultiplier * 3.125
                    : 0),
            child: Text('Notifications',
                overflow: TextOverflow.ellipsis,
                style: kDashWidgetBigTitleBlackStyle.copyWith(
                    fontSize: SizeConfig.screenHeight > 680
                        ? SizeConfig.heightMultiplier * 3.136
                        : 21,
                    fontWeight: FontWeight.w900)),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 2.315,
                bottom: SizeConfig.heightMultiplier * 0.746),
            child: Text(
              'Type of notifications',
              overflow: TextOverflow.ellipsis,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                  fontSize: SizeConfig.screenHeight > 680
                      ? SizeConfig.heightMultiplier * 2.166
                      : 17,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            'Choose type of notifications you want to receive',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenHeight > 680
                    ? SizeConfig.heightMultiplier * 1.243
                    : 13.34,
                fontWeight: FontWeight.w500,
                color: Colors.black45),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 6.422,
                bottom: SizeConfig.heightMultiplier * 1.222),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier * 0.820),
                  child: Checkbox(
                      value: _passwordChange,
                      onChanged: (val) {
                        setState(() {
                          _passwordChange = !_passwordChange;
                        });
                      }),
                ),
                Text(
                  'Password Change',
                  overflow: TextOverflow.ellipsis,
                  style: kDashWidgetBigTitleBlackStyle.copyWith(
                      fontSize: SizeConfig.screenHeight > 680
                          ? SizeConfig.heightMultiplier * 2
                          : 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
