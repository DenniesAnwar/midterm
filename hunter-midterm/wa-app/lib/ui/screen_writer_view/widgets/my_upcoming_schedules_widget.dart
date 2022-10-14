import 'package:flutter/material.dart';
import 'package:wa_app/models/meeting_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_schedule_dropdown_button.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/schedule_meeting_card.dart';
import 'package:wa_app/utills/styles.dart';

class UpcomingSchedules extends StatelessWidget {
  const UpcomingSchedules(
      {Key? key,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 0.746),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 2.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 0.746),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Schedules',
                    style: kProfileNameTextStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: SizeConfig.screenWidth < 1400?15:SizeConfig.heightMultiplier*1.643),
                  ),
                  const ScheduleDropDown(),
                ],
              ),
            ),
            SizeConfig.screenWidth > 1100
            ? Column(children: [
              ...List.generate(2, (index) {
                var item =
                MeetingSchedules.meetings[0];
                return ScScheduleMeetingCard(
                  meetingModel: item,
                  onCardPressed: () {},
                );
              })
            ],)
            : Column(children: [
              ...List.generate(2, (index) {
                var item =
                MeetingSchedules.meetings[0];
                return Padding(
                  padding:  EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1.6889),
                  child: ScSmallScheduleMeetingCard(
                    meetingModel: item,
                    onCardPressed: () {},
                  ),
                );
              })
            ],),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {},
                  child: Text(
                    'See All',
                    style: kProfileNameTextStyle.copyWith(
                        fontSize: SizeConfig.heightMultiplier * 1.2509,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
