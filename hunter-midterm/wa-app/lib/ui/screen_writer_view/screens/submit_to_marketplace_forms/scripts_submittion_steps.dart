import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/providers/payment_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

showScriptPaymentStepsDialog(BuildContext context) {
  return Helpers.showAppDialog(
      context: context, widget: const ScriptPaymentSubmissionSteps());
}

class ScriptPaymentSubmissionSteps extends StatefulWidget {
  const ScriptPaymentSubmissionSteps({Key? key}) : super(key: key);

  @override
  _ScriptPaymentSubmissionStepsState createState() =>
      _ScriptPaymentSubmissionStepsState();
}

enum subscription { perMonth, perAnum }

class _ScriptPaymentSubmissionStepsState
    extends State<ScriptPaymentSubmissionSteps> {
  // double _topLgContainer = 0.0;
  // double _bottomLgContainer = 0.0;
  // double _middleLgContainer = 0.0;
  // double _allContainerHeights = 0.0;

  int _index = 0;

  bool isCheckBoxChecked = false;

  Map<String, dynamic> formData = {};
  Map<String, dynamic> subscriptionInfo = {};

  subscription _subscription = subscription.perMonth;



  String amount = '125';

  double dialogHeight = 470;
  double dialogWidth = 760;

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    subscriptionInfo['success_url'] = 'http://www.google.com/';
    subscriptionInfo['cancel_url'] = 'https://twitter.com/';
    subscriptionInfo['plan'] = Subscriptions.scWriterSixMonth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SizedBox(
      height: dialogHeight,
      width: dialogWidth,
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
          Positioned(top: 30, child: _loadForm(context)),
        ],
      ),
    );
  }

  Widget _loadForm(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    dialogWidth =
        MediaQuery.of(context).size.width < 550 ? SizeConfig.screenWidth : 680;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: MediaQuery.of(context).size.width < 550
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: dialogWidth,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Complete these ',
                  style: kMediumTextStyle,
                  children: [
                    TextSpan(
                      text: '2 Steps ',
                      style: kMediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    TextSpan(
                      text: 'In Order To Publish Your Script To The ',
                      style: kMediumTextStyle,
                    ),
                    TextSpan(
                      text: 'Marketplace',
                      style: kMediumTextStyle.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'All the steps are required',
              style: sSmallTitleTextStyle.copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: SizedBox(
              width: dialogWidth,
              height: dialogHeight - 100,
              child: Stepper(
                controlsBuilder: (context, callbacks) {
                  return _index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50.0, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Buttons.customPrimaryButton(
                                    buttonHeight: 40,
                                    onPressed: () {
                                      _stepContinue();
                                    },
                                    title: 'Continue',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      : Container();
                },
                currentStep: _index,
                onStepTapped: (int index) {
                  setState(() {
                    if (_index == 0 && !isCheckBoxChecked) {
                      ShowSnackBar.showSnackBar(
                          context: context,
                          title: 'Please accept terms & condition');
                      return;
                    }
                    _index = index;

                    // dialogWidth = _index == 0 ? 540 : 740;
                    dialogHeight = _index == 0 ? 420 : 530;
                  });
                },
                elevation: 0,
                type: MediaQuery.of(context).size.width > 560
                    ? StepperType.horizontal
                    : StepperType.vertical,
                steps: _getSteps(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _stepContinue() {
    bool isLast = _index == _getSteps().length - 1;
    if (isLast) {
      ShowSnackBar.showSnackBar(context: context, title: 'Completed');
    } else {
      setState(() {
        if (isCheckBoxChecked) {
          _index += 1;

          dialogWidth = _index == 0 ? 530 : 730;
          dialogHeight = _index == 0 ? 420 : 550;
        } else {
          ShowSnackBar.showSnackBar(
              context: context, title: 'Please accept terms & codition');
        }
      });
    }
  }

  _agreeToTermsModule({bool isRequired = true}) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            children: [
              SizedBox(
                width: 360,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                        value: isCheckBoxChecked,
                        onChanged: (val) {
                          setState(() {
                            isCheckBoxChecked = val!;
                            formData['agree_to_terms'] = isCheckBoxChecked;
                          });
                        }),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'I agree to ',
                          style: kMediumTextStyle.copyWith(
                              height: 1.3,
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                                text: 'terms & conditions',
                                style: kMediumTextStyle.copyWith(
                                    color: Colors.blueAccent,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                      child: Visibility(
                        visible: isRequired,
                        child: const Text(
                          '*',
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  List<Step> _getSteps() => [
        Step(
          isActive: _index >= 0,
          title: Text(
            'terms and conditions',
            style: kMediumTextStyle.copyWith(
                fontSize: 14, color: _index >= 0 ? Colors.blue : Colors.black),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms And Conditions',
                style: kMediumTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              _agreeToTermsModule(),
            ],
          ),
        ),
        Step(
          isActive: _index >= 1,
          title: Text(
            'Payment',
            style: kMediumTextStyle.copyWith(
                fontSize: 14, color: _index >= 1 ? Colors.blue : Colors.black),
          ),
          content: _paymentModule(context),
        ),
      ];

  _paymentModule(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: MediaQuery.of(context).size.width < 560
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 34,
            width: double.infinity,
            child: Stack(
              alignment: MediaQuery.of(context).size.width < 560
                  ? Alignment.centerLeft
                  : Alignment.topCenter,
              children: [
                Text(
                  'Choose your subscription',
                  style: kMediumTextStyle.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Positioned(
                  bottom: 1,
                  right: SizeConfig.screenWidth < 1100 ? 115 : 150,
                  child: const Image(
                    image: AssetImage('assets/icons/trace_line.png'),
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: dialogWidth,
            child: Wrap(
              crossAxisAlignment: MediaQuery.of(context).size.width < 560
                  ? WrapCrossAlignment.start
                  : WrapCrossAlignment.center,
              alignment: MediaQuery.of(context).size.width < 560
                  ? WrapAlignment.start
                  : WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: SizedBox(
                    width: 270,
                    child: SubscriptionPackage(
                      subtitle: '6 Month Subscription',
                      subscriptionGroupValue: _subscription,
                      onChanged: (value) {
                        setState(() {
                          _subscription = value!;
                          subscriptionInfo['plan'] =
                              Subscriptions.scWriterSixMonth;
                          amount = '125';
                        });
                      },
                      packageDuration: 'month',
                      subsPackageValue: subscription.perMonth,
                      amount: '125',
                    ),
                  ),
                ),
                Visibility(
                    visible: MediaQuery.of(context).size.width > 650,
                    child: const SizedBox(
                      width: 30,
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 10),
                  child: SizedBox(
                    width: 270,
                    child: SubscriptionPackage(
                      subtitle: 'Annually Subscription',
                      subscriptionGroupValue: _subscription,
                      onChanged: (value) {
                        setState(() {
                          _subscription = value!;
                          subscriptionInfo['plan'] =
                              Subscriptions.scWriterYearly;
                          amount = '199';
                        });
                      },
                      packageDuration: 'Annum',
                      subsPackageValue: subscription.perAnum,
                      amount: '199',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Consumer<PaymentProvider>(builder: (_, provider, __) {
            return provider.isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Buttons.customPrimaryButton(
                          title: 'Pay $amount USD',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Provider.of<PaymentProvider>(context,
                                      listen: false)
                                  .isLoading = true;
                              await Provider.of<PaymentProvider>(context,
                                      listen: false)
                                  .subscribePlan(subscriptionInfo)
                                  .then((value) {
                                Provider.of<PaymentProvider>(context,
                                        listen: false)
                                    .isLoading = false;
                              });
                            }
                          },
                          buttonWidth: 240,
                          buttonHeight: 50,
                          borderRoundness: 15,
                          fontWeight: FontWeight.normal,
                          buttonColor: kOrangeColor),
                    ],
                  );
          }),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }


}

class SubscriptionPackage extends StatefulWidget {
  const SubscriptionPackage(
      {Key? key,
      required this.subtitle,
      required this.amount,
      required this.onChanged,
      required this.subsPackageValue,
      required this.packageDuration,
      this.subscriptionGroupValue})
      : super(key: key);
  final String subtitle;
  final String amount;
  final String packageDuration;
  final subscription subsPackageValue;
  final Function(subscription? value) onChanged;
  final subscription? subscriptionGroupValue;
  @override
  _SubscriptionPackageState createState() => _SubscriptionPackageState();
}

class _SubscriptionPackageState extends State<SubscriptionPackage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(widget.subsPackageValue);
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.only(right: 60, top: 25, left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: widget.subscriptionGroupValue == widget.subsPackageValue
                  ? kLightOrangeColor
                  : Colors.white,
              width: 2.3),
          boxShadow: const [
            BoxShadow(
              color: kContainerShadowColor,
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(2, 3),
            )
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                    activeColor: kLightOrangeColor,
                    value: widget.subsPackageValue,
                    groupValue: widget.subscriptionGroupValue,
                    onChanged: (subscription? value) {
                      widget.onChanged(value!);
                    }),
                const SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(
                          '\$ ${widget.amount}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '/${widget.packageDuration}',
                          style: kTextFieldHintStyle.copyWith(
                            textBaseline: TextBaseline.ideographic,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Text(
                widget.subtitle,
                style: sSmallTitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PaymentFormCard extends StatelessWidget {
//   const PaymentFormCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 850,
//       height: 400,
//       padding: const EdgeInsets.only(top: 30),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: kContainerShadowColor,
//             spreadRadius: 1.4,
//             blurRadius: 1,
//             offset: Offset(2, 3),
//           )
//         ],
//         borderRadius: BorderRadius.all(
//           Radius.circular(15),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: const [
//                 Image(
//                   image:
//                       AssetImage('assets/icons/credit_card_grey_logo.png'),
//                   color: Colors.black,
//                   height: 25,
//                   width: 30,
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text('Pay with Card'),
//                 Spacer(),
//                 Image(
//                   image: AssetImage('assets/icons/paypal_logo.png'),
//                   height: 45,
//                   width: 40,
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Image(
//                   image: AssetImage('assets/icons/visa_logo.png'),
//                   height: 30,
//                   width: 40,
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Image(
//                   image: AssetImage('assets/icons/master_card_logo.png'),
//                   height: 30,
//                   width: 40,
//                 ),
//               ],
//             ),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 25.0),
//               child: Divider(),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: SizeConfig.screenWidth < 920 ? 20 : 0),
//               child: TextFieldWithLabelAndLeadingImage(
//                 title: 'Card Number',
//                 imagePath: 'assets/icons/credit_card_grey_logo.png',
//                 mapKey: 'card_number',
//                 onSaved: _onSaved,
//                 hint: 'Card Number',
//                 boxWidth: 800,
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         bottom: SizeConfig.screenWidth < 920 ? 20 : 0),
//                     child: TextFieldWithLabelAndLeadingImage(
//                       title: 'Expiration Date',
//                       imagePath: 'assets/icons/calendar_grey.png',
//                       mapKey: 'expiration_date',
//                       onSaved: _onSaved,
//                       hint: 'Expiration Date',
//                       boxWidth: SizeConfig.screenWidth < 920 ? 450 : 250,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 25,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         bottom: SizeConfig.screenWidth < 920 ? 20 : 0),
//                     child: TextFieldWithLabelAndLeadingImage(
//                       title: 'CVC Number',
//                       imagePath: 'assets/icons/lock.png',
//                       mapKey: 'cvc_number',
//                       onSaved: _onSaved,
//                       hint: 'CVC Number',
//                       boxWidth: SizeConfig.screenWidth < 920 ? 450 : 250,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Buttons.customPrimaryButton(
//                     title: 'Pay $amount USD',
//                     onPressed: () {},
//                     buttonWidth: 240,
//                     buttonHeight: 50,
//                     borderRoundness: 25,
//                     fontWeight: FontWeight.normal,
//                     buttonColor: kOrangeColor),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
