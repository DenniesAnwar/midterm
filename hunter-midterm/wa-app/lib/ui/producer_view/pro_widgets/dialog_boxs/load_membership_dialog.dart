import 'package:flutter/material.dart';
import 'package:wa_app/models/producer_membership_model.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_membership_card.dart';
import 'package:wa_app/utills/styles.dart';

showMembershipDialog(BuildContext context){
  return showDialog(context: context, builder: (context){
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 850,
        ),
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10,bottom: SizeConfig.heightMultiplier * 0.866,top: 10),
                    child: const CloseButton(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left:SizeConfig.heightMultiplier * 1.466,
                    right:SizeConfig.heightMultiplier * 1.466,
                    top:SizeConfig.heightMultiplier * 1.466,
                    bottom:SizeConfig.heightMultiplier * 0.466,
                  ),
                  child: Column(children: [
                    Text('Our Services Has Friendly packages',textAlign: TextAlign.center,style: kDashWidgetBigTitleBlackStyle.copyWith(
                      fontSize:SizeConfig.heightMultiplier * 2.834,
                      height: 1.6,
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 28.0,bottom: SizeConfig.heightMultiplier * 1.566),
                      child: Text('Update your plan to unlock that feature',textAlign: TextAlign.center,style: kDashWidgetBigTitleBlackStyle.copyWith(
                        fontSize: SizeConfig.heightMultiplier * 1.834,
                        height: 1.6,
                      ),),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...List.generate(ProducerMembershipPackages.membershipPackages.length, (index){
                          var item  = ProducerMembershipPackages.membershipPackages[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 20.0,top: SizeConfig.heightMultiplier * 2.166),
                            child: MembershipCard(membershipModel: item,),
                          );
                        }),
                      ],
                    ),
                  ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  });
}
