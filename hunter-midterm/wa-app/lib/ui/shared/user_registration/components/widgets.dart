import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/routes.dart';
import 'package:wa_app/utills/styles.dart';
import 'package:beamer/beamer.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: kFieldTitleStyle,
      ),
    );
  }
}

customDivider() => Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Row(
        children: const [
          Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Or'),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );

loadingWidget({String title = 'Please Wait...'}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          image: AssetImage('assets/images/img_logo.png'),
          height: 100,
          width: 150,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 18,
            ),
            const CircularProgressIndicator()
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    ),
  );
}

class LoadMenu extends StatelessWidget {
  const LoadMenu({Key? key, this.isLogin = false}) : super(key: key);
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.widthMultiplier * 1.95,
        right: SizeConfig.widthMultiplier * 1.95,
        top: SizeConfig.heightMultiplier * 1.079,
        bottom: SizeConfig.heightMultiplier * 1.079,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
              visible: SizeConfig.screenWidth > 720, child: loadLogoWithText()),
          Visibility(
              visible: SizeConfig.screenWidth > 720, child: const Spacer()),
          LoadMenuLinks(
            onTapped: () {},
            title: 'Our blogs',
          ),
          LoadMenuLinks(
            onTapped: () {},
            title: 'Our courses',
          ),
          Buttons.customPrimaryButton(
            buttonHeight: SizeConfig.screenWidth < 920 ? 30 : 50,
            buttonWidth: SizeConfig.screenWidth < 920 ? 100.78 : 178.78,
            fontSize: SizeConfig.screenWidth < 920 ? 14 : 20,
            onPressed: () {
              if (isLogin) {
                context.beamToNamed(Routes.registration);
              } else {
                context.beamToNamed(Routes.login);
              }
            },
            title: isLogin ? 'Sign Up' : 'Sign In',
          )
        ],
      ),
    );
  }
}

class LoadMenuLinks extends StatelessWidget {
  const LoadMenuLinks({Key? key, required this.onTapped, required this.title})
      : super(key: key);
  final String title;
  final Function onTapped;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth < 920 ? 16 : 32,
          vertical: SizeConfig.screenWidth < 920 ? 16 : 32),
      child: InkWell(
          onTap: () {
            onTapped();
          },
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.screenWidth < 1400 ? 14 : 20,
            ),
          )),
    );
  }
}
