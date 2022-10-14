import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/drop_menu_filter_widget.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/upload_script_dialog.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';

class ScScriptPage extends StatefulWidget {
  const ScScriptPage({Key? key}) : super(key: key);

  @override
  _ScScriptPageState createState() => _ScScriptPageState();
}

class _ScScriptPageState extends State<ScScriptPage> {
  String dropdownValue = 'All';

  List<String> nonScreenWriterList = [
    'All',
    ScriptStatus.approved,
    ScriptStatus.inReview,
    ScriptStatus.rejected
  ];

  List<String> screenWriterList = [
    'All',
    'In review',
    'Draft',
    'Locked-in option room',
    'Submitted'
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
              const SizedBox(height: 30),
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
          "My Script",
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
    ScreenWriterProvider _provider =
        Provider.of<ScreenWriterProvider>(context, listen: false);
    List<String> items =
        _provider.isScreenWriter ? screenWriterList : nonScreenWriterList;

    return Row(
      children: [
        FilterDropDownMenu(
          optionList: items,
          onChangedFunction: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              Provider.of<ScScriptProvider>(context, listen: false)
                  .filterScripts(scriptType: dropdownValue);
            });
          },
        ),
        const SizedBox(
          width: 16,
        ),
        InkWell(
          onTap: () {
            showUploadScriptDialog(context,
                isFromNonScriptWriter: _provider.isScreenWriter);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: kPrimaryColor),
            child: const Text(
              "Upload",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
