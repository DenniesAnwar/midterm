import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/producer_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/producer_screens/pro_script_purchase_detail_view.dart';
import 'package:wa_app/ui/screen_writer_view/screens/sc_script_detail_page.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

class ScriptDocument extends StatefulWidget {
  final DataModel scriptDataModel;
  final bool isOrderScript;

  const ScriptDocument({
    Key? key,
    required this.scriptDataModel,
    this.isOrderScript = false,
    documentModel,
  }) : super(key: key);

  @override
  _ScriptDocumentState createState() => _ScriptDocumentState();
}

class _ScriptDocumentState extends State<ScriptDocument> {
  late Size _outerContainerSize;

  late Size _bottomContainerSize;
  late Size _pageSize;
  late DateTime scriptTimeStamp;
  late String timeString;
  late double _outerContainerHeight;

  @override
  void initState() {
    // scriptTimeStamp = DateTime.parse(widget.scriptDataModel.createdAt!);
    //
    // if(scriptTimeStamp.day < DateTime.now().day){
    //
    //   timeString = '${DateTime.now().day-scriptTimeStamp.day} days ago.';
    // }else if(scriptTimeStamp.hour < 24 && scriptTimeStamp.hour < DateTime.now().hour){
    //   timeString = '${DateTime.now().hour-scriptTimeStamp.hour} hours ago.';
    // }else if(scriptTimeStamp.minute < 60 && scriptTimeStamp.minute < DateTime.now().minute){
    //   timeString = '${scriptTimeStamp.minute-scriptTimeStamp.minute} minutes ago.';
    // }else{
    timeString = 'Just Now';
    // }
    _outerContainerHeight = widget.isOrderScript == true
        ? 528
        : widget.isOrderScript == true
            ? 495
            : 350;
    // widget.isFullMember = widget.isPremier==true?true:false;
    _outerContainerSize = Size(250, _outerContainerHeight);
    _pageSize =
        Size(_outerContainerSize.width - 60, _outerContainerSize.height - 80);
    _bottomContainerSize =
        Size(_outerContainerSize.width, _outerContainerSize.height - 290);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _outerContainerSize.height,
      width: _outerContainerSize.width,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kScriptPaneBackgroundColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.white),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 30,
            bottom: _bottomContainerSize.height + 8,
            child: SizedBox(
              height: _pageSize.height,
              width: _pageSize.width,
              child: Image(
                image: const AssetImage(
                  "assets/icons/contract_doc.png",
                ),
                width: _pageSize.width,
                height: _pageSize.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 8,
            child: InkWell(
                onTap: () {
                  Provider.of<ScreenWriterProvider>(context, listen: false)
                          .activeWidget =
                      ScScriptDetailPage(scriptData: widget.scriptDataModel);
                },
                child: getScriptStatusText()),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Container(
              width: _bottomContainerSize.width,
              height: _bottomContainerSize.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9)),
                  border: Border.all(color: Colors.grey[200]!)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      widget.scriptDataModel.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kCardBottomDescriptionStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, left: 35),
                    child: Text(
                      'Uploaded. $timeString',
                      style: kCardBottomDescriptionStyle.copyWith(
                          fontSize: 8, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Visibility(
                    visible: widget.isOrderScript == true,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 3, bottom: 3, left: 35),
                      child: RichText(
                        text: TextSpan(
                            text: 'Wil expire ',
                            style: kCardBottomDescriptionStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: widget.scriptDataModel.willExpireIn,
                                style: kCardBottomDescriptionStyle.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isOrderScript == true,
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Divider(),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundImage:
                                  AssetImage('assets/images/girl.jpeg'),
                            ),
                            title: Text(
                              'Joshua',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            subtitle: Text(
                              'example@gmail.com',
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isOrderScript == true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 3),
                      child: Buttons.customPrimaryButton(
                          title: 'Purchase',
                          onPressed: () {
                            Provider.of<ProducerProvider>(context,
                                    listen: false)
                                .prevWidget = Provider.of<ProducerProvider>(
                                    context,
                                    listen: false)
                                .activeWidget;
                            Provider.of<ProducerProvider>(context,
                                        listen: false)
                                    .activeWidget =
                                ScriptPurchaseDetailView(
                                    scriptData: widget.scriptDataModel);
                          },
                          buttonHeight: 32,
                          buttonWidth: _outerContainerSize.width - 20,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Visibility(
                    visible: widget.isOrderScript == true,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, bottom: 2, top: 4),
                      child: Buttons.customPrimaryButton(
                          title: '6 month renewel',
                          buttonWidth: _outerContainerSize.width - 20,
                          buttonColor: kGreenColor,
                          onPressed: () {},
                          buttonHeight: 32,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getScriptStatusText() {
    String status = getScriptStatus(widget.scriptDataModel.application);
    Color statusBgColor = kPrimaryColor;

    if (status == ScriptStatus.approved) {
      statusBgColor = kGreenColor;
    } else if (status == ScriptStatus.rejected) {
      statusBgColor = kRedColor;
    }
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: statusBgColor),
        child: Text(
          getScriptStatus(widget.scriptDataModel.application),
          style: const TextStyle(color: Colors.white),
        ));
  }
}
