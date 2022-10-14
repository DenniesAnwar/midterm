import 'package:flutter/material.dart';
import 'package:wa_app/models/meeting_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';

class ScScheduleMeetingCard extends StatelessWidget {
  const ScScheduleMeetingCard(
      {Key? key, required this.meetingModel, required this.onCardPressed})
      : super(key: key);
  final MeetingModel meetingModel;
  final Function onCardPressed;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    var size = MediaQuery.of(context).size;
    double heightSize = size.height/100;
    double widthSize = size.width /100;
    return Container(
      decoration: const BoxDecoration(
        color: kScriptPaneBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.only(bottom: heightSize * 1.6889),
      child: Padding(
        padding: EdgeInsets.only(left:widthSize * 0.1953, right: widthSize * 0.2953,bottom: heightSize * 1.2953, top: heightSize * 1.2953),
        child: InkWell(
          onTap: () {
            onCardPressed();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: heightSize * 1.120,left: widthSize * 0.3353),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius:   SizeConfig.screenWidth < 1110
                          ? 13
                          : SizeConfig.screenWidth < 1510
                          ? 18
                          : heightSize * 1.6330,
                      backgroundColor: Colors.lightBlue,
                      child: Image(
                        image: AssetImage(meetingModel.imagePath),
                        width: SizeConfig.screenWidth < 1110
                            ? 14
                            : SizeConfig.screenWidth < 1510
                            ? 20
                            : widthSize * 0.78,
                        height: SizeConfig.screenWidth < 1110
                            ? 14
                            : SizeConfig.screenWidth < 1510
                            ? 20
                            : widthSize * 0.78,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: widthSize * 0.38),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meetingModel.dateAndDay,
                            style: TextStyle(
                                fontSize:SizeConfig.screenWidth < 1110 ?11 : SizeConfig.screenWidth < 1510?13:heightSize * 1.220,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: heightSize * 0.373),
                            child: Text(
                              meetingModel.timeString,
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth < 1510 ? 10:heightSize * 1.020,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Open Sans'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: widthSize * 0.38),
                      child: Text(
                        meetingModel.joinWithMeeting,
                        style:  TextStyle(
                            fontSize: SizeConfig.screenWidth < 1510 ? 11:heightSize * 1.060,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: heightSize * 2.389, bottom: heightSize * 1.643, left: widthSize * 1.009),
                child: Text(
                  'Meeting with ${meetingModel.meetingWithPersonName}',
                  style: TextStyle(
                      fontSize:SizeConfig.screenWidth < 1110 ?11 : SizeConfig.screenWidth < 1510?14:heightSize * 1.300,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Open Sans'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScSmallScheduleMeetingCard extends StatelessWidget {
  const ScSmallScheduleMeetingCard(
      {Key? key, required this.meetingModel, required this.onCardPressed,this.cardColor})
      : super(key: key);
  final MeetingModel meetingModel;
  final Function onCardPressed;
  final Color? cardColor;
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return InkWell(
      onTap: () {
        onCardPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor??kScriptPaneBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: SizeConfig.screenWidth < 700?4:23.06, right: SizeConfig.screenWidth < 520?4:23.06, top: SizeConfig.heightMultiplier * 0.915),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 26.45,
                  backgroundColor: Colors.lightBlue,
                  child: Image(
                    image: AssetImage(meetingModel.imagePath),
                    width: 20,
                  ),
                ),
                title: Text(
                  meetingModel.dateAndDay,
                  style: TextStyle(
                      fontSize:  SizeConfig.screenWidth < 940?12:17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Open Sans'),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    meetingModel.timeString,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth < 940?8:12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans'),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(top: SizeConfig.screenWidth > 1500?28:14, bottom: 8, left: 23),
                child: Text(
                  'Meeting with ${meetingModel.meetingWithPersonName}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize:  SizeConfig.screenWidth < 940?10:15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.screenWidth < 940?3:23, bottom: SizeConfig.screenWidth > 1500?24:14, ),
                child: Text(
                  meetingModel.joinWithMeeting,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth < 940?10:15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Open Sans'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
