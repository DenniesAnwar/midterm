import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/providers/producer_script_purchase_provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

import '../pro_general_widgets.dart';
import 'choose_screenplay_period.dart';

chooseProWorkTypeDialog3Options(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const ChooseProducerWorkTypeWith3Options();
      });
}

class ChooseProducerWorkTypeWith3Options extends StatefulWidget {
  const ChooseProducerWorkTypeWith3Options({Key? key}) : super(key: key);

  @override
  _ChooseProducerWorkTypeWith3OptionsState createState() => _ChooseProducerWorkTypeWith3OptionsState();
}

class _ChooseProducerWorkTypeWith3OptionsState extends State<ChooseProducerWorkTypeWith3Options> {
  final List<bool> _cards = [false, false, false];
  void onTapped(int index) {
    for (int i = 0; i < _cards.length; i++) {
      if (i == index) {
        _cards[index] = !_cards[index];
      } else {
        _cards[i] = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15, top: 10),
                      child: CloseButton(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34.61,right: 34.61,bottom: 70.61,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Text(
                            'Choose',
                            textAlign: TextAlign.center,
                            style: kDashWidgetBigTitleBlackStyle.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              height: 1.6,
                            ),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: ProducerWorkTypeWidget(
                                title: 'Comissioned Work',
                                isTapped: _cards[0],
                                onTapped: () {
                                  onTapped(0);
                                },
                                imagePath: 'assets/icons/hand-shake.svg', getStarted: (){},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: ProducerWorkTypeWidget(
                                getStarted: (){},
                                title: 'Treatment',
                                isTapped: _cards[1],
                                onTapped: () async{
                                  onTapped(1);
                                  await _checkoutForTreatment(context);
                                },
                                imagePath: 'assets/icons/medical-report.svg',
                              ),
                            ),
                            ProducerWorkTypeWidget(
                              getStarted: (){},
                              title: 'Screenplay',
                              isTapped: _cards[2],
                              onTapped: () {
                                onTapped(2);
                                _checkoutScreenPlay(context);
                              },
                              imagePath: 'assets/icons/screenplay.svg',
                            ),
                          ],
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
    );
  }
}


class ProducerWorkTypeWidget extends StatelessWidget {
  const ProducerWorkTypeWidget(
      {Key? key,
      required this.isTapped,
      required this.title,
      required this.imagePath,
      required this.onTapped,
      required this.getStarted,
      })
      : super(key: key);
  final String title;
  final String imagePath;
  final Function onTapped;
  final Function getStarted;
  final bool isTapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 130,
        maxWidth: 130,
        maxHeight: 182,
        minHeight: 182,
      ),
      margin: const EdgeInsets.only(bottom: 24,),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
        border: Border.all(color: isTapped ? kPrimaryColor : Colors.transparent),
      ),
      child: InkWell(
        onTap: (){
          onTapped();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: isTapped,
                  child: tickMark(
                      icoBackgroundColor: kPrimaryColor,
                      icoSize: 9,
                      hSize: 12,
                      vSize: 12),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32, top: 10, bottom: 8, right: 32),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9),
                decoration: const BoxDecoration(
                  color: kLightPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SvgPicture.asset(
                  imagePath,
                  color: kPrimaryColor,
                  width: 15,
                  height: 59,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7, bottom: 9),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: kDashWidgetBigTitleBlackStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                ),
              ),
            ),
            Buttons.customPrimaryButton(
                onPressed: () {
                  getStarted();

                },
                title: 'Get Started',
                buttonHeight: 17,
                borderRoundness: 3,
                fontSize: 7,
                buttonWidth: 70),
          ],
        ),
      ),
    );
  }
}


chooseProWorkTypeDialog2Opt(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const ChooseProWorkTypeWith2Opt();
      });
}



class ChooseProWorkTypeWith2Opt extends StatefulWidget {
  const ChooseProWorkTypeWith2Opt({Key? key}) : super(key: key);

  @override
  _ChooseProWorkTypeWith2OptState createState() => _ChooseProWorkTypeWith2OptState();
}

class _ChooseProWorkTypeWith2OptState extends State<ChooseProWorkTypeWith2Opt> {
  final List<bool> _cards = [false, false];
  void onTapped(int index) {
    for (int i = 0; i < _cards.length; i++) {
      if (i == index) {
        _cards[index] = !_cards[index];
      } else {
        _cards[i] = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 560,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15, top: 10),
                      child: CloseButton(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34.61,right: 34.61,bottom: 70.61,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(
                            '03 min : 00 sec',
                            textAlign: TextAlign.center,
                            style: kDashWidgetBigTitleBlackStyle.copyWith(
                              color: kGreyColor,
                              fontSize: 13,
                              height: 1.6,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Text(
                            'Choose',
                            textAlign: TextAlign.center,
                            style: kDashWidgetBigTitleBlackStyle.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              height: 1.6,
                            ),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: ProducerWorkTypeWidget(
                                title: 'Screenplay',
                                isTapped: _cards[0],
                                onTapped: () {
                                  onTapped(0);
                                  Navigator.of(context).maybePop();
                                  _checkoutScreenPlay(context);
                                },
                                imagePath: 'assets/icons/screenplay.svg', getStarted: (){},
                              ),
                            ),
                            ProducerWorkTypeWidget(
                              getStarted: (){},
                              title: 'Treatment',
                              isTapped: _cards[1],
                              onTapped: () async{
                                onTapped(1);
                                await _checkoutForTreatment(context);
                              },
                              imagePath: 'assets/icons/medical-report.svg',
                            ),
                          ],
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
    );
  }
}

_checkoutScreenPlay(BuildContext context){
  Navigator.of(context).pop();
  Provider.of<ProducerScriptPurchaseProvider>(context,listen: false).checkout = ScriptPurchaseType.screenPlay;
  showScreenPlayPeriodDialog(context);
}

_checkoutForTreatment(BuildContext context)async{


  var data = {
    'checkout':'treatment',
    'success_url':Provider.of<ProducerScriptPurchaseProvider>(context,listen: false).successUrl,
    'cancel_url':Provider.of<ProducerScriptPurchaseProvider>(context,listen: false).cancelUrl,
    'period':ScriptPurchaseType.sixMonthSubscriptions,
  };
  String scriptId = Provider.of<ProducerScriptPurchaseProvider>(context,listen: false).scriptId;

  Helpers.showAppDialog(context: context);
  await Provider.of<ScScriptProvider>(context,listen: false).marketPlaceCheckout(scriptId,data).then((value){
    if(value != null){
      Navigator.of(context).pop();
      Navigator.of(context).pop();
     Helpers.launchInWebViewWithJavaScript(value.checkoutUrl!);
    }else{
      Navigator.of(context).maybePop();
      ShowSnackBar.showSnackBar(context: context, title: 'Checkout Failed!!!');
    }
  });
}