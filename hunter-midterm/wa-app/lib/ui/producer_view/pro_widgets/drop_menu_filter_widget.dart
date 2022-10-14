import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class FilterDropDownMenu extends StatefulWidget {
  const FilterDropDownMenu(
      {Key? key,
      this.applyBorder = false,
      required this.optionList,
      this.width = 200,
      required this.onChangedFunction})
      : super(key: key);
  final List<String> optionList;
  final Function(String) onChangedFunction;
  final bool applyBorder;
  final double width;
  @override
  _FilterDropDownMenuState createState() => _FilterDropDownMenuState();
}

class _FilterDropDownMenuState extends State<FilterDropDownMenu> {
  String _initialValue = '';
  @override
  void initState() {
    _initialValue = widget.optionList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return Container(
      width: widget.width,
      padding: const EdgeInsets.only(left: 4, right: 8),
      decoration: BoxDecoration(
        color: kDropdownContainerColor,
        border: Border.all(
            color: widget.applyBorder ? Colors.black : Colors.transparent,
            width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,

        style: kProfileNameTextStyle.copyWith(
            fontSize: 12, fontWeight: FontWeight.w600),
        value: _initialValue,
        icon: SvgPicture.asset(
          'assets/icons/down_arrow.svg',
        ),
        //  iconSize: SizeConfig.screenWidth < 700 ? 13 : 22,
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            _initialValue = newValue!;
            widget.onChangedFunction(_initialValue);
          });
        },
        items: widget.optionList.map<DropdownMenuItem<String>>((String? value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              padding: const EdgeInsets.only(right: 25.0),
              margin: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value!,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
