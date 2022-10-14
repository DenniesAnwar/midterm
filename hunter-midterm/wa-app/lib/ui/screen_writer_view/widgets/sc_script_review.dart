import 'package:flutter/material.dart';
import 'package:wa_app/models/sc_script_review_model.dart';
import 'package:wa_app/utills/colors.dart';

class ScScriptReview extends StatefulWidget {
  final ScScriptReviewModle _modle;
  const ScScriptReview(this._modle, {Key? key}) : super(key: key);

  @override
  _ScScriptReviewState createState() => _ScScriptReviewState();
}

class _ScScriptReviewState extends State<ScScriptReview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              widget._modle.reviewer,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "(${widget._modle.points})",
              style: const TextStyle(
                  color: kOrangeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )
          ]),
          const SizedBox(
            height: 4,
          ),
          Text(
            widget._modle.date,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            widget._modle.review,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
