import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/models/producer_membership_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_general_widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({Key? key, required this.membershipModel})
      : super(key: key);
  final ProducerMembershipModel membershipModel;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 340,
        minWidth: 130,
      ),
      padding: EdgeInsets.only(
          left: SizeConfig.widthMultiplier * 1.796,
          right: SizeConfig.widthMultiplier * 1.796,
          top: SizeConfig.heightMultiplier * 2.126),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    '\$ ${membershipModel.amount.toInt()}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        letterSpacing: 0,
                        color: kPrimaryColor),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '/${membershipModel.packageDuration}',
                    style: kTextFieldHintStyle.copyWith(
                      textBaseline: TextBaseline.ideographic,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 9,
              bottom: 10,
            ),
            child: Text(
              membershipModel.membershipTitle,
              style: kProfileNameTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3.633),
            child: Text(
              membershipModel.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: kTextFieldHintStyle.copyWith(color: Colors.black87),
            ),
          ),
          ...List.generate(membershipModel.features.length, (index) {
            MembershipFeature item = membershipModel.features[index];

            return FeatureTile(
                title: item.title, isOptionIncluded: item.isOptionIncluded);
          }),
          Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.heightMultiplier * 1.493,
                top: SizeConfig.heightMultiplier * 4.854),
            child: InkWell(
              onTap: () {},
              child: Buttons.customPrimaryButton(
                  buttonHeight: SizeConfig.screenWidth < 920?72:SizeConfig.heightMultiplier * 5.854,
                  fontSize: 17,
                  title: 'Get Started',
                  onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  const FeatureTile(
      {Key? key, required this.title, required this.isOptionIncluded})
      : super(key: key);
  final String title;
  final bool isOptionIncluded;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3.036),
      child: Row(
        children: [
          tickMark(
              icoBackgroundColor:
                  isOptionIncluded ? kLightGreenColor : Colors.black26),
          const SizedBox(width: 22.24),
          Expanded(
            child: Text(
              title,
              style: kMemberShipCardTileStyle,
            ),
          ),
        ],
      ),
    );
  }
}
