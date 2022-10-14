import 'package:flutter/material.dart';
import 'package:wa_app/models/producer_membership_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_membership_card.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/utills/styles.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier * 1.328,
                      top: SizeConfig.heightMultiplier * 2.613,
                      bottom: SizeConfig.heightMultiplier * 2.613),
                  child: InkWell(onTap: () {}, child: const ProfileButton()),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Our Services Has Friendly packages',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: kDashWidgetBigTitleBlackStyle.copyWith(
                          fontSize: SizeConfig.screenWidth < 920
                              ? 20
                              : 40, //SizeConfig.heightMultiplier*2.854,
                          height: 1.6,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2.166,
                            bottom: SizeConfig.heightMultiplier * 2.874),
                        child: Text(
                          'Update your plan to unlock that feature',
                          textAlign: TextAlign.center,
                          style: kDashWidgetBigTitleBlackStyle.copyWith(
                            fontSize: SizeConfig.screenWidth < 920
                                ? 14
                                : 20, //SizeConfig.heightMultiplier*1.493,
                            height: 1.6,
                          ),
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ...List.generate(
                              ProducerMembershipPackages
                                  .membershipPackages.length, (index) {
                            var item = ProducerMembershipPackages
                                .membershipPackages[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.widthMultiplier * 0.783,
                                  top: SizeConfig.heightMultiplier * 2.226),
                              child: MembershipCard(
                                membershipModel: item,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
