import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget(
      {Key? key,
      required this.changePlan,
      required this.profileOnTapped,
      required this.isPremium})
      : super(key: key);
  final Function profileOnTapped;
  final Function changePlan;
  final bool isPremium;
  @override
  _ProfileInfoWidgetState createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Row(
      children: [
        Expanded(
          child: Text(
            'Script / Script Detail',
            style: sSmallTitleTextStyle.copyWith(
                fontSize: SizeConfig.screenWidth < 920 ? 14 : 18,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600),
          ),
        ),
        Buttons.customPrimaryButton(
            onPressed: () {
              widget.changePlan();
            },
            buttonHeight: 36,
            buttonColor: widget.isPremium ? Colors.orange : kPrimaryColor,
            fontSize: SizeConfig.screenWidth < 920 ? 13 : 16,
            buttonWidth: widget.isPremium ? 118 : 105,
            title: widget.isPremium ? 'Premium' : 'Basic',
            fontWeight: FontWeight.w600),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
              onTap: () {
                widget.profileOnTapped();
              },
              child: SizedBox(
                  width: SizeConfig.screenWidth > 1400 ? 280 : 200,
                  child: const ProfileButton()),),
        ),
      ],
    );
  }
}

class ProfileInfoAndGreetingWidget extends StatefulWidget {
  const ProfileInfoAndGreetingWidget(
      {Key? key,
      required this.isPremium,
      required this.greetingMsg,
      required this.changePlan,
      required this.profileOnTapped})
      : super(key: key);
  final Function profileOnTapped;
  final Function changePlan;
  final bool isPremium;
  final String greetingMsg;
  @override
  _ProfileInfoAndGreetingWidgetState createState() =>
      _ProfileInfoAndGreetingWidgetState();
}

class _ProfileInfoAndGreetingWidgetState
    extends State<ProfileInfoAndGreetingWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return SizeConfig.screenWidth < 820 ? _smBody() : _lgBody();
  }

  Widget _smBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.greetingMsg,
          style: sSmallTitleTextStyle.copyWith(
              fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Buttons.customPrimaryButton(
                onPressed: () {
                  widget.changePlan();
                },
                buttonHeight: 36,
                buttonColor: widget.isPremium ? Colors.orange : kPrimaryColor,
                fontSize: 16,
                buttonWidth: widget.isPremium ? 118 : 105,
                title: widget.isPremium ? 'Premium' : 'Basic',
                fontWeight: FontWeight.w600),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                  onTap: () {
                    widget.profileOnTapped();
                  },
                  child: SizedBox(width: SizeConfig.screenWidth>1400?280:194,child: const ProfileButton()),),
            ),
          ],
        ),
      ],
    );
  }

  Widget _lgBody() {
    return Row(
      children: [
        Text(
          widget.greetingMsg,
          style: sSmallTitleTextStyle.copyWith(
              fontSize: 24, color: Colors.blue, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Buttons.customPrimaryButton(
            onPressed: () {
              widget.changePlan();
            },
            buttonHeight: 36,
            buttonColor: widget.isPremium ? Colors.orange : kPrimaryColor,
            fontSize: 16,
            buttonWidth: widget.isPremium ? 118 : 105,
            title: widget.isPremium ? 'Premium' : 'Basic',
            fontWeight: FontWeight.w600),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
              onTap: () {
                widget.profileOnTapped();
              },
              child: SizedBox(width: SizeConfig.screenWidth>1400?280:200,child: const ProfileButton()),),
        ),
      ],
    );
  }
}
