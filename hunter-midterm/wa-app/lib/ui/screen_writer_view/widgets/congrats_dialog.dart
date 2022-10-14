import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_general_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

showCongratsDialog(BuildContext context) {

  SizeConfig().init(MediaQuery.of(context).size);

  return showDialog(
      context: context,
      builder: (context) {
        return  Center(
          child: Card(
            child: SizedBox(
              height: 220,
              width: 550,
              child: Padding(
                padding:
                EdgeInsets.only(top: SizeConfig.heightMultiplier * 3.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tickMark(hSize: 42.25, vSize: 42.25, icoSize: 35),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Text(
                      'Congratulation',
                      style: kProfileNameTextStyle.copyWith(
                        color: kGreenColor,
                        fontSize: SizeConfig.screenWidth > 1400 ? 28 : 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    SizedBox(
                      width: 480,
                      child: Text(
                        'Now script now is in the marketplaced click on the link below to see your marketplace scripts',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: kProfileNameTextStyle.copyWith(
                          fontSize: SizeConfig.screenWidth > 1400 ? 18 : 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    _loadBackToHome(context),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

_loadBackToHome(BuildContext context)=>InkWell(
  onTap: (){
    //context.beamToNamed(Routes.s);
  },
  child: Text(
    'Check my Marketplace scripts',
    overflow: TextOverflow.ellipsis,
    style: kProfileNameTextStyle.copyWith(
      fontSize: SizeConfig.screenWidth > 1400 ? 22 : 14,
      decoration: TextDecoration.underline,
      color: Colors.blue,
      fontWeight: FontWeight.w700,
    ),
  ),
);