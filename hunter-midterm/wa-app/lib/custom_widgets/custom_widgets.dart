
import 'package:flutter/material.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

Widget loadLogoWithText() {
  return const Image(
    image: AssetImage(
      'assets/icons/wo_logo.png',
    ),
    width: 170.84,
    height: 48.64,
  );
}

imageContainer(
    {double containerHeight = 70.0,
      containerWidth = 70.0,
      required imagePath,
      double borderWidth=0.3,
      Color borderColor=Colors.white,
      double hMargin = 8,
      double vMargin = 4}) =>
    Container(
      constraints: const BoxConstraints(
        minHeight: 35,
        minWidth: 35,
      ),
      height: containerHeight.toDouble(),
      width: containerWidth.toDouble(),
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
        border: Border.all(
          width: borderWidth,
          color: borderColor,
        ),
      ),
    );


blueCounterContainer({required Widget child})=>Container(
  decoration: const BoxDecoration(
    color: kPrimaryColor,
    borderRadius: BorderRadius.all(Radius.circular(4),),
  ),
  child: child,
);

greenDotContainer()=>Container(
  height: 10,
  width: 10,
  decoration: const BoxDecoration(
    color: Colors.green,
    shape: BoxShape.circle,
  ),
);



bigDivider() => Container(
  constraints: const BoxConstraints(
    minWidth: 300,
    maxWidth: 900,
  ),
  //margin: EdgeInsets.symmetric(vertical: ),
  child: const Divider(
    thickness: 1,
  ),
);
smallDivider() => Container(
  constraints: const BoxConstraints(
    minWidth: 300,
    maxWidth: 800,
  ),
  //margin: EdgeInsets.symmetric(vertical: ),
  child: const Divider(
    thickness: 1,
  ),
);

sectionTitle({title})=>Column(
  crossAxisAlignment:CrossAxisAlignment.start,
  children:[
    Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 15,top:15),
      child: Text(
        title,
        style: sSmallTitleTextStyle.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black),
      ),
    ),
    smallDivider(),
  ],
);




sectionSubTitle({subtitle=''})=>Padding(
  padding:
  const EdgeInsets.only(bottom: 30, left: 25, right: 45),
  child: Text(
    subtitle,
    style: sSmallTitleTextStyle.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.black54),
  ),
);
