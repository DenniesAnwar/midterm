import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/constants.dart';

class ScCurrentStatusModel {
  String title;
  double percentValue;

  // todo: only used for testing later we will made it dynamic
  String endValueTitle;
  ScCurrentStatusModel(
      {required this.title,
      required this.endValueTitle,
      required this.percentValue});
}

class ScCurrentStatusInfoList {
  void getStatusInfo(BuildContext context) {
    ScreenWriterProvider writerProvider =
        Provider.of<ScreenWriterProvider>(context, listen: false);
    ScScriptProvider scriptProvider =
        Provider.of<ScScriptProvider>(context, listen: false);
    List items = writerProvider.isScreenWriter ? screenWriter : nonScreenWriter;
    int totalNoOfScripts = scriptProvider.scripts.length;
    for (ScCurrentStatusModel item in items) {
      int outOfNo = calculateEndValue(scriptProvider, item.title);
      item.endValueTitle = "$outOfNo/$totalNoOfScripts";
      item.percentValue = (outOfNo > 0 && 0 < totalNoOfScripts)
          ? (outOfNo / totalNoOfScripts)
          : 0;
    }
  }

  int calculateEndValue(ScScriptProvider provider, String status) {
    var totalScripts = provider.scripts;
    int outNo = 0;
    for (var script in totalScripts) {
      if (status == getScriptStatus(script.application)) {
        outNo++;
      }
    }

    return outNo;
  }

  static List<ScCurrentStatusModel> screenWriter = [
    ScCurrentStatusModel(
      title: 'Draft',
      endValueTitle: '2/4',
      percentValue: 0.5,
    ),
    ScCurrentStatusModel(
      title: 'Submitted',
      endValueTitle: '0/4',
      percentValue: 0.0,
    ),
    ScCurrentStatusModel(
      title: 'In Review',
      endValueTitle: '1/4',
      percentValue: 0.2,
    ),
    ScCurrentStatusModel(
      title: 'Locked',
      endValueTitle: '0/4',
      percentValue: 0.0,
    ),
  ];

  static List nonScreenWriter = [
    ScCurrentStatusModel(
      title: ScriptStatus.rejected,
      endValueTitle: '2/4',
      percentValue: 0.5,
    ),
    ScCurrentStatusModel(
      title: ScriptStatus.approved,
      endValueTitle: '0/4',
      percentValue: 0.0,
    ),
    ScCurrentStatusModel(
      title: ScriptStatus.inReview,
      endValueTitle: '1/4',
      percentValue: 0.2,
    ),
  ];
}
