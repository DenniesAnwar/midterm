class MeetingModel{
  String? url;
  String dateAndDay;
  String timeString;
  String meetingWithPersonName;
  String imagePath;
  String joinWithMeeting;
  MeetingModel({required this.imagePath,required this.timeString,required this.dateAndDay,required this.joinWithMeeting,required this.meetingWithPersonName,this.url});
}

class MeetingSchedules{
  static List meetings = [
    MeetingModel(
        imagePath: 'assets/icons/video-camera.png',
        timeString: '8:00 AM',
        dateAndDay: 'Jan 15 - Sunday',
        joinWithMeeting: 'Join With Zoom Meeting',
        meetingWithPersonName: 'John'
    ),
  ];
}