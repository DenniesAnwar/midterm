import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/drop_menu_filter_widget.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/profile_info_widget.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;

  final ScrollController _marketplaceController = ScrollController();
  @override
  void initState() {
    _tabBarController = TabController(length: 2, vsync: this);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              left: 46.0, top: SizeConfig.heightMultiplier * 4.933, right: 46),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: SizeConfig.screenHeight > 350,
                child: ProfileInfoAndGreetingWidget(
                  changePlan: () {},
                  profileOnTapped: () {},
                  greetingMsg: 'Welcome to Wo Marketplace',
                  isPremium: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 4.033,
                    bottom: SizeConfig.heightMultiplier * 3.136),
                child: FilterDropDownMenu(
                  optionList: const [
                    'Draft',
                    'Revise',
                    'Review',
                    'Rated',
                    'Optioned',
                  ],
                  onChangedFunction: (val) {
                    // Provider.of<ScScriptProvider>(context,listen: false).filterScripts(scriptType: val);
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 400,
                      child: DefaultTabController(
                        length: 2,
                        child: TabBar(
                          indicatorColor: kPrimaryColor,
                          labelColor: kPrimaryColor,
                          unselectedLabelColor: kMediumGreyColor,
                          indicatorWeight: 5,
                          unselectedLabelStyle: kProfileNameTextStyle.copyWith(
                              color: kMediumGreyColor,
                              fontSize:
                                  SizeConfig.widthMultiplier < 720 ? 14 : 18),
                          labelStyle: kProfileNameTextStyle.copyWith(
                              color: kPrimaryColor,
                              fontSize:
                                  SizeConfig.widthMultiplier < 720 ? 14 : 18),
                          controller: _tabBarController,
                          tabs: const [
                            Tab(
                              child: Text('General Available'),
                            ),
                            Tab(
                              child: Text('First Look'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizeConfig.screenHeight > 450
                        ? Column(
                            children: const [
                              SizedBox(
                                height: 15,
                              ),
                              Divider(),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        : const Spacer(),
                    Expanded(
                      child:
                          TabBarView(controller: _tabBarController, children: [
                        _loadTabChild(),
                        _loadTabChild(),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadTabChild() => Consumer<ScScriptProvider>(
        builder: (_, provider, __) {
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SingleChildScrollView(
              controller: _marketplaceController,
              child: Wrap(
                children: [
                  ...List.generate(provider.filteredScripts.length, (index) {
                    DataModel model = provider.filteredScripts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 31.0),
                      child: ScriptDocument(
                        scriptDataModel: model,
                        isOrderScript: true,
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      );
}
