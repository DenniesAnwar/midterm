import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle sBigTitleTextStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w800,
  fontSize: 20,
  color: Colors.black,
  letterSpacing: 1.2,
);
TextStyle sSmallTitleTextStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w500,
  fontSize: 13,
  color: kUnActiveButtonColor,
  letterSpacing: 1.1,
);

TextStyle kCardBottomDescriptionStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: kBigTitleColor,
  letterSpacing: 0.7,
);

AuthButtonStyle kAuthButtonStyle = AuthButtonStyle(
  iconSize: 32,
  iconBackground: Colors.transparent,
  buttonType: AuthButtonType.secondary,
  buttonColor: Colors.white,
  elevation: 0,
  borderRadius: 10,
  borderColor: Colors.grey.withOpacity(0.5),
  borderWidth: 0.7,
  height: 62.76,
  width: 517.25,
  textStyle: GoogleFonts.openSans(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.1,
    fontSize: 13,
  ),
  iconType: AuthIconType.outlined,
);

TextStyle kFieldTitleStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w500,
  color: Colors.black,
  fontSize: 15,
  letterSpacing: 1,
);

TextStyle kTextFieldHintStyle = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: kGreySubtitleColor,
);

TextStyle kDashWidgetBigTitleStyle = GoogleFonts.openSans(
  fontSize: 38,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.5,
  color: kOrangeColor,
);

TextStyle kDashWidgetBigTitleBlackStyle = GoogleFonts.openSans(
  fontSize: 39,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: kBigTitleColor,
);

TextStyle kProfileNameTextStyle = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  color: kBigTitleColor,
);

TextStyle kMemberShipCardTileStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w800,
  fontSize: 12,
  letterSpacing: 0.5,
  color: Colors.black,
);

TextStyle kMediumTextStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w600,
  fontSize: 20,
  letterSpacing: 0.5,
  height: 1.6,
  color: Colors.black,
);
