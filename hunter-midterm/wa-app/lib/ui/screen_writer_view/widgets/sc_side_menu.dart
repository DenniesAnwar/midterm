import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/models/option_item_model.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_menu_items.dart';
import 'package:wa_app/utills/colors.dart';

class ScreenWriterSideMenu extends StatefulWidget {
  const ScreenWriterSideMenu({
    Key? key,
  }) : super(key: key);
  @override
  _ScreenWriterSideMenuState createState() => _ScreenWriterSideMenuState();
}

class _ScreenWriterSideMenuState extends State<ScreenWriterSideMenu> {
  late ScreenWriterProvider _dashboardProvider;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _dashboardProvider =
        Provider.of<ScreenWriterProvider>(context, listen: false);

    super.initState();
  }

  double heightSize = 0.0;
  double widthSize = 0.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    heightSize = SizeConfig.heightMultiplier;
    widthSize = SizeConfig.widthMultiplier;
    return Container(
      width: SizeConfig.screenWidth < 1400
          ? SizeConfig.screenWidth < 1100
              ? 100
              : 220
          : 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        children: [
          if (SizeConfig.screenWidth > 1100)
            Padding(
              padding: EdgeInsets.symmetric(vertical: heightSize * 2.389),
              child: Image(
                image: const AssetImage('assets/icons/wo_accelerator.png'),
                height: heightSize * 8,
                width: widthSize * 15,
              ),
            ),
          Expanded(
              child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _dashboardProvider.isScreenWriter
                        ? ScreenWriterViewSideMenuOptions
                            .screenWriterSideMenuButtons.length
                        : ScreenWriterViewSideMenuOptions
                            .nonScreenWriterSideMenuButtons.length,
                    itemBuilder: (context, index) {
                      Options item = _dashboardProvider.isScreenWriter
                          ? ScreenWriterViewSideMenuOptions
                              .screenWriterSideMenuButtons[index]
                          : ScreenWriterViewSideMenuOptions
                              .nonScreenWriterSideMenuButtons[index];
                      return Consumer<ScreenWriterProvider>(
                        builder: (_, dashProvider, __) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenWidth < 1100
                                    ? heightSize * 1.00625
                                    : heightSize * 0.943),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth < 1100
                                    ? SizeConfig.screenWidth <= 960
                                        ? 30
                                        : widthSize * 2.425
                                    : widthSize * 0.867,
                                vertical: SizeConfig.screenWidth < 1100
                                    ? heightSize * 2.60625
                                    : heightSize * 1.643),
                            decoration: BoxDecoration(
                              color: _dashboardProvider.activeWidgetIndex ==
                                      item.index
                                  ? kPrimaryColor
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                _dashboardProvider.activeWidget =
                                    item.loadWidget;
                                _dashboardProvider.activeWidgetIndex =
                                    item.index;
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidth > 1100
                                            ? widthSize * 0.78
                                            : 10,
                                        right: SizeConfig.screenWidth < 1100
                                            ? widthSize * 0.78
                                            : 0,
                                        top: SizeConfig.screenWidth > 1100
                                            ? 8
                                            : 0,
                                        bottom: SizeConfig.screenWidth > 1100
                                            ? 8
                                            : 0),
                                    child: Image(
                                      color: _dashboardProvider
                                                  .activeWidgetIndex ==
                                              item.index
                                          ? Colors.white
                                          : Colors.black54,
                                      image: AssetImage(item.iconPath),
                                      height: SizeConfig.screenWidth < 1400
                                          ? 20
                                          : 23.83,
                                      width: SizeConfig.screenWidth < 1400
                                          ? 20
                                          : 23.83,
                                    ),
                                  ),
                                  if (SizeConfig.screenWidth > 1100)
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            item.title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Open Sans',
                                              color: _dashboardProvider
                                                          .activeWidgetIndex ==
                                                      item.index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize:
                                                  SizeConfig.screenWidth > 1590
                                                      ? heightSize * 1.494
                                                      : 13,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.8,
                                              height: 1.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
