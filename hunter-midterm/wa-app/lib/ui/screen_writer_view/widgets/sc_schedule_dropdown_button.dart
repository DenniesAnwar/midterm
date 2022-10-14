import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/styles.dart';

class ScheduleDropDown extends StatefulWidget {
  const ScheduleDropDown({Key? key}) : super(key: key);

  @override
  _ScheduleDropDownState createState() => _ScheduleDropDownState();
}

class _ScheduleDropDownState extends State<ScheduleDropDown> {
  String _scheduleValue = 'Next Week';
  var size = const Size(200, 0.0);
  double widthSize = 0.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    widthSize = size.width;

    return Container(
      constraints: const BoxConstraints(
        minWidth: 70,
        maxWidth: 300,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 0.98,
          vertical: SizeConfig.heightMultiplier * 0.19),
      decoration: BoxDecoration(
        color: Colors.grey[100]!,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: DropdownButton<String>(
        alignment: AlignmentDirectional.center,
        value: _scheduleValue,
        icon: SvgPicture.asset(
          'assets/icons/down_arrow.svg',
          width: 11,
        ),
        iconSize: 15,
        elevation: 16,
        underline: Container(),
        onChanged: (String? newValue) {
          setState(() {
            _scheduleValue = newValue!;
          });
        },
        items: <String>[
          'Next Week',
          'Today',
          'Next Month',
          'Tommorow',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: kProfileNameTextStyle.copyWith(
                  fontSize: SizeConfig.heightMultiplier * 1.110,
                  fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
      ),
    );
  }
}
