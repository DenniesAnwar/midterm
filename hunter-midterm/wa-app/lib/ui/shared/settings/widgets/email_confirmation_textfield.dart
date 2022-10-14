import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class EmailConfirmationTextField extends StatefulWidget {
  const EmailConfirmationTextField({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final Function onSaved;

  @override
  State<EmailConfirmationTextField> createState() =>
      _EmailConfirmationTextFieldState();
}

class _EmailConfirmationTextFieldState
    extends State<EmailConfirmationTextField> {
  bool isEmailConfirmed = false;
  String validationString = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return Container(
      constraints: const BoxConstraints(minWidth: 120, minHeight: 32),
      height: SizeConfig.heightMultiplier * 9.286,
      child: TextFormField(
        initialValue: '',
        maxLines: 1,
        style: kTextFieldHintStyle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: kBorderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                SizeConfig.heightMultiplier * 0.672,
              ))),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: kBorderColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeConfig.heightMultiplier * 0.672,
              ),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.greenAccent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeConfig.heightMultiplier * 0.672,
              ),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeConfig.heightMultiplier * 0.672,
              ),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: kBorderColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeConfig.heightMultiplier * 0.672,
              ),
            ),
          ),
          hintText: 'Email',
          fillColor: kChatBackgroundColor,
          filled: true,
          hintStyle: kTextFieldHintStyle.copyWith(
              fontSize: SizeConfig.screenWidth < 1500 ? 12 : 15),
          border: InputBorder.none,
          suffix: SizedBox(
            width: SizeConfig.widthMultiplier * 9.387,
            height: SizeConfig.heightMultiplier * 3.286,
            child: Row(
              children: [
                Visibility(
                  visible: isEmailConfirmed,
                  child: Container(
                    width: SizeConfig.screenWidth > 1500
                        ? SizeConfig.widthMultiplier * 0.583
                        : 12,
                    height: SizeConfig.screenWidth > 1500
                        ? SizeConfig.heightMultiplier * 1.120
                        : 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green),
                    ),
                    child: Icon(
                      Icons.done,
                      size: SizeConfig.heightMultiplier * 0.915,
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  validationString,
                  style: kProfileNameTextStyle.copyWith(
                      fontSize: SizeConfig.screenWidth > 1500
                          ? SizeConfig.heightMultiplier * 0.748
                          : 10,
                      color:
                          isEmailConfirmed ? Colors.green : Colors.redAccent),
                )
              ],
            ),
          ),
          contentPadding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 0.953,
              right: SizeConfig.widthMultiplier * 0.301,
              top: SizeConfig.heightMultiplier * 0.672,
              bottom: SizeConfig.heightMultiplier * 1.045),
        ),
        onSaved: (value) {
          widget.onSaved('email', value!.trim());
        },
        onChanged: (value) {
          bool isValid = EmailValidator.validate(value);

          if (value.isEmpty) {
            setState(() {
              isEmailConfirmed = false;
              validationString = 'Email Required';
            });
          } else if (isValid) {
            setState(() {
              isEmailConfirmed = isValid;
              validationString = 'Email Confirmed';
            });
          } else {
            setState(() {
              isEmailConfirmed = false;
              validationString = 'Invalid email';
            });
          }
        },
        validator: (value) {
          bool isValid = EmailValidator.validate(value!);

          if (isValid) {
            setState(() {
              isEmailConfirmed = isValid;
            });
            String returnValue =
                '$value is ' + (isValid ? 'a' : 'not') + ' valid email.';
            return returnValue;
          }
          return null;
        },
      ),
    );
  }
}
