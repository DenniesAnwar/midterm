import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/providers/image_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/auth_services/auth_services.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/settings/account_settings.dart';
import 'package:wa_app/ui/shared/settings/widgets/confirmation_dialog.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

class PasswordAndSecurity extends StatefulWidget {
  const PasswordAndSecurity({Key? key}) : super(key: key);

  @override
  _PasswordAndSecurityState createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  double hPadding = 0.0;

  final Map<String, dynamic> _formData = {};

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  double labelFontSize = 15;
  double vPadding = 10;
  late ImageUploadingProvider _imageProvider;
  late UserProvider _userProvider;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  String _infoText = "";
  bool _showUserInfo = false;
  @override
  void initState() {
    _imageProvider =
        Provider.of<ImageUploadingProvider>(context, listen: false);
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    hPadding = SizeConfig.screenWidth < 820
        ? SizeConfig.widthMultiplier * 3.125
        : SizeConfig.widthMultiplier * 4.125;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth < 1500 ? 35 : 62.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeConfig.screenWidth < 1450 ? 450 : 680,
                    ),
                    child: _loadForm(),
                  ),
                ),
                if (_showUserInfo)
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      _infoText,
                      style: TextStyle(
                          color: _infoText == passwordUpdateSuccessMessage
                              ? kGreenColor
                              : kRedColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    left: hPadding + 30,
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Buttons.customPrimaryButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Helpers.showAppDialog(
                                context: context,
                                widget: ConfiramtionDialog(
                                    title: "Update Password",
                                    message:
                                        "Are you sure want to update password",
                                    callback: _submitData));
                          } else {
                            setState(() {
                              _autoValidate = AutovalidateMode.always;
                            });
                          }
                        },
                        title: 'Save changes',
                        buttonHeight: SizeConfig.screenWidth < 1400 ? 35 : 50,
                        buttonWidth: 162,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        borderRoundness: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 7.269,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submitData() async {
    Navigator.of(context).pop();
    Helpers.showAppDialog(context: context, widget: loadingWidget());
    _infoText = await FirebaseAuthServices.updateUserPassword(
        context: context,
        password: _formData['current_password'],
        newPassword: _formData['new_password']);

    setState(() {
      _showUserInfo = true;
    });
    Navigator.of(context).pop();
  }

  _onSaved(String key, String value) {
    _formData[key] = value;
  }

  _loadForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth < 920
              ? SizeConfig.widthMultiplier * 3.125
              : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.screenWidth < 820
                  ? SizeConfig.heightMultiplier * 3.125
                  : 0,
            ),
            child: Text(
              'Security',
              overflow: TextOverflow.ellipsis,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenHeight < 680
                    ? 21
                    : SizeConfig.heightMultiplier * 3.136,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 1.584),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_imageProvider.imageModel != null)
                  loadAnImage(_imageProvider.imageModel!.avatarUrl!)
                else if (_userProvider.user!.photoURL != null)
                  loadAnImage(_userProvider.user!.photoURL!)
                else
                  imageContainer(
                    imagePath: 'assets/images/no_profile.png',
                    containerHeight: 52,
                    containerWidth: 52,
                  ),
                // 128
                Consumer<UserProvider>(builder: (_, uProvider, __) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.widthMultiplier * 0.580),
                    child: Text(
                      uProvider.userInfo!.name ?? 'Name',
                      overflow: TextOverflow.ellipsis,
                      style: kDashWidgetBigTitleBlackStyle.copyWith(
                          fontSize: SizeConfig.screenHeight < 680
                              ? 15
                              : SizeConfig.heightMultiplier * 2.31), // 31
                    ),
                  );
                }),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: SizeConfig.screenWidth > 920
          //         ? SizeConfig.heightMultiplier * 2.815
          //         : vPadding,
          //     bottom: SizeConfig.screenWidth > 920
          //         ? SizeConfig.heightMultiplier * 2.815
          //         : vPadding + 5,
          //   ),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(
          //             right: SizeConfig.widthMultiplier * 1.093), // 28
          //         child: Text(
          //           'Active Status',
          //           overflow: TextOverflow.ellipsis,
          //           style: kDashWidgetBigTitleBlackStyle.copyWith(
          //               fontSize: SizeConfig.screenHeight < 680 ? 13 : 19),
          //         ),
          //       ),
          //       Expanded(
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: CupertinoSwitch(
          //             onChanged: (bool value) {
          //               setState(() {
          //                 _statusValue = !_statusValue;
          //               });
          //             },
          //             value: _statusValue,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       bottom: SizeConfig.screenWidth > 820
          //           ? SizeConfig.heightMultiplier * 3.136
          //           : vPadding + 10),
          //   child: RichText(
          //     maxLines: 3,
          //     overflow: TextOverflow.ellipsis,
          //     text: TextSpan(
          //         text:
          //             'Your friends will see when you\'re active or that you were recently active.',
          //         style: kDashWidgetBigTitleBlackStyle.copyWith(
          //             fontSize: SizeConfig.screenHeight < 680 ? 12 : 15,
          //             fontWeight: FontWeight.w400,
          //             color: Colors.black38),
          //         children: [
          //           TextSpan(
          //             text:
          //                 'you\'ll appear as active or recently active unless you turn off the setting',
          //             style: kDashWidgetBigTitleBlackStyle.copyWith(
          //                 fontSize: SizeConfig.screenHeight < 680 ? 12 : 15,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.black54),
          //           ),
          //         ]),
          //   ),
          // ),

          const SizedBox(
            height: 22,
          ),
          SizedBox(
            width: 650,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 190,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.screenWidth > 820
                                  ? SizeConfig.heightMultiplier * 1.415
                                  : 8),
                          child: Text(
                            'Current Password',
                            overflow: TextOverflow.ellipsis,
                            style: kProfileNameTextStyle.copyWith(fontSize: 13),
                          ),
                        ),
                        TextFields.withController(
                            borderRoundness: 15,
                            hint: 'xxxxxxxxx',
                            mapKey: 'current_password',
                            onSaved: _onSaved,
                            secureText: true,
                            onTapped: () {},
                            controller: _currentPasswordController,
                            errorMessage:
                                'Please provide your current password'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.screenWidth > 820
                          ? SizeConfig.heightMultiplier * 1.643
                          : 10,
                      bottom: SizeConfig.screenWidth > 820
                          ? SizeConfig.heightMultiplier * 1.643
                          : 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenWidth > 820
                                        ? SizeConfig.heightMultiplier * 0.915
                                        : 8),
                                child: Text(
                                  'New Password',
                                  overflow: TextOverflow.ellipsis,
                                  style: kProfileNameTextStyle.copyWith(
                                      fontSize: 13),
                                ),
                              ),
                              TextFields.withController(
                                  controller: _newPasswordController,
                                  borderRoundness: 15,
                                  hint: 'New Password',
                                  mapKey: 'new_password',
                                  secureText: true,
                                  onSaved: _onSaved,
                                  errorMessage: 'New password required',
                                  onTapped: () {}),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenWidth > 820
                                        ? SizeConfig.heightMultiplier * 1.415
                                        : 8),
                                child: Text(
                                  'Confirm Password',
                                  overflow: TextOverflow.ellipsis,
                                  style: kProfileNameTextStyle.copyWith(
                                      fontSize: 13),
                                ),
                              ),
                              TextFields.withConfirmController(
                                  borderRoundness: 15,
                                  controller: _confirmPasswordController,
                                  confirmController: _newPasswordController,
                                  hint: 'Confirm Password',
                                  mapKey: 'confirm_password',
                                  secureText: true,
                                  isFilled: true,
                                  onSaved: _onSaved,
                                  errorMessage: 'Please confirm your password')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[50],
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.screenWidth > 820
                                    ? SizeConfig.heightMultiplier * 0.915
                                    : 8),
                            child: Text(
                              'Two-Factor Authentication',
                              overflow: TextOverflow.ellipsis,
                              style: kProfileNameTextStyle.copyWith(
                                  fontSize: SizeConfig.screenWidth > 1400
                                      ? 20
                                      : labelFontSize,
                                  color: kBorderColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.heightMultiplier * 2.643),
                            child: Text(
                              'We\'ll ask for a code in addition to your password when you log in on adevice we Don\'t recognize.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: kDashWidgetBigTitleBlackStyle.copyWith(
                                  color: kBorderColor,
                                  fontSize:
                                      SizeConfig.screenWidth > 1500 ? 17 : 13),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenWidth < 820
                                        ? SizeConfig.heightMultiplier * 0.915
                                        : 8),
                                child: Text(
                                  'Phone Number',
                                  overflow: TextOverflow.ellipsis,
                                  style: kProfileNameTextStyle.copyWith(
                                      fontSize: 13, color: kBorderColor),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: kBorderColor)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 4),
                                        child: const Text(
                                          "Phone number",
                                          style: TextStyle(color: kBorderColor),
                                        ),
                                      )),
                                  const Expanded(
                                    child: Text(
                                      "Comming soon",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
