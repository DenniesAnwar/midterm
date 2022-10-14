import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class TextFields {
  static Widget withoutDecoration(
          {String initialValue = '',
          required String mapKey,
          required String errorMessage,
          bool isEmptyValidation = true,
          double borderRoundness = 10,
          bool isFilled = true,
          int maxLine = 1,
          TextInputType inputType = TextInputType.text,
          required Function onSaved}) =>
      TextFormField(
        initialValue: initialValue,
        maxLines: maxLine,
        keyboardType: inputType,
        style: kTextFieldHintStyle.copyWith(
            color: Colors.black,
            height: 2,
            fontSize: 15,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRoundness))),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: kBorderColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRoundness),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Colors.greenAccent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRoundness),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Colors.redAccent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRoundness),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: kBorderColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRoundness),
              ),
            ),
            fillColor: Colors.white,
            filled: isFilled,
            hintStyle: kTextFieldHintStyle.copyWith(
                fontSize: SizeConfig.screenWidth < 1500 ? 12 : 15),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(13)),
        onSaved: (value) {
          onSaved(mapKey, value!.trim());
        },
        validator: (value) {
          if (isEmptyValidation) {
            if (value!.isEmpty) {
              return errorMessage;
            }
            return null;
          }
          return null;
        },
      );

  static Widget withoutController(
          {String initialValue = '',
          required String hint,
          required String mapKey,
          bool isPhoneNumberValidator = false,
          int? maxLength,
          bool isFocused = false,
          String errorMessage = '',
          TextInputType inputType = TextInputType.text,
          bool secureText = false,
          bool isEmptyValidation = true,
          bool isEmailValidation = false,
          bool isLengthConstraints = false,
          double borderRoundness = 10,
          bool enabled = true,
          bool isFilled = true,
          int minimumLength = 8,
          IconData leadingIcon = Icons.search,
          bool isTrailing = false,
          Color trailingIconColor = kIconColor,
          bool isLeading = false,
          String lengthErrorMessage = "",
          String emailInvalidMessage = "",
          int maxLine = 1,
          required Function onSaved,
          Color? fillColor}) =>
      Container(
        margin: SizeConfig.screenWidth < 450
            ? EdgeInsets.only(
                left: SizeConfig.widthMultiplier * 4.915,
                right: SizeConfig.widthMultiplier * 4.915)
            : const EdgeInsets.all(0),
        child: TextFormField(
          initialValue: initialValue,
          obscureText: secureText,
          keyboardType: inputType,
          maxLines: maxLine,
          maxLength: maxLength,
          autofocus: isFocused,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: kBorderColor,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRoundness))),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                gapPadding: 15,
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.redAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              enabled: enabled,
              hintText: hint,
              fillColor: fillColor ?? kChatBackgroundColor,
              filled: isFilled,
              hintStyle: kTextFieldHintStyle.copyWith(
                  fontSize: SizeConfig.screenWidth < 1500 ? 12 : 15),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20)),
          onSaved: (value) {
            onSaved(mapKey, value!.trim());
          },
          validator: (value) {
            if (isEmptyValidation) {
              if (value!.isEmpty) {
                return errorMessage;
              } else if (isEmailValidation) {
                final bool isValid = EmailValidator.validate(value);
                if (!isValid) {
                  return '$value is ' +
                      (isValid ? 'a' : 'not') +
                      ' valid email.';
                }
                return null;
              } else if (isLengthConstraints) {
                if (value.length < minimumLength) {
                  return lengthErrorMessage;
                }
                return null;
              } else if (isPhoneNumberValidator) {
                String patttern =
                    r"^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$";
                RegExp regExp = RegExp(patttern);
                if (!regExp.hasMatch(value)) {
                  return 'Please enter valid mobile number';
                }
                return null;
              }
              return null;
            }
            return null;
          },
        ),
      );

  static Widget imdbTextField(
          {String initialValue = '',
          required String hint,
          required String mapKey,
          bool isFocused = false,
          String errorMessage = '',
          double borderRoundness = 10,
          bool isFilled = true,
          Color trailingIconColor = kIconColor,
          int maxLine = 1,
          required Function onSaved,
          Color? fillColor}) =>
      Container(
        margin: SizeConfig.screenWidth < 450
            ? EdgeInsets.only(
                left: SizeConfig.widthMultiplier * 4.915,
                right: SizeConfig.widthMultiplier * 4.915)
            : const EdgeInsets.all(0),
        child: TextFormField(
          initialValue: initialValue,
          maxLines: maxLine,
          style: kTextFieldHintStyle,
          autofocus: isFocused,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: kBorderColor,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRoundness))),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                gapPadding: 15,
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.redAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              hintText: hint,
              fillColor: fillColor ?? kChatBackgroundColor,
              filled: isFilled,
              hintStyle: kTextFieldHintStyle.copyWith(
                  fontSize: SizeConfig.screenWidth < 1500 ? 12 : 15),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20)),
          onSaved: (value) {
            onSaved(mapKey, value!.trim());
          },
          validator: (value) {
            if (value!.isEmpty) {
              return errorMessage;
            } else if (!value.contains('https://www.imdb.com')) {
              return 'Link must be IMDB';
            }

            return null;
          },
        ),
      );

  static withController(
          {required String hint,
          required String mapKey,
          String errorMessage = "",
          TextInputType inputType = TextInputType.text,
          bool secureText = false,
          Widget? trailingIcon,
          IconData leadingIcon = Icons.search,
          bool isTrailing = false,
          Color trailingIconColor = kIconColor,
          bool isLeading = false,
          FocusNode? focusNode,
          required Function onTapped,
          TextEditingController? controller,
          bool isEmptyValidation = true,
          bool isEmailValidation = false,
          int maxLine = 1,
          double fontSize = 14.0,
          double borderRoundness = 10,
          bool isLengthConstraints = false,
          int minimumLength = 8,
          bool isFilled = false,
          String lengthErrorMessage = "",
          required Function onSaved}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(borderRoundness),
        child: TextFormField(
          onTap: () {
            onTapped();
          },
          focusNode: focusNode ?? FocusNode(),
          controller: controller ?? TextEditingController(),
          maxLines: maxLine,
          obscureText: secureText,
          keyboardType: inputType,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: kBorderColor,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRoundness))),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.redAccent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRoundness),
                ),
              ),
              hintText: hint,
              fillColor: kChatBackgroundColor,
              filled: isFilled,
              hintStyle: kTextFieldHintStyle.copyWith(fontSize: fontSize),
              border: InputBorder.none,
              prefixIcon: isLeading
                  ? Icon(leadingIcon, size: 24, color: kIconColor)
                  : null,
              suffixIcon: isTrailing ? trailingIcon! : null,
              contentPadding: const EdgeInsets.all(13)),
          onSaved: (value) {
            onSaved(mapKey, value);
          },
          validator: (value) {
            if (isEmptyValidation) {
              if (value!.isEmpty) {
                return errorMessage;
              } else if (isEmailValidation) {
                final bool isValid = EmailValidator.validate(value);
                if (!isValid) {
                  String returnValue =
                      '$value is ' + (isValid ? 'a' : 'not') + ' valid email.';
                  return returnValue;
                } else {
                  return null;
                }
              } else if (isLengthConstraints) {
                if (value.length < minimumLength) {
                  return lengthErrorMessage;
                }
              }
              return null;
            }
            return null;
          },
        ),
      );

  static withConfirmController(
          {required String hint,
          required String mapKey,
          String errorMessage = "",
          bool isFilled = false,
          TextInputType inputType = TextInputType.text,
          bool secureText = false,
          bool isEmptyValidation = true,
          bool isEmailValidation = false,
          bool isLengthConstraints = false,
          Widget? trailingIcon,
          IconData leadingIcon = Icons.search,
          int minimumLength = 8,
          bool isTrailing = false,
          Color trailingIconColor = kIconColor,
          bool isLeading = false,
          double borderRoundness = 10,
          String lengthErrorMessage = "",
          TextEditingController? controller,
          TextEditingController? confirmController,
          required Function onSaved,
          double? containerHeight}) =>
      Container(
        margin: SizeConfig.screenWidth < 450
            ? EdgeInsets.only(
                left: SizeConfig.widthMultiplier * 4.915,
                right: SizeConfig.widthMultiplier * 4.915)
            : const EdgeInsets.all(0),
        child: TextFormField(
          controller: controller,
          obscureText: secureText,
          keyboardType: inputType,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRoundness))),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: kBorderColor,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRoundness))),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: kBorderColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRoundness),
              ),
            ),
            hintText: hint,
            fillColor: kChatBackgroundColor,
            filled: isFilled,
            hintStyle: kTextFieldHintStyle.copyWith(
                fontSize: SizeConfig.screenWidth < 1500 ? 12 : 15),
            border: InputBorder.none,
            prefixIcon: isLeading
                ? Icon(leadingIcon, size: 20, color: kIconColor)
                : null,
            suffixIcon: isTrailing ? trailingIcon : null,
            contentPadding: const EdgeInsets.all(13),
          ),
          onSaved: (value) {
            onSaved(mapKey, value);
          },
          validator: (value) {
            if (isEmptyValidation) {
              if (value!.isEmpty) {
                return errorMessage;
              } else if (controller!.text != confirmController!.text) {
                return "Password didn't match";
              } else if (isLengthConstraints) {
                if (value.length < minimumLength) {
                  return lengthErrorMessage;
                }
              }
              return null;
            }
            return null;
          },
        ),
      );

  static Widget yearsKnown({
    required String hint,
    required String mapKey,
    required Function addNumberCall,
    required Function removeNumberCall,
    String errorMessage = "",
    required TextEditingController controller,
    TextInputType inputType = TextInputType.number,
    bool isEmptyValidation = true,
    int maxLine = 1,
    required onSaved,
    double borderRoundness = 8,
    bool isLengthConstraints = true,
    int minimumLength = 1,
    String lengthErrorMessage = "",
  }) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRoundness),
            border: Border.all(color: Colors.grey)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRoundness),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  addNumberCall();
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(9),
                  color: Colors.blueAccent.withOpacity(0.3),
                  child: const Icon(Icons.add),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 120,
                    child: TextFormField(
                      maxLines: maxLine,
                      controller: controller,
                      keyboardType: inputType,
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              left: 20, right: 8, bottom: 10, top: 10)),
                      onSaved: (value) {
                        onSaved!(mapKey, value);
                      },
                      validator: (value) {
                        if (isEmptyValidation) {
                          if (value!.isEmpty) {
                            return errorMessage;
                          } else if (isLengthConstraints) {
                            if (value.length < minimumLength) {
                              return lengthErrorMessage;
                            }
                          }
                          return null;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  removeNumberCall();
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(9),
                  color: Colors.blueAccent.withOpacity(0.3),
                  child: const Icon(Icons.remove),
                ),
              ),
            ],
          ),
        ),
      );
}
