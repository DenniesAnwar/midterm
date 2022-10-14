import 'package:flutter/material.dart';
import 'package:wa_app/utills/styles.dart';

loadFormTileInput(
    {bool isRequired = true,
      required Widget childWidget,
      bool isJustified = false,
      required String label}) =>
    Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
        child: Wrap(
          children: [
            SizedBox(
              width: 290,
              child: Wrap(
                children: [
                  RichText(
                    textAlign: isJustified?TextAlign.justify:TextAlign.start,
                    text: TextSpan(text: label,style: sBigTitleTextStyle.copyWith(
                        height: 1.3,
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal),
                        children: [
                          TextSpan(text: isRequired?'  *':' ',style:sBigTitleTextStyle.copyWith(
                              height: 1.3,
                              fontSize: 24,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal),),
                        ]
                    ),

                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(width: 470, child: childWidget),
          ],
        ),
      ),
    );



loadFormTileInputWithNoReq(
    {
      required Widget childWidget,
      required String label}) =>
    Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
        child: Wrap(
          children: [
            SizedBox(
              width: 290,
              child: Wrap(
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(text: label,style: sBigTitleTextStyle.copyWith(
                        height: 1.3,
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal),
                    ),

                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(width: 470, child: childWidget),
          ],
        ),
      ),
    );