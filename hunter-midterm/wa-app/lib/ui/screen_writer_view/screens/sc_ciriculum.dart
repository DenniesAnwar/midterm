import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

class ScCurriculum extends StatefulWidget {
  const ScCurriculum({Key? key}) : super(key: key);

  @override
  _ScCurriculumState createState() => _ScCurriculumState();
}

class _ScCurriculumState extends State<ScCurriculum> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(MediaQuery.of(context).size);

    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 42,left: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Ciriculum',
                      style: kDashWidgetBigTitleStyle.copyWith(
                        fontSize: SizeConfig.screenHeight > 680 ?SizeConfig.heightMultiplier * 2.857:22,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.add_alert_rounded,
                      size: SizeConfig.screenWidth < 1400?22:25,
                    ),
                    SizedBox(width: SizeConfig.screenWidth>1400?280:200,child: const ProfileButton()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 34,left: 32),
                child: Text('For Mathematics',style: kProfileNameTextStyle.copyWith(fontSize: SizeConfig.screenHeight < 680?15:30,),),
              ),
              Container(
                decoration: const BoxDecoration(
                  //border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(6),),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 41.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7),
                child: Text(story,textAlign: TextAlign.justify,style: kProfileNameTextStyle.copyWith(fontSize: SizeConfig.screenWidth < 1400?21:26,height: 3),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
