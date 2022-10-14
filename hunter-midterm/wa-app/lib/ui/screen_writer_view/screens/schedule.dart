import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:wa_app/models/meeting_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/calendar_view.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/schedule_meeting_card.dart';
import 'package:wa_app/utills/styles.dart';

class ScScheduleView extends StatefulWidget {
  const ScScheduleView({Key? key}) : super(key: key);

  @override
  _ScScheduleViewState createState() => _ScScheduleViewState();
}

class _ScScheduleViewState extends State<ScScheduleView> {

  final ScrollController _scheduleController = ScrollController();
  final List<ColorHue> _hueType = <ColorHue>[
    ColorHue.green,
    ColorHue.red,
    ColorHue.pink,
    ColorHue.purple,
    ColorHue.blue,
    ColorHue.yellow,
    ColorHue.orange
  ];
  final List<Color> _bubbleColors = [];

  String dropdownValue = 'Today';
  @override
  void initState() {
    for (int i = 0; i < 7; i++) {
      _bubbleColors.add(RandomColor().randomColor(
          colorHue: ColorHue.multiple(colorHues: _hueType),
          colorSaturation: ColorSaturation.random,
          colorBrightness: ColorBrightness.random));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _lgScreenBody(),
    );
  }

  Widget _lgScreenBody() {
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: CalendarViewScreen(),
        ),
        _loadProfileDetailView()
      ],
    );
  }

  Widget _loadProfileDetailView() => Container(
        height: double.infinity,
        width: SizeConfig.screenWidth < 700?SizeConfig.screenWidth < 600?200:262:295,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.grey[300]!),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: SizeConfig.screenWidth > 950,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 20,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.notifications,
                            size: 28,
                          ),
                          Expanded(child: Align(alignment:Alignment.center,child: ProfileButton())),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  //SizeConfig.screenWidth > 940 ?_smBodyFilterTile():_lgBodyFilterTile(),
                  _lgBodyFilterTile(context),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 2.389,
                          bottom: SizeConfig.heightMultiplier * 5.75),
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: ListView.builder(
                             controller: _scheduleController,
                            itemCount: _bubbleColors.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.heightMultiplier * 2.389,
                                    left: 20,
                                    right: 20),
                                child: SizedBox(
                                  width: 100,
                                  child: ScSmallScheduleMeetingCard(
                                    cardColor: _bubbleColors[index],
                                    meetingModel: MeetingSchedules.meetings[0],
                                    onCardPressed: () {},
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _lgBodyFilterTile(context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 5.75,
                bottom: SizeConfig.heightMultiplier * 2.389),
            child: Text(
              'Upcoming Schedules',
              textAlign: TextAlign.center,
              style: kProfileNameTextStyle.copyWith(
                  fontSize: SizeConfig.screenWidth < 920
                      ? 14
                      : SizeConfig.screenWidth < 1500?17:SizeConfig.heightMultiplier * 1.4936),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100]),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Image(
                image: AssetImage('assets/icons/down_arrow.png',),
                color: Colors.black,
              ),
              iconSize: 25,
              elevation: 16,
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Next Week',
                'Today',
                'This Month',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding:EdgeInsets.only(right: SizeConfig.screenWidth < 640?30:136.0),
                    child: Text(value,style: TextStyle(
                      fontSize: SizeConfig.screenWidth < 1100?11:SizeConfig.screenWidth < 1500?14:17,
                    ),),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
