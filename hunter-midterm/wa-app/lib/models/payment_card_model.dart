class PaymentCardModel{
  String imagePath;
  String title;
  int index;
  PaymentCardModel({required this.index,required this.imagePath,required this.title,});
}


class PaymentCardsTiles{
  static List paymentCardsData = [
    PaymentCardModel(index: 0,imagePath: 'assets/icons/credit-card.png', title: 'Credit Card', ),
    PaymentCardModel(index: 1,imagePath: 'assets/icons/google-card.png', title: 'Google Card',),
    PaymentCardModel(index: 2,imagePath: 'assets/icons/paypal.png', title: 'Paypal',),
    PaymentCardModel(index: 3,imagePath: 'assets/icons/apple-card.png', title: 'Apple Card',),
  ];
}