import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/providers/producer_script_purchase_provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_general_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

showScreenPlayPeriodDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const ChooseScreenPlayDialog();
      });
}

class ChooseScreenPlayDialog extends StatefulWidget {
  const ChooseScreenPlayDialog({Key? key}) : super(key: key);

  @override
  _ChooseScreenPlayDialogState createState() => _ChooseScreenPlayDialogState();
}

class _ChooseScreenPlayDialogState extends State<ChooseScreenPlayDialog> {
  final List<bool> _cards = [false, false];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 478,
          maxHeight: 520,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
              Radius.circular(SizeConfig.heightMultiplier * 1.493)),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 1.140,
                          top: SizeConfig.widthMultiplier * 0.746),
                      child: const CloseButton(),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(SizeConfig.heightMultiplier * 2.613),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 0.586,
                              bottom: SizeConfig.heightMultiplier * 0.586),
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
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 2.492),
                          child: Text(
                            'Choose Screenplay Period',
                            textAlign: TextAlign.center,
                            style: kDashWidgetBigTitleBlackStyle.copyWith(
                              fontSize: SizeConfig.screenWidth < 700 ? 22 : 32,
                              fontWeight: FontWeight.w700,
                              height: 1.6,
                            ),
                          ),
                        ),
                        ScreenplayPeriodPlan(
                          subtitle:
                              'lorem ipsum is simply dummy text of the printing',
                          title: '12 Months',
                          onTapped: () {
                            setState(() {
                              _cards[0] = !_cards[0];
                              _cards[1] = false;
                            });
                            Provider.of<ProducerScriptPurchaseProvider>(context,
                                    listen: false)
                                .period = ScriptPurchaseType.yearSubscription;
                          },
                          isTapped: _cards[0],
                        ),
                        ScreenplayPeriodPlan(
                          subtitle:
                              'lorem ipsum is simply dummy text of the printing',
                          title: '6 Months',
                          onTapped: () {
                            setState(() {
                              _cards[1] = !_cards[1];
                              _cards[0] = false;
                              Provider.of<ProducerScriptPurchaseProvider>(
                                          context,
                                          listen: false)
                                      .period =
                                  ScriptPurchaseType.sixMonthSubscriptions;
                            });
                          },
                          isTapped: _cards[1],
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2.613,
                        ),
                        Buttons.customPrimaryButton(
                            onPressed: () async {

                              await _checkoutForTreatment(context);
                            },
                            title: 'Purchase',
                            buttonHeight:
                                SizeConfig.screenWidth < 700 ? 44 : 55,
                            buttonWidth:
                                SizeConfig.screenWidth < 700 ? 200 : 400),
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

// 'lorem ipsum is simply dummy text of the printing'
class ScreenplayPeriodPlan extends StatelessWidget {
  const ScreenplayPeriodPlan(
      {Key? key,
      required this.isTapped,
      required this.title,
      required this.subtitle,
      required this.onTapped})
      : super(key: key);
  final String title;
  final String subtitle;
  final Function onTapped;
  final bool isTapped;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Container(
        constraints: const BoxConstraints(
          minWidth: 390,
          maxWidth: 390,
          maxHeight: 120,
          minHeight: 120,
        ),
        margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1.792),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.heightMultiplier * 1.493),
          ),
          border: Border.all(color: isTapped ? kPrimaryColor : kBorderColor),
        ),
        child: InkWell(
          onTap: () {
            onTapped();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 28,
                vertical: SizeConfig.screenWidth < 700 ? 14 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: kDashWidgetBigTitleBlackStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: kDashWidgetBigTitleBlackStyle.copyWith(
                          color: kGreyColor,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Visibility(
                  visible: isTapped,
                  child: tickMark(icoBackgroundColor: kPrimaryColor),
                ),
              ],
            ),
          ),
        ));
  }
}

 _checkoutForTreatment(BuildContext context) async {
  var data = {
    'checkout':
        Provider.of<ProducerScriptPurchaseProvider>(context, listen: false)
            .checkout,
    'success_url':
        Provider.of<ProducerScriptPurchaseProvider>(context, listen: false)
            .successUrl,
    'cancel_url':
        Provider.of<ProducerScriptPurchaseProvider>(context, listen: false)
            .cancelUrl,
    'period':
        Provider.of<ProducerScriptPurchaseProvider>(context, listen: false)
            .period,
  };
  String scriptId =
      Provider.of<ProducerScriptPurchaseProvider>(context, listen: false)
          .scriptId;

  Helpers.showAppDialog(context: context);
  await Provider.of<ScScriptProvider>(context, listen: false)
      .marketPlaceCheckout(scriptId, data)
      .then((value) {
    if (value != null) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Helpers.launchInWebViewWithJavaScript(value.checkoutUrl!);
    } else {
      Navigator.of(context).maybePop();
      ShowSnackBar.showSnackBar(context: context, title: 'Checkout Failed!!!');
    }
  });
}
