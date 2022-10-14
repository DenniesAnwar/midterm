import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wa_app/models/sc_current_status_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';

class ScCurrentStatusInfoTile extends StatelessWidget {
  const ScCurrentStatusInfoTile(
      {Key? key,
      required this.statusModel})
      : super(key: key);
  final ScCurrentStatusModel statusModel;
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(MediaQuery.of(context).size);


    return Container(
      padding: EdgeInsets.only(
        bottom: SizeConfig.heightMultiplier * 4.4809,
        right: SizeConfig.widthMultiplier * 1.5809,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2.3046875),
                  child: Text(
                    statusModel.title,
                    style: TextStyle(fontSize: SizeConfig.screenHeight < 680 ?13:16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier * 0.385,
                    ),
                    child: LinearPercentIndicator(
                      animation: true,
                      animationDuration: 200,
                      backgroundColor: kLinearProgressBackgroundColor,
                      progressColor: Colors.blue,
                      percent: statusModel.percentValue,
                      width: SizeConfig.screenWidth < 1250
                          ? SizeConfig.widthMultiplier * 22.7578125
                          : SizeConfig.widthMultiplier * 17.7578125,
                      lineHeight: SizeConfig.heightMultiplier * 1.792382,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  statusModel.endValueTitle,
                  style: TextStyle(fontSize: SizeConfig.screenHeight < 680 ?13:16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
