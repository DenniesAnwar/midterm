class Member{
  String memberName='';
  String applicationStatus = '';
  bool applicationSent = false;
  String memberShipType = 'Member';
  String image = '';
  Member({this.image = 'assets/images/no_profile.png',this.memberName='Sabrina Jan',this.memberShipType='Member',this.applicationSent=true,this.applicationStatus='Online Interview'});
}

class MemberList{
  static List<Member> membersList = [
    Member(applicationStatus: 'Submitted'),
    Member(memberName: 'Karim Benmbarek'),
    Member(applicationStatus: 'Submitted',applicationSent: false),
    Member(applicationStatus: 'Submitted',memberName: 'Patil'),
  ];
}