import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/models/sc_script_info_model.dart';
import 'package:wa_app/models/sc_script_review_model.dart';
import 'package:wa_app/network/models/script_detail_model.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/screens/sc_script_page.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_document.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_script_review.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/upload_files_button.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/app_dummy_data.dart';
import 'package:wa_app/utills/colors.dart';

// ignore: must_be_immutable
class ScScriptDetailPage extends StatefulWidget {
  DataModel? scriptData;

  ScScriptDetailPage({Key? key, required this.scriptData})
      : super(key: key);

  @override
  _ScScriptDetailPageState createState() => _ScScriptDetailPageState();
}

class _ScScriptDetailPageState extends State<ScScriptDetailPage> {
  double vSpace = 20;
  double pointIndicatorRadius = 250;
  late ScriptDetailModel _detailModel;
  double points = 0;
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  final List<ScScriptInfoModel> _scriptPoints = scriptInfoList();
  final List<ScScriptReviewModle> _scriptReviews = [];
  late Widget _treatmentWidgets;
  late Widget _screenPlayWidgets;

  bool _isDetailPage = true;

  final Map<String, dynamic> _updateScriptData = {};
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = true;

  @override
  void initState() {
    Future.microtask(() {
      onTapped(context);
      _treatmentWidgets = _uploadTreatmentFile();
      _screenPlayWidgets = _uploadScreenPlayFile();
    });
    super.initState();
  }

  onTapped(BuildContext context) async {
    await Provider.of<ScScriptProvider>(context, listen: false)
        .getScriptById(widget.scriptData!.id!)
        .then((value) {
      _detailModel = value;
      _getPointsData();
      setState(() {
        _isLoading = false;
      });
    });
  }

  _getPointsData() {
    widget.scriptData!.title = _detailModel.title;
    widget.scriptData!.logline = _detailModel.logline;
    widget.scriptData!.tagline = _detailModel.tagline;
    widget.scriptData!.synopsis = _detailModel.synopsis;
    for (var rating in _detailModel.scriptRatings!) {
      _scriptPoints[0].number += rating.character!;
      _scriptPoints[1].number += rating.conflict!;
      _scriptPoints[2].number += rating.dialogue!;
      _scriptPoints[3].number += rating.logic!;
      _scriptPoints[4].number += rating.originality!;
      _scriptPoints[5].number += rating.pacing!;
      _scriptPoints[6].number += rating.premise!;
      _scriptPoints[7].number += rating.structure!;
      _scriptPoints[8].number += rating.tone!;

      var total = rating.tone! +
          rating.structure! +
          rating.premise! +
          rating.pacing! +
          rating.originality! +
          rating.logic! +
          rating.dialogue! +
          rating.conflict! +
          rating.character!;

      _scriptReviews.add(ScScriptReviewModle(
          points: total.toDouble(), review: rating.feedback!));
    }
    for (var element in _scriptPoints) {
      points += element.number;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return _isLoading
        ? Center(
      child: loadingWidget(),
    )
        : Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: SingleChildScrollView(
          controller: _verticalController,
          child: Column(
            children: [
              _loadProfileRow(),
              const SizedBox(height: 25),
              _loadPageMainContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadProfileRow() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Provider.of<ScreenWriterProvider>(context, listen: false)
                .activeWidget = const ScScriptPage();
          },
          child: Row(
            children: const [
              Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
              Text(
                "Back",
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        Icon(
          Icons.add_alert_rounded,
          size: SizeConfig.screenWidth < 1500 ? 22 : 25,
        ),
        SizedBox(width: SizeConfig.screenWidth>1400?280:200,child: const ProfileButton()),
      ],
    );
  }

  Widget _loadPageMainContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SizeConfig.screenWidth < 920 ? _smScreenBody() : _lgScreenBody(),
    );
  }

  Widget _smScreenBody() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: _pageLeftContent()),
      const SizedBox(
        height: 30,
      ),
      Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[200]!),
              left: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: _pageRightContent()),
    ]);
  }

  Widget _lgScreenBody() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          flex: 2,
          child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: _pageLeftContent())),
      Expanded(
          flex: 3,
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                  left: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: _pageRightContent())),
    ]);
  }

  Widget _pageLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Script Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        ScriptDocument(scriptDataModel: widget.scriptData!),
        Consumer<ScreenWriterProvider>(builder: (_, writerProvider, __) {
          return Visibility(
              visible: writerProvider.isScreenWriter,
              child: _customButton(
                  kPrimaryColor, Colors.white, "Submit (2/3)", () {}));
        })
      ],
    );
  }

  Widget _pageRightContent() {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: SingleChildScrollView(
        controller: _horizontalController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25, bottom: 20),
              child: SizeConfig.screenWidth < 920 ? _smBody() : _lgBody(),
            ),
            if (_isDetailPage)
              _documentDetailModule()
            else
              _documentUpdateModule()
          ],
        ),
      ),
    );
  }

  Widget _smBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.scriptData!.title!,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        _saveButton(),
      ],
    );
  }

  _saveButton() =>
      Consumer<ScreenWriterProvider>(builder: (_, writerProvider, __) {
        return Visibility(
          visible: writerProvider.isScreenWriter,
          child: _customButton(
            kPrimaryColor,
            Colors.white,
            _isDetailPage ? "Edit Script" : "Save",
            _isDetailPage
                ? () {
              setState(() {
                _isDetailPage = !_isDetailPage;
              });
            }
                : () async {
              setState(() {
                _isDetailPage = !_isDetailPage;
              });
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await _updateScript(context);
              }
            },
          ),
        );
      });

  _updateScript(BuildContext context) async {

    Map<String,dynamic> infoMap = _infoMap();
    Map<String,dynamic> fileMap = _filesMap();




    Helpers.showAppDialog(context: context, widget: loadingWidget());
    await Provider.of<ScScriptProvider>(context, listen: false)
        .updateScripts(context, infoMap,widget.scriptData!,_detailModel.id.toString()).then((value) {
      widget.scriptData = value;
      Navigator.of(context).maybePop();
      setState(() {

      });
    });
    await Provider.of<ScScriptProvider>(context, listen: false).uploadScriptFiles(context, fileMap, _detailModel.id.toString());
  }

  Map<String, dynamic> _filesMap() {
    Map<String, dynamic> data = {};
    data['treatment'] = _updateScriptData['treatment'];
    data['screenplay'] = _updateScriptData['screenplay'];
    return data;
  }

  Widget _lgBody() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.scriptData!.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _saveButton()),
      ],
    );
  }

  Widget _documentDetailModule() {
    return Column(
      children: [
        _documentDescriptionModule(),
        Divider(
          thickness: 2,
          color: Colors.grey[200]!,
        ),
        _scriptInfoModule(),
        const SizedBox(
          height: 20,
        ),
        _loadPointsIndicatorModule(),
        _loadReviewModule()
      ],
    );
  }

  Widget _documentUpdateModule() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _loadTitle("Synopsis:"),
            space(vSpace: vSpace),
            TextFields.withoutDecoration(
                initialValue: _detailModel.synopsis!,
                maxLine: 3,
                mapKey: "synopsis",
                errorMessage: "Synopsis Required",
                onSaved: onSaved),
            space(vSpace: vSpace),
            _loadTitle("Tagline:"),
            space(vSpace: vSpace),
            TextFields.withoutDecoration(
                initialValue: _detailModel.tagline!,
                maxLine: 3,
                mapKey: "tagline",
                errorMessage: "Tagline Required",
                onSaved: onSaved),
            space(vSpace: vSpace),
            _loadTitle("Logline:"),
            space(vSpace: vSpace),
            TextFields.withoutDecoration(
                initialValue: _detailModel.logline!,
                maxLine: 3,
                mapKey: "logline",
                errorMessage: "Required",
                onSaved: onSaved),
            space(vSpace: vSpace + 10),
            SizedBox(
              width: 420,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  _loadLgTitle("Treatement:"),
                  space(vSpace: 10),
                  _treatmentWidgets,
                ],
              ),
            ),
            space(vSpace: vSpace),
            SizedBox(
              width: 420,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  _loadLgTitle("Screenplay:"),
                  space(vSpace: 10),
                  _screenPlayWidgets,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget space({double vSpace = 8, double hSpace = 8}) {
    return SizedBox(width: hSpace, height: vSpace);
  }

  Widget _customButton(
      Color bgColor, Color txtColor, String text, GestureTapCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 130,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: bgColor),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: txtColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _loadTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Widget _loadLgTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget _loadTextContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontWeight: FontWeight.w400),
    );
  }

  Widget _documentDescriptionModule() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space(vSpace: vSpace),
          _loadTitle("*Synopsis:"),
          space(vSpace: vSpace),
          _loadTextContent(widget.scriptData!.synopsis!),
          space(vSpace: vSpace),
          _loadTitle("*Log line:"),
          space(vSpace: vSpace),
          _loadTextContent(widget.scriptData!.logline!),
          space(vSpace: vSpace),
          _loadTitle("*Tag line:"),
          space(vSpace: vSpace),
          _loadTextContent(widget.scriptData!.tagline!),
          space(vSpace: vSpace),
          Row(
            children: [
              _loadTitle("*Treatment:"),
              const Icon(
                Icons.picture_as_pdf,
                color: kOrangeColor,
              )
            ],
          ),
          space(vSpace: vSpace),
          Row(
            children: [
              _loadTitle("*ScreenPlay:"),
              const Icon(
                Icons.picture_as_pdf,
                color: kOrangeColor,
              )
            ],
          ),
          space(vSpace: vSpace + 20),
        ],
      ),
    );
  }

  Widget _scriptInfoModule() {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              "Script Info",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _scriptPoints.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: SizeConfig.screenWidth < 1100 ? 1.57 : 2.5),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(_scriptPoints[index].title),
                    ),
                    Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]!)),
                        child: Center(
                            child: Text(
                              "${_scriptPoints[index].number}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenWidth < 920 ? 10 : 15),
                            ))),
                  ],
                );
              },
            ),
          ],
        ));
  }

  _loadPointsIndicatorModule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: pointIndicatorRadius,
            height: pointIndicatorRadius,
            child: Stack(
              children: [
                Container(
                  width: pointIndicatorRadius,
                  height: pointIndicatorRadius,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, .5), // changes position of shadow
                    ),
                  ], color: Colors.white, shape: BoxShape.circle),
                ),
                CircularPercentIndicator(
                  radius: pointIndicatorRadius,
                  lineWidth: 50.0,
                  percent: points / 100,
                  startAngle: 0,
                  progressColor: kPrimaryColor,
                  backgroundColor: Colors.white,
                  reverse: true,
                  circularStrokeCap: CircularStrokeCap.butt,
                ),
                Center(
                  child: Container(
                    width: pointIndicatorRadius - 40,
                    height: pointIndicatorRadius - 40,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: .5,
                        blurRadius: .5,
                        offset: Offset(0, .5), // changes position of shadow
                      ),
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                        child: Text(
                          "${points}pt",
                          style: const TextStyle(fontSize: 50),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text(
            "Solid",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  onSaved(String key, String value) {
    _updateScriptData[key] = value;
  }

  Widget _loadReviewModule() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 25, bottom: 20),
      child: Column(
        children: [..._scriptReviews.map((e) => ScScriptReview(e))],
      ),
    );
  }

  _uploadTreatmentFile() => UploadFilesButtons(
    uploadFile: (File file) {
      _updateScriptData['treatment'] = file;
    },
    title: 'Treatment',
  );

  _uploadScreenPlayFile() => UploadFilesButtons(
    uploadFile: (File file) {
      _updateScriptData['screenplay'] = file;
    },
    title: 'Screenplay',
  );

  Map<String, dynamic> _infoMap() {
    Map<String,dynamic> data = {};
    data['title'] = _detailModel.title;
    data['pages'] = _detailModel.pages;
    data['budget'] = _detailModel.budget;
    data['timeline'] = _detailModel.timeline;
    data['where'] = _detailModel.where;
    data['content_rating_id'] = _detailModel.contentRatingId;
    data['genres'] = _detailModel.genres;
    data['synopsis'] = _updateScriptData['synopsis'];
    data['logline'] = _updateScriptData['logline'];
    data['tagline'] = _updateScriptData['tagline'];

    return data;
  }


}


