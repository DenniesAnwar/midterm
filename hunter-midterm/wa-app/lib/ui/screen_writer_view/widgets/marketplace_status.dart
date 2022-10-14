// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class MyMarketPlaceStatus extends StatefulWidget {
  const MyMarketPlaceStatus({Key? key}) : super(key: key);

  @override
  State<MyMarketPlaceStatus> createState() => _MyMarketPlaceStatusState();
}

class _MyMarketPlaceStatusState extends State<MyMarketPlaceStatus> {
  late Size size;
  late double heightSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    heightSize = size.height / 100;

    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
      ),
      child: Consumer<ScScriptProvider>(builder: (_, scriptProvider, __) {
        return Container(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth > 1250 ? 45 : 13,
              bottom: SizeConfig.screenHeight < 680 ? 45 : 100),
          constraints: const BoxConstraints(
            minWidth: 300,
          ),
          width: 300,
          decoration: BoxDecoration(
              border: Border(
            left: SizeConfig.screenWidth < 680
                ? BorderSide.none
                : const BorderSide(width: 1.2, color: kBorderColor),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: heightSize * 2.867, bottom: heightSize * 5.667),
                child: Text(
                  'My MarketPlace Status',
                  style: kProfileNameTextStyle.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: SizeConfig.screenHeight < 680 ? 15 : 20),
                ),
              ),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    _marketplaceStatusTile(
                        title: 'Marketplace Submissions',
                        number: "${scriptProvider.scripts.length}"),
                    _marketplaceStatusTile(
                        title: 'Scripts in Marketplace',
                        number: "${scriptProvider.getPublishedScriptCount()}"),
                    //  Align(
                    //    alignment: Alignment.bottomRight,
                    //    child: Padding(
                    //      padding: const EdgeInsets.only(top: 38),
                    //      child: InkWell(
                    //        onTap: () {},
                    //        child: Text(
                    //          'See all',
                    //          style: kProfileNameTextStyle.copyWith(
                    //              fontSize: SizeConfig.screenHeight < 680 ? 12
                    //                  : 14,
                    //              color: Colors.blue),
                    //        ),
                    //      ),
                    //    ),
                    //  ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  _marketplaceStatusTile({required String title, required String number}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: SizeConfig.screenHeight < 680 ? 13 : 16,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              number,
              style: TextStyle(
                  fontSize: SizeConfig.screenHeight < 680 ? 13 : 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
}
