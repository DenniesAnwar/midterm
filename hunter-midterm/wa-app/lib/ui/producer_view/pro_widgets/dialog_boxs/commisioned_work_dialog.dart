import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/producer_widgets.dart';
import 'package:wa_app/ui/shared/settings/widgets/email_confirmation_textfield.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

showCommissionedWorkDialog(BuildContext context, formKey) {
  return showDialog(
      context: context,
      builder: (context) {
        return CommissionedWorkFormDialog(
          formKey: formKey,
        );
      });
}

class CommissionedWorkFormDialog extends StatefulWidget {
  const CommissionedWorkFormDialog({Key? key, required this.formKey})
      : super(key: key);
  final GlobalKey formKey;

  @override
  _CommissionedWorkFormDialogState createState() =>
      _CommissionedWorkFormDialogState();
}

class _CommissionedWorkFormDialogState
    extends State<CommissionedWorkFormDialog> {
  final Map<String, dynamic> _commissionedData = {};

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 650,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.heightMultiplier * 1.493),
          ),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 0.391, top: SizeConfig.heightMultiplier*0.746),
                      child: const CloseButton(),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(
                        right: 34.61, left: 34.61, top: SizeConfig.heightMultiplier*0.746),
                    child: Column(
                      children: [
                        _loadBigTitle(),
                        _loadDescription(),
                        SizedBox(
                          width: 450,
                          child: Form(
                            key: widget.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier*0.746),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex:2,
                                        child: TextFieldWithLabel(
                                          onSaved: _onSaved,
                                          mapKey: 'first_name',
                                          boxWidth: 214,
                                          hint: 'First Name',
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        flex: 2,
                                        child: TextFieldWithLabel(
                                          onSaved: _onSaved,
                                          mapKey: 'last_name',
                                          boxWidth: 214,
                                          hint: 'Last Name',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.25),
                                  child: TextFieldWithLabel(
                                      onSaved: _onSaved,
                                      mapKey: 'phone_number',
                                      boxWidth: 450,
                                      keyBoardType: TextInputType.phone,
                                      hint: 'Phone Number'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.25),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 450,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.25),
                                          child: Text(
                                            'Email',
                                            style: kProfileNameTextStyle
                                                .copyWith(fontSize: 13),
                                          ),
                                        ),
                                        EmailConfirmationTextField(
                                          onSaved: _onSaved,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.25),
                                  child: TextFieldWithLabel(
                                      onSaved: _onSaved,
                                      mapKey: 'type',
                                      boxWidth: 450,
                                      hint: 'Type'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.25),
                                  child: TextFieldWithLabel(
                                      onSaved: _onSaved,
                                      maxLines: 6,
                                      mapKey: 'description',
                                      boxWidth: 450,
                                      hint: 'Description'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24.25, bottom: 10.25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Buttons.customPrimaryButton(
                                        buttonWidth: 200,
                                        buttonHeight: 47,
                                        borderRoundness: 17,
                                        onPressed: () {},
                                        title: 'Cancel',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        textColor: kPrimaryColor,
                                        buttonColor: Colors.white,
                                      ),
                                      Buttons.customPrimaryButton(
                                          buttonWidth: 200,
                                          buttonHeight: 47,
                                          borderRoundness: 17,
                                          onPressed: () {},
                                          title: 'Send',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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

  _onSaved(String key, String value) {
    _commissionedData[key] = value;
  }
}

Widget _loadBigTitle() => Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Text(
        'Commissioned work',
        textAlign: TextAlign.center,
        style: kDashWidgetBigTitleBlackStyle.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          height: 1.6,
        ),
      ),
    );

Widget _loadDescription() => Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 14),
      child: Text(
        'Please fill in all the details below so that we can get in contact with you',
        textAlign: TextAlign.center,
        style: kDashWidgetBigTitleBlackStyle.copyWith(
          fontSize: 14,
          color: kGreyColor,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
      ),
    );
