import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/models/payment_card_model.dart';
import 'package:wa_app/providers/payment_card_selection_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/producer_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

showPaymentOptionsDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const PaymentTypeSelectionDialog();
      });
}

class PaymentTypeSelectionDialog extends StatefulWidget {
  const PaymentTypeSelectionDialog({Key? key}) : super(key: key);

  @override
  _PaymentTypeSelectionDialogState createState() => _PaymentTypeSelectionDialogState();
}

class _PaymentTypeSelectionDialogState extends State<PaymentTypeSelectionDialog> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Center(
      child: Card(
        child: SizedBox(
          width: 850,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 10,
                        bottom: SizeConfig.heightMultiplier * 2.166,
                        top: 10),
                    child: const CloseButton(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 43.61,
                    right: 43.61,
                    top: SizeConfig.heightMultiplier * 0.746,
                    bottom: SizeConfig.heightMultiplier * 0.746,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started today',
                        textAlign: TextAlign.center,
                        style: kDashWidgetBigTitleBlackStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.6,
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(
                          top: 3.0,
                          bottom: SizeConfig.heightMultiplier * 2.554,
                        ),
                        child: Text(
                          'Choose the right plan',
                          textAlign: TextAlign.center,
                          style: kDashWidgetBigTitleBlackStyle.copyWith(
                            fontSize: 15,
                            color: Colors.black26,
                            height: 1.6,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 700,
                        child: Container(
                          padding:EdgeInsets.only(
                            left: 18,
                            top: SizeConfig.heightMultiplier * 4.792,
                            bottom: SizeConfig.heightMultiplier * 4.792,
                          ),
                          margin:EdgeInsets.only(
                            left: 42,
                            right: 42,
                            top: SizeConfig.heightMultiplier * 0.915,
                            bottom: SizeConfig.heightMultiplier * 1.312,
                          ),
                          decoration:BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(SizeConfig.heightMultiplier * 1.120),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              SizedBox(
                                width: 450,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        'Premium Membership',
                                        overflow: TextOverflow.ellipsis,
                                        style: kDashWidgetBigTitleBlackStyle
                                            .copyWith(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                      textBaseline:
                                      TextBaseline.ideographic,
                                      children: [
                                        const SizedBox(
                                          width: 36,
                                          child: Text(
                                            '\$50',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.5,
                                                letterSpacing: 0,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'Month',
                                            style: kTextFieldHintStyle
                                                .copyWith(
                                                textBaseline:
                                                TextBaseline
                                                    .ideographic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                    SizeConfig.screenWidth < 920 ? 12 : 0),
                                child: Buttons.customPrimaryButton(
                                    textColor: kPrimaryColor,
                                    onPressed: () {},
                                    borderRoundness:SizeConfig.heightMultiplier*0.915,
                                    fontSize: 12,
                                    buttonHeight: 35,
                                    buttonWidth: 120,
                                    buttonColor: Colors.white,
                                    title: 'Change Plan'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.heightMultiplier * 1.792,
                          top: SizeConfig.heightMultiplier * 0.915,
                        ),
                        child: Text(
                          'Choose Payment Methods',
                          style:
                          kProfileNameTextStyle.copyWith(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            ...List.generate(
                                PaymentCardsTiles.paymentCardsData.length,
                                    (index) {
                                  PaymentCardModel item =
                                  PaymentCardsTiles.paymentCardsData[index];
                                  return Consumer<PaymentCardSelectionProvider>(
                                    builder: (_, provider, __) {
                                      return PaymentCardType(
                                        title: item.title,
                                        onPressed: () {
                                          provider.activeCardIndex = item.index;
                                        },
                                        imagePath: item.imagePath,
                                        isPressed: item.index ==
                                            provider.activeCardIndex
                                            ? true
                                            : false,
                                      );
                                    },
                                  );
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(top: SizeConfig.heightMultiplier * 2.091, bottom: SizeConfig.heightMultiplier * 2.566),
                        child: Buttons.customPrimaryButton(
                            onPressed: () {},
                            borderRoundness:  SizeConfig.heightMultiplier * 0.915,
                            fontSize: 16,
                            buttonWidth: 200,
                            fontWeight: FontWeight.w600,
                            title: 'Continue'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PaymentCardType extends StatelessWidget {
  const PaymentCardType({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.imagePath,
    required this.isPressed,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final Function onPressed;
  final bool isPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 90.8,
      child: loadPaymentMethodCard(
          leadingImage: imagePath,
          title: title,
          isPressed: isPressed,
          onTapFunction: () {
            onPressed();
          }),
    );
  }
}
