import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/settings_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/ui/shared/settings/settings_side_menu.dart';
import 'package:wa_app/utills/colors.dart';

class SharedSettings extends StatefulWidget {
  const SharedSettings({Key? key}) : super(key: key);

  @override
  _SharedSettingsState createState() => _SharedSettingsState();
}

class _SharedSettingsState extends State<SharedSettings> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenWidth < 1450?SizeConfig.heightMultiplier * 2.061:SizeConfig.heightMultiplier * 3.361,
                bottom: SizeConfig.screenWidth < 1450?SizeConfig.heightMultiplier * 8.361:SizeConfig.heightMultiplier * 12.361,
                left: SizeConfig.widthMultiplier * 1.328,
                right: SizeConfig.widthMultiplier * 1.328),
            child: _loadTitleRow(),
          ),
          Expanded(
            child: SizeConfig.screenWidth < 820 ? _smBody() : _lgBody(),
          ),
        ],
      ),
    );
  }

  _lgBody() {
    return Row(
      children: _bodyContents()
          .map((e) => Expanded(
                flex: e is Center ? 5 : 2,
                child: e,
              ))
          .toList(),
    );
  }

  _smBody() {
    return Column(
        children: _bodyContents().map((e) {
      if (e is Center) {
        return Expanded(
          child: e,
        );
      } else {
        return Container(
          height: 50,
          margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 0.746),
          child: e,
        );
      }
    }).toList());
  }

  List<Widget> _bodyContents() => [
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.grey[300]!),
                top: BorderSide(width: 1.0, color: Colors.grey[300]!),
              ),
            ),
            child: const SharedSettingsSideMenu()),
        Center(
          child: Consumer<SettingsProvider>(builder: (_, provider, __) {
            return provider.activeWidget;
          }),
        ),
      ];

  Widget _loadTitleRow() {
    return Row(
      children: [
        Text(
          "Settings",
          style: TextStyle(
              fontSize: SizeConfig.screenHeight > 680 ?SizeConfig.heightMultiplier * 2.857:22,
              fontWeight: FontWeight.w700,
              color: kOrangeColor),
        ),
        const Spacer(),
        Icon(
          Icons.add_alert_rounded,
          size: SizeConfig.screenHeight > 680 ?25:22,
        ),
        SizedBox(width: SizeConfig.screenWidth>1400?280:200,child: const ProfileButton()),
      ],
    );
  }
}
