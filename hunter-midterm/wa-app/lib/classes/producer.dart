class Producer {
  bool onlineStatus = false;
  String name = '';
  bool isPremium = false;
  String memberShipType = 'Member';
  double scriptsPurchased = 2.0;
  double treatmentsPurchased = 5.0;
  Producer(
      {this.name = 'Sabrina Jan',
      this.onlineStatus = false,
      this.isPremium = false,
      this.scriptsPurchased = 2.0,
      this.memberShipType = 'Member',
      this.treatmentsPurchased = 5.0});
}

class ProducerList {
  static List<Producer> producerList = [
    Producer(onlineStatus: true),
    Producer(onlineStatus: false, name: 'Mark'),
    Producer(onlineStatus: true, name: 'Larry Page', isPremium: true),
    Producer(onlineStatus: true, name: 'Bill Gates'),
    Producer(
        onlineStatus: true,
        name: 'Steve Jobs',
        isPremium: true,
        memberShipType: 'Admin',
        scriptsPurchased: 10,
        treatmentsPurchased: 12),
  ];
}
