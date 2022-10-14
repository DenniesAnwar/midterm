import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/producer_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

showMembershipPlanPaymentWithCreditCard(BuildContext context, formKey) {
  return showDialog(
      context: context,
      builder: (context) {
        return const MembershipPlanPaymentWithCreditCard();
      });
}

class MembershipPlanPaymentWithCreditCard extends StatefulWidget {
  const MembershipPlanPaymentWithCreditCard({Key? key}) : super(key: key);

  @override
  _MembershipPlanPaymentWithCreditCardState createState() =>
      _MembershipPlanPaymentWithCreditCardState();
}

class _MembershipPlanPaymentWithCreditCardState
    extends State<MembershipPlanPaymentWithCreditCard> {
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return Center(
      child: Card(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 820,
          ),
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
                      bottom: SizeConfig.heightMultiplier * 0.746
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
                        padding: EdgeInsets.only(
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
                          padding: EdgeInsets.only(
                              left: 18,
                              top: SizeConfig.heightMultiplier * 4.792,
                              bottom: SizeConfig.heightMultiplier * 4.792),
                          margin: EdgeInsets.only(
                              left: 42,
                              right: 42,
                              top: SizeConfig.heightMultiplier * 0.915,
                              bottom: SizeConfig.heightMultiplier * 1.312),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  SizeConfig.heightMultiplier * 1.120),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              SizedBox(
                                width: 450,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      textBaseline: TextBaseline.ideographic,
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
                                            style: kTextFieldHintStyle.copyWith(
                                                textBaseline:
                                                    TextBaseline.ideographic,
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
                          style: kProfileNameTextStyle.copyWith(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.screenWidth < 920 ? 20 : 0),
                              child: TextFieldWithLabelAndLeadingImage(
                                imagePath: 'assets/icons/credit_card-icon.png',
                                mapKey: 'card_number',
                                onSaved: _onSaved,
                                hint: 'Card Number',
                                boxWidth:
                                SizeConfig.screenWidth < 920 ? 550:250,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CVCTextFieldWithLabel(
                                boxWidth:
                                    SizeConfig.screenWidth < 920 ? 550:250,
                                onSaved: _onSaved,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeConfig.screenWidth < 920 ? 20 : 0),
                              child: CustomTextFieldWithLabel(
                                onSaved: _onSaved,
                                mapKey: 'card_holder_name',
                                boxWidth:
                                    SizeConfig.screenWidth < 920 ? 550:250,
                                hint: 'Card Holder Name',
                                leadingIcon: Icons.person,
                              ),
                            ),
                            CustomTextFieldWithLabel(
                              onSaved: _onSaved,
                              mapKey: 'email',
                              boxWidth:
                                  SizeConfig.screenWidth < 920 ? 550:250,
                              hint: 'Email',
                              leadingIcon: Icons.email_rounded,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0, bottom: 30),
                        child: Buttons.customPrimaryButton(
                            onPressed: () {},
                            borderRoundness: SizeConfig.heightMultiplier * 0.915,
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

  _onSaved(String key, String value) {}
}
