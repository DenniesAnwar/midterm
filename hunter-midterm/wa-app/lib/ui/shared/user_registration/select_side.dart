// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/routes.dart';

import 'components/widgets.dart';

class SelectSideScreen extends StatefulWidget {
  const SelectSideScreen({Key? key}) : super(key: key);

  @override
  _SelectSideScreenState createState() => _SelectSideScreenState();
}

class _SelectSideScreenState extends State<SelectSideScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              gradientColor.withOpacity(0.72),
              gradientColor,
            ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LoadMenu(),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1200,
                  ),
                  child: Column(
                    children: [
                      _loadBigTitle(),
                      _loadDescription(),
                      Center(
                        child: SizeConfig.screenWidth < 950
                            ? _smBody()
                            : _lgBody(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.heightMultiplier * 3.809,
                    top: SizeConfig.heightMultiplier * 15.809,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: _loadStatementPolicyDocs(
                                  title: 'Privacy Policy', onPressed: () {}))),
                      SizedBox(
                        width: SizeConfig.heightMultiplier * 2.901,
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: _loadStatementPolicyDocs(
                                  title: 'Terms & Condition',
                                  onPressed: () {}))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadBigTitle() => Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier * 6.29,
            bottom: SizeConfig.heightMultiplier * 3.016),
        child: Text(
          'Which Are You?',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: SizeConfig.screenWidth < 920
                  ? SizeConfig.screenHeight < 500
                      ? 16
                      : 32
                  : SizeConfig.heightMultiplier * 4.77,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      );

  _loadDescription() => Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 5.49),
        child: Text(
          'Choose your path to gain access to WO.',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: SizeConfig.screenWidth < 920 ? 13 : 16,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      );

  Widget _lgBody() {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 6.45),
      child: SizedBox(
        width: 1020,
        child: Row(
          children: [
            _loadChoiceSide(
                onPressed: () => _selectedSide(context, false),
                imagePath: 'assets/icons/screen_writer.svg',
                title: 'I\'m a Screenwriter',
                description: screenWriterChoosingDescription),
            const Spacer(),
            _loadChoiceSide(
                onPressed: () => _selectedSide(context, true),
                imagePath: 'assets/icons/producer.svg',
                title: 'I\'m a Producer',
                description: producerChoosingDescription),
          ],
        ),
      ),
    );
  }

  _selectedSide(BuildContext context, bool value) {
    context.beamToNamed(
        value ? Routes.producerSelctionPage : Routes.writerSelectionPage);
    Provider.of<UserProvider>(context, listen: false).isProducer = value;
  }

  Widget _smBody() {
    return SizedBox(
      width: 520,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          _loadChoiceSide(
              onPressed: () => _selectedSide(context, false),
              imagePath: 'assets/icons/screen_writer.svg',
              title: 'I\'m a Screenwriter',
              description: screenWriterChoosingDescription),
          const SizedBox(
            height: 50,
          ),
          _loadChoiceSide(
              onPressed: () => _selectedSide(context, true),
              imagePath: 'assets/icons/producer.svg',
              title: 'I\'m a Producer',
              description: producerChoosingDescription),
        ],
      ),
    );
  }

  Widget _loadChoiceSide(
          {required Function onPressed,
          required String imagePath,
          required String title,
          required String description}) =>
      Column(
        children: [
          SvgPicture.asset(
            imagePath,
            width: SizeConfig.screenWidth < 920
                ? 90
                : SizeConfig.widthMultiplier * 4.687,
            height: SizeConfig.screenHeight < 500
                ? 78
                : SizeConfig.heightMultiplier * 7.613,
          ),
          InkWell(
            onTap: () {
              onPressed();
            },
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 50,
                minWidth: 96,
              ),
              height: SizeConfig.screenWidth < 920
                  ? 72
                  : SizeConfig.heightMultiplier * 4.638,
              width: SizeConfig.screenWidth < 920
                  ? 296
                  : SizeConfig.widthMultiplier * 11.5652,
              margin: EdgeInsets.only(
                  top: SizeConfig.heightMultiplier * 1.86,
                  bottom: SizeConfig.heightMultiplier * 1.86),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.heightMultiplier * 4.48),
                ),
              ),
              child: Center(
                  child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                    fontSize: SizeConfig.screenWidth < 920
                        ? 16
                        : SizeConfig.heightMultiplier * 1.89),
              )),
            ),
          ),
          SizedBox(
            width: 459,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.screenWidth < 920 ? 13 : 15,
                  height: 1.6,
                  color: Colors.white),
            ),
          ),
        ],
      );

  Widget _loadStatementPolicyDocs(
          {required String title, required Function onPressed}) =>
      InkWell(
        onTap: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white38,
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.screenWidth < 920 ? 15 : 18,
          ),
        ),
      );
}
