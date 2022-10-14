import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/models/option_item_model.dart';
import 'package:wa_app/network/models/me_response.dart';
import 'package:wa_app/providers/image_provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_menu_items.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_widgets.dart';
import 'package:wa_app/utills/styles.dart';

class ProfileDetailView extends StatefulWidget {
  const ProfileDetailView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  bool _isLoading = false;
  late ScreenWriterProvider _screenWriterProvider;
  @override
  void initState() {
    _screenWriterProvider =
        Provider.of<ScreenWriterProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Consumer<UserProvider>(
      builder: (__, userProvider, _) {
        return Container(
          height: double.infinity,
          width: SizeConfig.widthMultiplier * 14.045,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 1.0, color: Colors.grey[300]!),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.widthMultiplier * 0.3125,
                      top: SizeConfig.heightMultiplier * 1.494,
                      right: 8),
                  child: const ProfileButton(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.heightMultiplier * 0.746),
                        child: Consumer<ImageUploadingProvider>(
                            builder: (__, imageProvider, _) {
                          return imageProvider.imageModel != null
                              ? _loadImage(imageProvider.imageModel!.avatarUrl!)
                              : userProvider.userInfo!.avatarUrl != null
                                  ? _loadImage(
                                      userProvider.userInfo!.avatarUrl!)
                                  : imageContainer(
                                      imagePath: 'assets/images/no_profile.png',
                                      containerHeight: 72,
                                      containerWidth: 72,
                                    );
                        })),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        userProvider.userInfo!.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: kProfileNameTextStyle.copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 1.494,
                          bottom: SizeConfig.heightMultiplier * 1.494),
                      child: SvgPicture.asset(
                        'assets/icons/writing.svg',
                        width: 17,
                        height: 17.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.heightMultiplier * 0.724,
                          top: SizeConfig.heightMultiplier * 0.224),
                      child: Align(
                        alignment: Alignment.center,
                        child: Consumer<ScScriptProvider>(
                            builder: (_, provider, __) {
                          return Text(
                            '${provider.totalScripts ?? 0}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: kProfileNameTextStyle.copyWith(fontSize: 15),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.heightMultiplier * 1.120),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Total Scripts',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: kProfileNameTextStyle.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 1.644),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/edit_icon.svg',
                              width: 17.5,
                              height: 17.5,
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 0.485,
                            ),
                            InkWell(
                              onTap: () {
                                Options item =
                                    _screenWriterProvider.isScreenWriter
                                        ? ScreenWriterViewSideMenuOptions
                                            .screenWriterSideMenuButtons[3]
                                        : ScreenWriterViewSideMenuOptions
                                            .nonScreenWriterSideMenuButtons[3];

                                _screenWriterProvider.activeWidgetIndex = 3;
                                _screenWriterProvider.activeWidget =
                                    item.loadWidget;
                              },
                              child: Text(
                                'Edit Profile',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: kProfileNameTextStyle.copyWith(
                                    fontSize: 14, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _loadCustomButton(title, callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.red[400], borderRadius: BorderRadius.circular(8)),
        width: SizeConfig.widthMultiplier * 15.445,
        child: Center(
          child: FittedBox(
            child: Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }

  bool _isVerified(SellerRequirements? requirements) {
    if (requirements == null) {
      return false;
    } else {
      Set<String> requirementsList = <String>{
        ...requirements.currentlyDue!,
        ...requirements.pastDue!,
        ...requirements.eventuallyDue!
      };

      if (requirementsList.isNotEmpty) {
        if (requirementsList.length == 1 &&
            requirementsList.contains('external_account')) {
          return true;
        }
        return false;
      }
      return true;
    }
  }

  _loadImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: SizedBox(
        height: 102,
        width: 102,
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
