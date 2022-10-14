import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_general_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

Widget loadPaymentMethodCard(
        {required String leadingImage,
        required title,
        required bool isPressed,
        required onTapFunction}) =>
    GestureDetector(
      onTap: onTapFunction,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15, left: 25, right: 25, top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: isPressed ? kPrimaryColor : Colors.grey[300]!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isPressed
                        ? kPrimaryColor
                        : kPaymentCardIconBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Image(
                    image: AssetImage(leadingImage),
                    height: 20,
                    color: isPressed ? Colors.white : Colors.black,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Visibility(
                  visible: isPressed,
                  child: const Icon(Icons.arrow_forward_ios,
                      color: kPrimaryColor, size: 12)),
            ),
          ],
        ),
      ),
    );

class MembershipPaymentDone extends StatefulWidget {
  const MembershipPaymentDone(
      {Key? key, required this.choicePoint, required this.exploreScripts})
      : super(key: key);
  final String choicePoint;
  final Function exploreScripts;
  @override
  _MembershipPaymentDoneState createState() => _MembershipPaymentDoneState();
}

class _MembershipPaymentDoneState extends State<MembershipPaymentDone> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Card(
            elevation: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  tickMark(
                      icoColor: kLightGreenColor,
                      icoBackgroundColor: Colors.white,
                      icoSize: 61.64,
                      hSize: 63.64,
                      vSize: 63.64),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: Text(
                      'Payment Done',
                      textAlign: TextAlign.center,
                      style: kDashWidgetBigTitleBlackStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'The ${widget.choicePoint} has been purchased successfully.',
                      textAlign: TextAlign.center,
                      style: kDashWidgetBigTitleBlackStyle.copyWith(
                        color: Colors.black38,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Buttons.customPrimaryButton(
                        onPressed: () {
                          widget.exploreScripts();
                        },
                        title: 'Explore Scripts',
                        buttonHeight: 40,
                        borderRoundness: 3,
                        fontSize: 12,
                        buttonWidth: 140),
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

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel(
      {Key? key,
      required this.onSaved,
      required this.mapKey,
      required this.boxWidth,
      this.keyBoardType,
      this.maxLines,
      required this.hint})
      : super(key: key);
  final double boxWidth;
  final String hint;
  final String mapKey;
  final Function onSaved;
  final int? maxLines;
  final TextInputType? keyBoardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.25),
            child: Text(
              hint,
              style: kProfileNameTextStyle.copyWith(fontSize: 13),
            ),
          ),
          TextFields.withoutController(
             borderRoundness: SizeConfig.heightMultiplier * 0.746,
              maxLine: maxLines ?? 1,
              inputType: keyBoardType ?? TextInputType.text,
              hint: hint,
              mapKey: mapKey,
              onSaved: onSaved,
              errorMessage: 'Please provide your $hint'),
        ],
      ),
    );
  }
}

class CustomTextFieldWithLabel extends StatelessWidget {
  const CustomTextFieldWithLabel(
      {Key? key,
      required this.onSaved,
      required this.mapKey,
      required this.boxWidth,
      required this.leadingIcon,
      this.keyBoardType,
      this.iconColor,
      this.maxLines,
      required this.hint})
      : super(key: key);
  final double boxWidth;
  final String hint;
  final Color? iconColor;
  final String mapKey;
  final IconData leadingIcon;
  final Function onSaved;
  final int? maxLines;
  final TextInputType? keyBoardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.25, right: 24.3),
            child: Text(
              hint,
              style: kProfileNameTextStyle.copyWith(fontSize: 12),
            ),
          ),
          TextFields.withController(
              maxLine: maxLines ?? 1,
              fontSize: 11,
              inputType: keyBoardType ?? TextInputType.text,
              hint: hint,
              isLeading: true,
              leadingIcon: leadingIcon,
              mapKey: mapKey,
              onSaved: onSaved,
              errorMessage: 'Please provide your $hint',
              onTapped: () {}),
        ],
      ),
    );
  }
}

class CVCTextFieldWithLabel extends StatelessWidget {
  const CVCTextFieldWithLabel(
      {Key? key, required this.onSaved, required this.boxWidth, t})
      : super(key: key);
  final double boxWidth;
  final Function onSaved;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.25, right: 24.3),
            child: Text(
              'Expiration date / CVC',
              style: kProfileNameTextStyle.copyWith(fontSize: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
              border: Border.all(color: kBorderColor),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/calendar-icon.svg',
                  width: 20,
                  height: 20,
                  color: kIconColor,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Expiration Date',
                          hintStyle: kTextFieldHintStyle.copyWith(fontSize: 11),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              left: 8.5, right: 8.5, top: 9, bottom: 18)),
                      onSaved: (value) {
                        onSaved('expiration_date', value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'expiration date required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[200]!,
                  width: 1,
                  height: 40,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    width: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'CVC',
                          hintStyle: kTextFieldHintStyle.copyWith(fontSize: 11),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              left: 15.5, right: 8.5, top: 9, bottom: 18)),
                      onSaved: (value) {
                        onSaved('cvc', value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'cvc date required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class TextFieldWithLabelAndLeadingImage extends StatelessWidget {
  const TextFieldWithLabelAndLeadingImage(
      {Key? key,required this.imagePath,required this.hint,required this.mapKey,required this.onSaved, required this.boxWidth,this.title='Card Number'})
      : super(key: key);
  final double boxWidth;
  final Function onSaved;
  final String imagePath;
  final String title;
  final String hint;
  final String mapKey;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.25, right: 24.3),
            child: Text(
              title,
              style: kProfileNameTextStyle.copyWith(fontSize: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
              border: Border.all(color: kBorderColor),
            ),
            child: Row(
              children: [
                Container(
                  padding:const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                  color: Colors.white,
                  child: Image(
                    image:AssetImage(imagePath),
                    width: 20,
                    height: 20,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: kTextFieldHintStyle.copyWith(fontSize: 11),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              left: 8.5, right: 8.5, top: 9, bottom: 18)),
                      onSaved: (value) {
                        onSaved(mapKey, value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter card number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
