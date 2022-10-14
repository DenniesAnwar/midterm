import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

import '../pro_general_widgets.dart';

paymentDoneDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return PaymentDoneWidget(exploreApp: (){}, choicePoint: 'Treatment',);
      });
}

class PaymentDoneWidget extends StatefulWidget {
  const PaymentDoneWidget({Key? key,required this.choicePoint,required this.exploreApp}) : super(key: key);
  final String choicePoint;
  final Function exploreApp;
  @override
  _PaymentDoneWidgetState createState() => _PaymentDoneWidgetState();
}

class _PaymentDoneWidgetState extends State<PaymentDoneWidget> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Card(
            elevation: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(34.61),
                child: Column(
                  children:  [
                    const SizedBox(height: 20,),
                    tickMark(icoColor: kLightGreenColor,icoBackgroundColor: Colors.white,icoSize: 61.64,hSize: 63.64,vSize: 63.64),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,),
                      child: Text(
                        'Payment Done',
                        textAlign: TextAlign.center,
                        style: kDashWidgetBigTitleBlackStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'The ${widget.choicePoint} has been unlocked',
                        textAlign: TextAlign.center,
                        style: kDashWidgetBigTitleBlackStyle.copyWith(
                          color: Colors.black38,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: Buttons.customPrimaryButton(
                          onPressed: () {
                            widget.exploreApp();
                          },
                          title: 'Explore app',
                          buttonHeight: 30,
                          borderRoundness: 3,
                          fontSize: 9,
                          buttonWidth: 90),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}







