import 'package:flutter/material.dart';

class CheckoutCancelPage extends StatelessWidget {
  const CheckoutCancelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Subscription failed, try again",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
