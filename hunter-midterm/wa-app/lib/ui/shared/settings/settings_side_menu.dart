import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/settings_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/shared/settings/widgets/sc_settings_side_menu_options.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class SharedSettingsSideMenu extends StatefulWidget {
  const SharedSettingsSideMenu({Key? key}) : super(key: key);

  @override
  _SharedSettingsSideMenuState createState() => _SharedSettingsSideMenuState();
}

class _SharedSettingsSideMenuState extends State<SharedSettingsSideMenu> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: SizeConfig.screenWidth < 820 ? _smBody() : _lgBody(),
        ),
      ),
    );
  }

  Widget _smBody() {
    return Row(
      children: [
        ...List.generate(SharedSettingsOptions.dashBoardButtons.length,
            (index) {
          SettingsMenuItemModel item =
              SharedSettingsOptions.dashBoardButtons[index];
          return Consumer<SettingsProvider>(builder: (_, provider, __) {
            return InkWell(
                onTap: () {
                  provider.activeWidget = item.loadWidget;
                  provider.activeWidgetIndex = item.index;
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Icon(item.iconData,
                      color: item.index == provider.activeWidgetIndex
                          ? Colors.blue
                          : kIconColor,
                      size: 35),
                ));
          });
        }),
      ],
    );
  }

  Widget _lgBody() {
    return Column(
      children: [
        ...List.generate(SharedSettingsOptions.dashBoardButtons.length,
            (index) {
          SettingsMenuItemModel item =
              SharedSettingsOptions.dashBoardButtons[index];
          return Consumer<SettingsProvider>(builder: (_, provider, __) {
            return SettingMenuItemTile(
                isPressed:
                    item.index == provider.activeWidgetIndex ? true : false,
                leadingIcon: item.iconData,
                subtitle: item.subtitle,
                title: item.title,
                onPressed: () {
                  provider.activeWidget = item.loadWidget;
                  provider.activeWidgetIndex = item.index;
                });
          });
        }),
      ],
    );
  }
}

class SettingMenuItemTile extends StatelessWidget {
  const SettingMenuItemTile(
      {Key? key,
      required this.leadingIcon,
      this.subtitle,
      this.title,
      required this.isPressed,
      required this.onPressed})
      : super(key: key);
  final IconData leadingIcon;
  final String? title;
  final String? subtitle;
  final bool isPressed;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Padding(
          padding:
              EdgeInsets.only(top: SizeConfig.screenWidth < 1400 ? 12.5 : 25.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(leadingIcon,
                    color: isPressed ? Colors.blue : kIconColor, size: 35),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: isPressed ? Colors.blue : kIconColor, size: 25),
                title: Text(
                  title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: kProfileNameTextStyle.copyWith(
                    fontSize: SizeConfig.screenWidth < 1500 ? 14 : 19,
                  ),
                ),
                subtitle: Text(subtitle ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: kTextFieldHintStyle.copyWith(
                      fontSize: SizeConfig.screenWidth < 1500 ? 12 : 17,
                    )),
              ),
              SizedBox(
                height: SizeConfig.screenWidth < 1400 ? 12.5 : 25.0,
              ),
              const Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
