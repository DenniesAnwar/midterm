import 'package:flutter/material.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/pro_general_widgets.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/footer_widget.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

class ScriptSubmittedToMarketPlace extends StatefulWidget {
  const ScriptSubmittedToMarketPlace({Key? key}) : super(key: key);

  @override
  _ScriptSubmittedToMarketPlaceState createState() =>
      _ScriptSubmittedToMarketPlaceState();
}

class _ScriptSubmittedToMarketPlaceState
    extends State<ScriptSubmittedToMarketPlace> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
        child: Scaffold(
      body:  MediaQuery.of(context).size.height < 710 || MediaQuery.of(context).size.width < 920 ?_smBody(context):_lgBody(context),
    ));
  }

  _loadBackToHome(BuildContext context)=>InkWell(
    onTap: (){
      //context.beamToNamed(Routes.s);
    },
    child: Text(
      'Back To Home Page',
      overflow: TextOverflow.ellipsis,
      style: kProfileNameTextStyle.copyWith(
        fontSize: SizeConfig.screenWidth > 1400 ? 22 : 14,
        decoration: TextDecoration.underline,
        color: Colors.blue,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _lgBody(BuildContext context){
    SizeConfig().init(MediaQuery.of(context).size);
    return Column(
      children: [
        const LoadMenu(),
        Center(
          child: Padding(
            padding:
            EdgeInsets.only(top: SizeConfig.heightMultiplier * 9.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tickMark(hSize: 42.25, vSize: 42.25, icoSize: 32),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Text(
                  'You have submitted your script',
                  style: kProfileNameTextStyle.copyWith(
                    color: kGreenColor,
                    fontSize: SizeConfig.screenWidth > 1400 ? 28 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                SizedBox(
                  width: 480,
                  child: Text(
                    loremIpsumText,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: kProfileNameTextStyle.copyWith(
                      fontSize: SizeConfig.screenWidth > 1400 ? 18 : 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                _loadBackToHome(context),
              ],
            ),
          ),
        ),
        const Spacer(),
        const Footer(),
      ],
    );
  }

  Widget _smBody(BuildContext context){

    SizeConfig().init(MediaQuery.of(context).size);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const LoadMenu(),
          Center(
            child: Padding(
              padding:
              EdgeInsets.only(top: SizeConfig.heightMultiplier * 9.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tickMark(hSize: 42.25, vSize: 42.25, icoSize: 32),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  Text(
                    'You have submitted your script',
                    style: kProfileNameTextStyle.copyWith(
                      color: kGreenColor,
                      fontSize: SizeConfig.screenWidth > 1400 ? 28 : 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  SizedBox(
                    width: 480,
                    child: Text(
                      loremIpsumText,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: kProfileNameTextStyle.copyWith(
                        fontSize: SizeConfig.screenWidth > 1400 ? 18 : 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  _loadBackToHome(context),
                ],
              ),
            ),
          ),
          const SizedBox(
            height:200,
          ),
          const Footer(),
        ],
      ),
    );
  }


}


showScriptSubmittedDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            child: SizedBox(
              height: 230,
              width: 550,
              child: Padding(
                padding:
                EdgeInsets.only(top: SizeConfig.heightMultiplier * 3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tickMark(hSize: 42.25, vSize: 42.25, icoSize: 35),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Text(
                      'You have submitted your script',
                      style: kProfileNameTextStyle.copyWith(
                        color: kGreenColor,
                        fontSize: SizeConfig.screenWidth > 1400 ? 28 : 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    SizedBox(
                      width: 480,
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: kProfileNameTextStyle.copyWith(
                          fontSize: SizeConfig.screenWidth > 1400 ? 18 : 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    _loadBackToHome(context),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
_loadBackToHome(BuildContext context)=>InkWell(
  onTap: (){
    //context.beamToNamed(Routes.s);
  },
  child: Text(
    'Check my scripts',
    overflow: TextOverflow.ellipsis,
    style: kProfileNameTextStyle.copyWith(
      fontSize: SizeConfig.screenWidth > 1400 ? 22 : 14,
      decoration: TextDecoration.underline,
      color: Colors.blue,
      fontWeight: FontWeight.w700,
    ),
  ),
);