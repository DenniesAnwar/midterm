import 'package:flutter/material.dart';

import 'custom_widgets.dart';

Widget profileRow() => Padding(
  padding: const EdgeInsets.only(top: 6, bottom: 4, right: 25),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        height: 30,
        width: 25,
        child: Stack(
          children: const [
            Positioned(
                top: 5,
                child: Image(
                  image: AssetImage('assets/icons/notification.png'),
                  height: 20,
                  width: 20,
                  color: Colors.black,
                )),
            Positioned(
              right: 5,
              top: 5,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 4,
              ),
            ),
          ],
        ),
      ),
      imageContainer(
          imagePath: 'assets/images/no_profile.png',
          containerHeight: 40,
          containerWidth: 40),
      const Image(
        image: AssetImage('assets/icons/down_arrow.png'),
        height: 15,
        width: 20,
        color: Colors.black,
      ),
    ],
  ),
);