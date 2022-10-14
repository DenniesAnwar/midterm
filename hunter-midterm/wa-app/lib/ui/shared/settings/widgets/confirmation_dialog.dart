import 'package:flutter/material.dart';
import 'package:wa_app/utills/colors.dart';

class ConfiramtionDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function callback;

  const ConfiramtionDialog(
      {Key? key,
      required this.title,
      required this.message,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 136,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Spacer(),
              _getButton(true, () => Navigator.of(context).pop()),
              const SizedBox(
                width: 8,
              ),
              _getButton(false, callback),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  _getButton(bool isBtnCancel, dynamic callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: isBtnCancel ? kRedColor : kPrimaryColor)),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Text(
          isBtnCancel ? "Cancel" : "Update",
          style: TextStyle(color: isBtnCancel ? kRedColor : kPrimaryColor),
        ),
      ),
    );
  }
}
