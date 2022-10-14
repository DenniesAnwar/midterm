import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/marketplace_status.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/my_current_status.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/profile_detail_view.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class ScDashboard extends StatefulWidget {
  const ScDashboard({Key? key}) : super(key: key);

  @override
  _ScDashboardState createState() => _ScDashboardState();
}

class _ScDashboardState extends State<ScDashboard> {
  Size size = const Size(0.0, 0.0);
  double heightSize = 0.0;
  double widthSize = 0.0;
  bool showMarketPlaceStatus = false;
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    SizeConfig().init(MediaQuery.of(context).size);

    heightSize = size.height / 100;
    widthSize = size.width / 100;

    return Scaffold(
      body: Consumer<ScreenWriterProvider>(builder: (_, writerProvider, __) {
        return Row(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SingleChildScrollView(
                  controller: _verticalController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthSize * 2.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<UserProvider>(builder: (_, userProvider, __) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 20, bottom: heightSize * 6.497),
                            child: Text(
                              '👋 Hey, ${userProvider.userInfo!.name ?? 'Error'}',
                              style: TextStyle(
                                  color: kOrangeColor,
                                  fontSize:
                                      SizeConfig.screenHeight > 680 ? 24 : 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        }),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: heightSize * 4.182,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: heightSize * 4.182),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'My Current Scripts',
                                      style: kProfileNameTextStyle.copyWith(
                                          //fontSize: SizeConfig.screenWidth > 580 ? heightSize*1.643:10,
                                          fontSize:
                                              SizeConfig.screenWidth < 1400
                                                  ? 15
                                                  : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        'See all',
                                        style: kProfileNameTextStyle.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth < 1410
                                                    ? 12
                                                    : 14,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _loadCurrentScriptsWidget(),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: heightSize * 1.120,
                                    bottom: heightSize * 0.373),
                                child: size.width < 720
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          MyCurrentStatus(),
                                          const MyMarketPlaceStatus(),
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: MyCurrentStatus(size: size),
                                          ),
                                          const Expanded(
                                            flex: 3,
                                            child: MyMarketPlaceStatus(),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            size.width > 800 ? const ProfileDetailView() : Container(),
          ],
        );
      }),
    );
  }

  Widget _loadCurrentScriptsWidget() => SizedBox(
        height: heightSize * 32.72,
        child: Consumer<ScScriptProvider>(builder: (_, provider, __) {
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: ListView.builder(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                itemCount: provider.scripts.length,
                itemBuilder: (context, index) {
                  DataModel item = provider.scripts[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: ScriptDocument(
                      scriptDataModel: item,
                    ),
                  );
                }),
          );
        }),
      );
}
