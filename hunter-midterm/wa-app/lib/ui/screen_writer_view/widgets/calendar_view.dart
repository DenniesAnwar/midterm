import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class CalendarViewScreen extends StatefulWidget {
  const CalendarViewScreen({Key? key}) : super(key: key);

  @override
  _CalendarViewScreenState createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  final _MeetingDataSource _events = _MeetingDataSource(<_Meeting>[]);
  final CalendarController _calendarController = CalendarController();

  final ScrollController _controller = ScrollController();
  final ScrollController _daysScrollController = ScrollController();


  final CalendarView _currentView = CalendarView.day;
  String dropdownValue = 'Today';
  bool isSelected = true;
  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  final GlobalKey _globalKey = GlobalKey();
  int _currentDay = 0; /// the index of day in _days List
  @override
  void initState() {
    _calendarController.view = _currentView;

    _addEventts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    final Widget calendar = Theme(
        key: _globalKey,
        data: ThemeData(),
        child: _getCustomizationCalendar(_events, _getAppointmentUI));

    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: Scrollbar(
          controller: _controller,
          isAlwaysShown: true,
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenWidth < 1500? 35:62,),
            child: ListView(
              controller: _controller,
              children: <Widget>[
                Visibility(
                    visible: SizeConfig.screenWidth > 640, child: _loadTitleRow(context)),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth > 640 ?30.0:5),
                  child: SizedBox(
                    height: SizeConfig.screenWidth < 1500?SizeConfig.screenWidth<1100? 70:60:120,
                    width: 1000,
                    child: Center(
                      child: Stack(
                        children: [
                          SizeConfig.screenWidth < 1350?_smDaysBody(context):_lgDaysBody(context),
                          Visibility(
                            visible: SizeConfig.screenWidth < 1350,
                            child: Positioned(
                              top: 10,
                              left: 10,
                              child: InkWell(
                                onTap: (){
                                  _daysScrollController.animateTo(
                                      _daysScrollController.position.minScrollExtent,
                                      duration: const Duration(milliseconds: 120),
                                      curve: Curves.fastOutSlowIn
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1.2),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 25,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: SizeConfig.screenWidth < 1350,
                            child: Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: (){
                                  _daysScrollController.animateTo(
                                      _daysScrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 120),
                                      curve: Curves.fastOutSlowIn
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1.2),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 25,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: calendar,
                )
              ],
            ),
          )),
    );
  }


  Widget _smDaysBody(BuildContext context){

    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding:
      const EdgeInsets.only(left: 54.0, right: 54.0, top: 4),
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: ListView.builder(
            controller:_daysScrollController ,
            scrollDirection: Axis.horizontal,
            itemCount: _days.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      _currentDay =index;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        _days[index],
                        style: kProfileNameTextStyle.copyWith(
                            color:(index == _currentDay && isSelected)?Colors.blue:kTextGreyColor,
                            fontSize: SizeConfig.screenWidth < 1500? 14:20,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        '0${index+1}',
                        style: kProfileNameTextStyle.copyWith(
                            color:(index == _currentDay && isSelected)?Colors.blue:kTextGreyColor,
                            fontSize: SizeConfig.screenWidth < 1500? 14:20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _lgDaysBody(BuildContext context){

    SizeConfig().init(MediaQuery.of(context).size);

    return Row(
      children: [
        ...List.generate(_days.length, (index) => Expanded(
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentDay = index;
                });
              },
              child: Column(
                children: [
                  Text(
                    _days[index],
                    style: kProfileNameTextStyle.copyWith(
                        color:(index == _currentDay && isSelected)?Colors.blue:kTextGreyColor,
                        fontSize: SizeConfig.screenWidth < 1500? 14:20,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    '0${index+1}',
                    style: kProfileNameTextStyle.copyWith(
                        color:(index == _currentDay && isSelected)?Colors.blue:kTextGreyColor,
                        fontSize: SizeConfig.screenWidth < 1500? 14:20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget _loadTitleRow(context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return SizeConfig.screenWidth < 1100 ? _smTitleBody():_lgTitleBody();
  }

  Widget _lgTitleBody(){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                "My Script",
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth < 1500? 22:38,
                    fontWeight: FontWeight.w700,
                    color: kOrangeColor),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Today is Monday 07 Feb 2021",
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth < 1500? 14:20,
                    fontWeight: FontWeight.w400,
                    color: kTextGreyColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey[100]),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Image(
              image: AssetImage('assets/icons/down_arrow.png'),
            ),
            iconSize: 22,
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
                child: Text(value,style: TextStyle(
                  fontSize: SizeConfig.screenWidth < 1100?11:SizeConfig.screenWidth < 1500?14:17,
                ),),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _smTitleBody(){
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Script",
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth < 1500? 22:38,
                    fontWeight: FontWeight.w700,
                    color: kOrangeColor),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Today is Monday 07 Feb 2021",
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth < 1500? 14:20,
                    fontWeight: FontWeight.w400,
                    color: kTextGreyColor),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.grey[100]),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Image(
                image: AssetImage('assets/icons/down_arrow.png'),
              ),
              iconSize: 22,
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
                  child: Text(value,style: TextStyle(
                    fontSize: SizeConfig.screenWidth < 1100?11:SizeConfig.screenWidth < 1500?14:17,
                  ),),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  void _addEventts() {
    final List<_Meeting> appointment = <_Meeting>[];

    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day, 9, 0, 0);

    appointment.add(_Meeting('Character(2 Lectures) With Mr.simon', date,
        date.add(const Duration(hours: 1)), Colors.red, false, '', ''));

    appointment.add(_Meeting('key', date.add(const Duration(hours: 2)),
        date.add(const Duration(hours: 3)), Colors.red, false, '', ''));

    appointment.add(_Meeting('key', date.add(const Duration(hours: 4)),
        date.add(const Duration(hours: 5)), Colors.red, false, '', ''));

    appointment.add(_Meeting('key', date.add(const Duration(hours: 7)),
        date.add(const Duration(hours: 8)), Colors.red, false, '', ''));

    appointment.add(_Meeting('key', date.add(const Duration(hours: 10)),
        date.add(const Duration(hours: 12)), Colors.red, false, '', ''));

    for (int i = 0; i < appointment.length; i++) {
      _events.appointments.add(appointment[i]);
    }

    _events.notifyListeners(CalendarDataSourceAction.reset, appointment);
  }

  Widget _getAppointmentUI(
      BuildContext context, CalendarAppointmentDetails details) {
    final dynamic meetingData = details.appointments.first;
    late final _Meeting meeting;
    if (meetingData is _Meeting) {
      meeting = meetingData;
    }
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 5),
      height: 98,
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth < 940 ? 10 : 50),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MediaQuery.of(context).size.width < 1100
          ? _smBody(context,meeting)
          : _lgBody(context,meeting),
    );
  }

  Widget _smBody(BuildContext context,meeting) {

    SizeConfig().init(MediaQuery.of(context).size);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          meeting.eventName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          '${DateFormat('hh:mm a').format(meeting.from)} - '
              '${DateFormat('hh:mm a').format(meeting.to)}',
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: kTextGreyColor
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        const Text(
          'Join with zoom meeting',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _lgBody(BuildContext context,meeting) {

    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth> 1450?70:10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                meeting.eventName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${DateFormat('hh:mm a').format(meeting.from)} - '
                    '${DateFormat('hh:mm a').format(meeting.to)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color:kTextGreyColor,
                ),
              )
            ],
          ),
          const Spacer(),
          const Text(
            'Join with zoom meeting',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the calendar widget based on the properties passed.
  SfCalendar _getCustomizationCalendar(
      [CalendarDataSource? _calendarDataSource,
        CalendarAppointmentBuilder? appointmentBuilder]) {
    return SfCalendar(
        dataSource: _calendarDataSource,
        appointmentBuilder: appointmentBuilder,
        cellEndPadding: 3,
        timeSlotViewSettings: const TimeSlotViewSettings(
            timeIntervalHeight: 100,
            minimumAppointmentDuration: Duration(minutes: 60)));
  }
}

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.meetingLink, this.linkLabel);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String meetingLink;
  String linkLabel;
}
