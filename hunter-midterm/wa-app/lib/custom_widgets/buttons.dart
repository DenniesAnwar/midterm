import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class Buttons {
  static Widget customPrimaryButton(
          {double buttonWidth = 178.87,
          double? buttonHeight,
          double borderRoundness = 5.0,
          double fontSize = 20.0,
          Color textColor = Colors.white,
          Color? borderColor,
          FontWeight fontWeight = FontWeight.w600,
          title = 'See all',
          required Function onPressed,
          Color buttonColor = kPrimaryColor}) =>
      InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: buttonWidth,
          height: buttonHeight ?? SizeConfig.heightMultiplier * 5.033,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.all(
                Radius.circular(borderRoundness),
              ),
              border: Border.all(color: borderColor ?? buttonColor)),
          child: Center(
            child: FittedBox(
              child: Text(
                title,
                style: sSmallTitleTextStyle.copyWith(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight),
              ),
            ),
          ),
        ),
      );
  static Widget outlinePrimaryButton(
          {Color textColor = Colors.blue,
          Color borderColor = Colors.blue,
          Color buttonColor = kBasicOutlineButtonColor,
          title = 'See all',
          double borderRoundness = 25.0,
          double fontSize = 10.0,
          required Function onPressed}) =>
      InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRoundness),
            ),
          ),
          child: Center(
              child: Text(
            title,
            style: sSmallTitleTextStyle.copyWith(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w400),
          )),
        ),
      );

  static Widget submitButton({
    title = 'Submit',
    required Function onPressed,
    double buttonWidth = 40.87,
    double buttonHeight = 13.54,
    double fontSize = 14,
  }) =>
      InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: buttonWidth,
          height: buttonHeight,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: sSmallTitleTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      );
}
