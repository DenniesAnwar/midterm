import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/drop_menu_filter_widget.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/order/order_scripts.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/profile_info_widget.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen(
      {Key? key, required this.isPremier, required this.isFullMember})
      : super(key: key);
  final bool isPremier;
  // considered to be one who has purchased the full package
  final bool isFullMember;

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;
  final ScrollController _ordersController = ScrollController();
  String filterScriptValue = 'Draft';

  final List<String> _optionList = const [
    'Draft',
    'Revise',
    'Review',
    'Rated',
    'Optioned',
  ];

  List<Widget> _fullPlanTabBody = [];

  @override
  void initState() {
    _tabBarController = TabController(
        length: widget.isFullMember
            ? _fullPlanTabs.length
            : widget.isPremier
                ? _premiumPlanTabs.length
                : _basicPlanTabs.length,
        vsync: this);
    _premiumTabBody = [
      _loadTabChild(),
      _loadTabChild(),
      _loadTabChild(),
    ];
    _fullPlanTabBody = [
      const OrderScripts(),
      _loadTabChild(),
      _loadTabChild(),
      _loadTabChild(),
    ];

    _basicTabBody = [
      _loadTabChild(),
      _loadTabChild(),
    ];
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
                  optionList: _optionList,
                  onChangedFunction: (val) {
                    filterScriptValue = val;
                    // setState(() {
                    //   Provider.of<ScScriptProvider>(context,listen: false).filterScripts(scriptType: filterScriptValue);
                    //
                    // });
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                        maxHeight: 250,
                      ),
                      child: DefaultTabController(
                        length: widget.isFullMember
                            ? _fullPlanTabs.length
                            : widget.isPremier
                                ? _premiumPlanTabs.length
                                : _basicPlanTabs.length,
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
                          tabs: widget.isFullMember
                              ? _fullPlanTabs
                              : widget.isPremier
                                  ? _premiumPlanTabs
                                  : _basicPlanTabs,
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
                      flex: 3,
                      child: TabBarView(
                        controller: _tabBarController,
                        children: widget.isFullMember
                            ? _fullPlanTabBody
                            : widget.isPremier
                                ? _premiumTabBody.toList()
                                : _basicTabBody,
                      ),
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

  List<Widget> _premiumTabBody = [];

  List<Widget> _basicTabBody = [];
  List<Tab> _basicPlanTabs = [];
  List<Tab> _premiumPlanTabs = [];
  List<Tab> _fullPlanTabs = [];

  _MyOrdersScreenState() {
    _basicPlanTabs = [
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/screenplay.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Scripts'),
      ),
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/medical-report.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Treatment'),
      ),
    ];

    _premiumPlanTabs = [
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/screenplay.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Scripts'),
      ),
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/medical-report.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Treatment'),
      ),
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/hand-shake.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Commisioned Work'),
      ),
    ];

    _fullPlanTabs = [
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/screenplay.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Scripts'),
      ),
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/medical-report.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Treatment'),
      ),
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/hand-shake.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Commisioned Work'),
      ),
      Tab(
        child: SizeConfig.screenWidth < 920
            ? SvgPicture.asset(
                'assets/icons/edit_icon.svg',
                height: 30,
                width: 40,
                color: kPrimaryColor,
              )
            : const Text('Expire Scripts'),
      ),
    ];
  }

  Widget _loadTabChild() => Consumer<ScScriptProvider>(
        builder: (_, provider, __) {
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SingleChildScrollView(
              controller: _ordersController,
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
