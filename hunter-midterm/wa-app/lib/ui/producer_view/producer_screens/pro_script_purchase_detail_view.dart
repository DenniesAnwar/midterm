import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/producer_provider.dart';
import 'package:wa_app/providers/producer_script_purchase_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/dialog_boxs/choose_work_type_dialog.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/profile_info_widget.dart';
import 'package:wa_app/utills/styles.dart';

class ScriptPurchaseDetailView extends StatefulWidget {
  const ScriptPurchaseDetailView({Key? key,required this.scriptData}) : super(key: key);
  final DataModel? scriptData;
  @override
  _ScriptPurchaseDetailViewState createState() =>
      _ScriptPurchaseDetailViewState();
}

class _ScriptPurchaseDetailViewState extends State<ScriptPurchaseDetailView> {
  final bool _isScreenPlayUnlocked = false;
  final bool _isTreatmentUnlocked =
      false; // todo: these two booleans are only for testing we will remove it later

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          left: 46.0, top: SizeConfig.heightMultiplier * 4.456, right: 46),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileInfoWidget(
            isPremium: false,
            changePlan: () {},
            profileOnTapped: () {},
          ),
          Visibility(
            visible: !(_isScreenPlayUnlocked || _isTreatmentUnlocked),
            child: SizedBox(
              width: 90,
              child: InkWell(
                onTap: () {
                  Provider.of<ProducerProvider>(context, listen: false)
                      .activeWidget = Provider.of<ProducerProvider>(context, listen: false)
                      .prevWidget;
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/arrow-back.svg',
                      width: SizeConfig.screenWidth < 920 ? 16 : 21,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Back',
                      style: sSmallTitleTextStyle.copyWith(
                        fontSize: SizeConfig.screenWidth < 920 ? 13 : 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 7.02,
                left: SizeConfig.widthMultiplier * 2.5,
                right: SizeConfig.widthMultiplier * 2.5,
                bottom: SizeConfig.heightMultiplier * 2.554,
              ),
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadTitle(
                        title: widget.scriptData!.title??'',
                      ),
                      LoadTitleAndDescription(
                          subtitle:
                          widget.scriptData!.synopsis??'',
                          title: 'Synopsis : '),
                      LoadTitleAndDescription(
                          subtitle:
                          widget.scriptData!.logline??'',
                          title: 'Logline : '),
                       LoadTitleAndDescription(
                          subtitle:
                          widget.scriptData!.tagline??'',
                          title: 'Tagline : '),
                      LoadTitleAndScriptStatus(
                          title: 'Treatment : ',
                          onTapped: () {},
                          isUnlocked: _isTreatmentUnlocked),
                      LoadTitleAndScriptStatus(
                          title: 'Screenplay : ',
                          onTapped: () {},
                          isUnlocked: _isScreenPlayUnlocked),
                      Buttons.customPrimaryButton(
                          onPressed: () {
                            Provider.of<ProducerScriptPurchaseProvider>(context,listen: false).scriptId=widget.scriptData!.id;
                            chooseProWorkTypeDialog2Opt(context);
                          },
                          title: 'Purchase',
                          buttonWidth: 342,
                          buttonHeight: 73),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadTitle extends StatelessWidget {
  const LoadTitle(
      {Key? key, this.fontWeight = FontWeight.w700, required this.title})
      : super(key: key);
  final String title;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.heightMultiplier * 2.006,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: kDashWidgetBigTitleBlackStyle.copyWith(
          fontSize: SizeConfig.screenWidth < 920 ? 17 : 28,
          fontWeight: fontWeight,
          height: 1.6,
        ),
      ),
    );
  }
}

class LoadTitleAndDescription extends StatelessWidget {
  const LoadTitleAndDescription(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.heightMultiplier * 2.006,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadTitle(title: title, fontWeight: FontWeight.w600),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              subtitle,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenWidth < 920 ? 13 : 25,
                fontWeight: FontWeight.w300,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadTitleAndScriptStatus extends StatelessWidget {
  const LoadTitleAndScriptStatus(
      {Key? key,
      required this.title,
      required this.onTapped,
      required this.isUnlocked})
      : super(key: key);
  final String title;
  final Function onTapped;
  final bool isUnlocked;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.heightMultiplier * 2.006,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadTitle(title: title, fontWeight: FontWeight.w600),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 60,
            child: InkWell(
              onTap: () {
                onTapped();
              },
              child: !isUnlocked
                  ? const Icon(
                      Icons.lock_outline_rounded,
                      size: 35,
                      color: Colors.blue,
                    )
                  : SvgPicture.asset(
                      'assets/icons/pdf-document.svg',
                      width: 25,
                      height: SizeConfig.screenWidth < 920 ? 18.37 : 33.37,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
