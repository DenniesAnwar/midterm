class ProducerMembershipModel{
  String membershipTitle;
  String description;
  double amount;
  List<MembershipFeature> features;
  String packageDuration;
  ProducerMembershipModel({required this.amount,required this.description,required this.features,required this.membershipTitle,required this.packageDuration});
}



class MembershipFeature{
  bool isOptionIncluded;
  String title;
  MembershipFeature({required this.isOptionIncluded,required this.title});
}


class ProducerMembershipPackages{
  static List membershipPackages = [
    ProducerMembershipModel(
        amount: 25.00,
        description: 'Available for business with large payments business models',
        features:[
          MembershipFeature(isOptionIncluded: true, title: 'Treatment'),
          MembershipFeature(isOptionIncluded: true, title: 'Full Screenplay (6-12 Months)'),
          MembershipFeature(isOptionIncluded: true, title: 'Option Extension'),
          MembershipFeature(isOptionIncluded: false, title: 'Comittion Work'),
          MembershipFeature(isOptionIncluded: false, title: 'First Look'),
        ],
        membershipTitle: 'Basic',
        packageDuration: 'month'
    ),
    ProducerMembershipModel(
        amount: 50.00,
        description: 'Available for business with large payments business models',
        features:[
          MembershipFeature(isOptionIncluded: true, title: 'First Look'),
          MembershipFeature(isOptionIncluded: true, title: 'Treatment'),
          MembershipFeature(isOptionIncluded: true, title: 'Full Screenplay (6-12 Months)'),
          MembershipFeature(isOptionIncluded: true, title: 'Option Extension'),
          MembershipFeature(isOptionIncluded: true, title: 'Comittion Work'),
        ],
        membershipTitle: 'Premium',
        packageDuration: 'month'
    ),
  ];
}