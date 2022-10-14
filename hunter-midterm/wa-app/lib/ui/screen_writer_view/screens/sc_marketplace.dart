import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/drop_menu_filter_widget.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/utills/colors.dart';

class ScMarketplacePage extends StatefulWidget {
  const ScMarketplacePage({Key? key}) : super(key: key);

  @override
  _ScMarketplacePageState createState() => _ScMarketplacePageState();
}

class _ScMarketplacePageState extends State<ScMarketplacePage> {
  String dropdownValue = 'All';

  List<String> screenWriterList = [
    'All',
    'Scripts in Marketplace',
    'Purchased Scripts'
  ];

  Size? screenSize;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    SizeConfig().init(MediaQuery.of(context).size);

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _loadTitleRow(),
              SizedBox(height: screenSize!.height * .08),
              _loadDropDownRow(),
              SizedBox(height: screenSize!.height * .08),
              _loadScripts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadScripts() {
    return Consumer<ScScriptProvider>(builder: (_, provider, __) {
      return Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          ...provider.filteredScripts.map((e) => Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: ScriptDocument(
                  scriptDataModel: e,
                ),
              ))
        ],
      );
    });
  }

  Widget _loadTitleRow() {
    return Row(
      children: [
        Text(
          "My Marketplace Scripts",
          style: TextStyle(
              fontSize: SizeConfig.screenWidth < 1500 ? 22 : 38,
              fontWeight: FontWeight.w700,
              color: kOrangeColor),
        ),
        const Spacer(),
        Icon(
          Icons.add_alert_rounded,
          size: SizeConfig.screenWidth < 1500 ? 22 : 25,
        ),
        SizedBox(
            width: SizeConfig.screenWidth > 1400 ? 280 : 200,
            child: const ProfileButton()),
      ],
    );
  }

  Widget _loadDropDownRow() {
    return Row(
      children: [
        Consumer<ScreenWriterProvider>(builder: (_, writerProvider, __) {
          List<String> items = screenWriterList;
          return FilterDropDownMenu(
            optionList: items,
            onChangedFunction: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                Provider.of<ScScriptProvider>(context, listen: false)
                    .filterScripts(scriptType: dropdownValue);
              });
            },
          );
        }),
      ],
    );
  }
}
