// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/providers/image_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/shared/settings/account_settings.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/routes.dart';
import 'package:wa_app/utills/styles.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton({Key? key}) : super(key: key);
  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  late double heightSize;
  late double widthSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    heightSize = SizeConfig.heightMultiplier;
    widthSize = SizeConfig.widthMultiplier;

    return Consumer<UserProvider>(
      builder: (__, userProvider, _) {
        return MediaQuery.of(context).size.width < 1100
            ? _smBody(userProvider)
            : _lgBody(userProvider);
      },
    );
  }

  Widget _lgBody(UserProvider userProvider) {
    return Row(
      children: [
        Consumer<ImageUploadingProvider>(builder: (__, _imageProvider, _) {
          return Padding(
            padding: EdgeInsets.only(
                right: widthSize * 0.3125, left: widthSize * 0.7125),
            child: _imageProvider.imageModel != null
                ? loadAnImage(_imageProvider.imageModel!.avatarUrl!)
                : userProvider.userInfo!.avatarUrl != null
                    ? loadAnImage(userProvider.userInfo!.avatarUrl)
                    : imageContainer(
                        imagePath: 'assets/images/no_profile.png',
                        containerHeight: 42,
                        containerWidth: 42,
                      ),
          );
        }),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Consumer<ScreenWriterProvider>(
                        builder: (__, writerProvider, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.userInfo!.name ?? 'Name',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            style: kProfileNameTextStyle.copyWith(
                                fontSize:
                                    SizeConfig.screenWidth < 1410 ? 12 : 14),
                          ),
                          writerProvider.isScreenWriter
                              ? inProgram()
                              : Container()
                        ],
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: widthSize * 0.585),
                    child: SvgPicture.asset(
                      'assets/icons/down_arrow.svg',
                      height: 5,
                      width: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<ScreenWriterProvider>(builder: (__, writerProvider, _) {
                return Visibility(
                  visible: !writerProvider.isScreenWriter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: applyToProgramButton(context),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _smBody(UserProvider userProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<ImageUploadingProvider>(builder: (__, _imageProvider, _) {
          return Padding(
              padding: EdgeInsets.only(
                  right: widthSize * 0.3125, left: widthSize * 0.7125),
              child: _imageProvider.imageModel != null
                  ? loadAnImage(_imageProvider.imageModel!.avatarUrl!)
                  : userProvider.userInfo!.avatarUrl != null
                      ? loadAnImage(userProvider.userInfo!.avatarUrl)
                      : imageContainer(
                          imagePath: 'assets/images/no_profile.png',
                          containerHeight: 42,
                          containerWidth: 42,
                        ));
        }),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ScreenWriterProvider>(
                      builder: (__, writerProvider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.userInfo!.name ?? 'Name',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          style: kProfileNameTextStyle.copyWith(
                              fontSize: SizeConfig.screenWidth < 1110
                                  ? 9
                                  : SizeConfig.screenWidth < 1510
                                      ? 12
                                      : 14),
                        ),
                        writerProvider.isScreenWriter
                            ? inProgram()
                            : Container()
                      ],
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(right: widthSize * 0.585),
                    child: SvgPicture.asset(
                      'assets/icons/down_arrow.svg',
                      height: 5,
                      width: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Consumer<ScreenWriterProvider>(builder: (__, writerProvider, _) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: writerProvider.isScreenWriter ? 2 : 5),
                  child: !writerProvider.isScreenWriter
                      ? applyToProgramButton(context)
                      : Container(),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

inProgram() => const Padding(
      padding: EdgeInsets.only(top: 3.4),
      child: Text('In Program',
          style: TextStyle(color: kGreenColor, fontSize: 11)),
    );

applyToProgramButton(BuildContext context) => Buttons.customPrimaryButton(
    onPressed: () => context.beamToNamed(Routes.screenWriterApplicationForm),
    buttonColor: kPrimaryColor,
    buttonHeight: 33,
    fontSize: SizeConfig.screenWidth < 1400 ? 9 : 13,
    buttonWidth: 128,
    fontWeight: FontWeight.w500,
    borderRoundness: 3,
    title: 'Apply to program');
