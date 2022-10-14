import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/producer_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

showPurchaseScriptPackageDialog(BuildContext context, formKey) {
  return showDialog(
      context: context,
      builder: (context) {
        return const PurchaseScriptPackageDialog(
          packageTitle: 'Screenplay',
          packageAmount: 50,
        );
      });
}

class PurchaseScriptPackageDialog extends StatefulWidget {
  const PurchaseScriptPackageDialog(
      {Key? key, required this.packageAmount, required this.packageTitle})
      : super(key: key);
  final String packageTitle;
  final double packageAmount;
  @override
  _PurchaseScriptPackageDialogState createState() =>
      _PurchaseScriptPackageDialogState();
}

class _PurchaseScriptPackageDialogState
    extends State<PurchaseScriptPackageDialog> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Center(
      child: Card(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 680,
            maxHeight: 650,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier * 0.391,
                      bottom: SizeConfig.heightMultiplier * 2.857,
                      top: SizeConfig.heightMultiplier * 0.746,
                    ),
                    child: const CloseButton(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier * 1.679,
                    right: SizeConfig.widthMultiplier * 1.679,
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
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 0.246,
                            bottom: SizeConfig.heightMultiplier * 2.746),
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
                        width: 720,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 1.792,
                              bottom: SizeConfig.heightMultiplier * 1.792,
                              right: 18),
                          margin: EdgeInsets.only(
                              left: 42,
                              right: 42,
                              top: SizeConfig.heightMultiplier * 0.915,
                              bottom: SizeConfig.heightMultiplier * 1.296),
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.packageTitle,
                                overflow: TextOverflow.ellipsis,
                                style: kDashWidgetBigTitleBlackStyle.copyWith(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '\$ ${widget.packageAmount}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.5,
                                  letterSpacing: 0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.heightMultiplier * 1.867,
                            top: SizeConfig.heightMultiplier * 0.916),
                        child: Text(
                          'Payment Details',
                          style: kProfileNameTextStyle.copyWith(fontSize: 16),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 720,
                        ),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeConfig.screenWidth < 620 ? 14.0 : 0),
                              child: TextFieldWithLabelAndLeadingImage(
                                imagePath: 'assets/icons/google-icon.png',
                                mapKey: 'card_number',
                                onSaved: _onSaved,
                                hint: 'Card Number',
                                boxWidth:
                                    SizeConfig.screenWidth < 620 ? 400 : 250,
                              ),
                            ),
                            SizedBox(width:SizeConfig.screenWidth > 620 ?  20:0,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: CVCTextFieldWithLabel(
                                boxWidth:
                                    SizeConfig.screenWidth < 620 ? 400 : 250,
                                onSaved: _onSaved,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeConfig.screenWidth < 620 ? 14.0 : 0),
                              child: CustomTextFieldWithLabel(
                                onSaved: _onSaved,
                                mapKey: 'card_holder_name',
                                boxWidth:
                                    SizeConfig.screenWidth < 620 ? 400 : 250,
                                hint: 'Card Holder Name',
                                leadingIcon: Icons.person,
                              ),
                            ),
                            SizedBox(width:SizeConfig.screenWidth > 620 ?  20:0,),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeConfig.screenWidth < 620 ? 14.0 : 0),
                              child: CustomTextFieldWithLabel(
                                onSaved: _onSaved,
                                mapKey: 'email',
                                boxWidth:
                                    SizeConfig.screenWidth < 620 ? 400 : 250,
                                hint: 'Email',
                                leadingIcon: Icons.email_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2.166),
                        child: Buttons.customPrimaryButton(
                            onPressed: () {},
                            borderRoundness:
                                SizeConfig.heightMultiplier * 1.676,
                            buttonHeight: 48,
                            fontSize: 16,
                            buttonWidth: 200,
                            fontWeight: FontWeight.w600,
                            title: 'Continue'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.416,
                            bottom: SizeConfig.heightMultiplier * 1.416),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Cancel',
                            style: kProfileNameTextStyle.copyWith(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                        ),
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
