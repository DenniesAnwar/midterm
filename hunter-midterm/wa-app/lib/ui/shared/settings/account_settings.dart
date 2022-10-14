import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/providers/image_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/auth_services/auth_services.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

import 'widgets/confirmation_dialog.dart';

class SharedAccountSettings extends StatefulWidget {
  const SharedAccountSettings({Key? key}) : super(key: key);

  @override
  _SharedAccountSettingsState createState() => _SharedAccountSettingsState();
}

class _SharedAccountSettingsState extends State<SharedAccountSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  double hPadding = 0.0;

  final Map<String, dynamic> _formData = {};

  late UserProvider _userProvider;
  late ImageUploadingProvider _imageProvider;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  bool _isLoading = false;
  bool _showInfo = false;
  bool _isSuccess = false;
  String _infoText = "";
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _imageProvider =
        Provider.of<ImageUploadingProvider>(context, listen: false);

    _formData['first_name'] = _userProvider.userInfo!.firstName!;
    _formData['last_name'] = _userProvider.userInfo!.lastName!;
    _formData['email'] = _userProvider.userInfo!.email!;
    _firstNameController = TextEditingController(text: _formData['first_name']);
    _lastNameController = TextEditingController(text: _formData['last_name']);
    _emailController = TextEditingController(text: _formData['email']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);
    hPadding = SizeConfig.screenWidth < 820
        ? SizeConfig.widthMultiplier * 3.125
        : SizeConfig.widthMultiplier * 7.125;
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
                      left: SizeConfig.screenHeight < 680 ? 35 : 62.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 650,
                    ),
                    child: _loadAccountSettingModule(),
                  ),
                ),
                if (_showInfo)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _infoText,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _isSuccess ? kGreenColor : kRedColor),
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: hPadding,
                        top: 20,
                      ),
                      child: Buttons.customPrimaryButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            Helpers.showAppDialog(
                                context: context,
                                widget: ConfiramtionDialog(
                                    title: "Update user data",
                                    message:
                                        "Are you sure want to update profile data",
                                    callback: _submitData));
                          } else {
                            setState(() {
                              _autoValidate = AutovalidateMode.always;
                            });
                          }
                        },
                        title: 'Save changes',
                        buttonHeight: SizeConfig.screenHeight < 680 ? 35 : 50,
                        buttonWidth: 162,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        borderRoundness: 10,
                      ),
                    ),
                  ],
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

    var resp = await _userProvider.updateCurrentUser({
      "first_name": _formData['first_name'],
      "last_name": _formData['last_name'],
      "country": _userProvider.userInfo!.country
    });

    if (resp != null) {
      if (_formData['email'] != _userProvider.userInfo!.email) {
        _infoText = await FirebaseAuthServices.resetEmail(_formData['email']);
        if (_infoText == 'Success') {
          setState(() {
            _isSuccess = true;
            _showInfo = true;
          });
        } else {
          setState(() {
            _isSuccess = false;
            _showInfo = true;
          });
        }
      } else {
        setState(() {
          _isSuccess = true;
          _showInfo = true;
          _infoText = "User info update successfully";
        });
      }
    } else {
      setState(() {
        _isSuccess = false;
        _showInfo = true;
        _infoText = "Sever error, please try again later";
      });
    }
    Navigator.of(context).pop();
  }

  _onSaved(String key, String value) {
    _formData[key] = value;
  }

  _loadAccountSettingModule() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth < 820
              ? SizeConfig.widthMultiplier * 3.125
              : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.heightMultiplier * 2.315,
              top: SizeConfig.screenWidth < 820
                  ? SizeConfig.heightMultiplier * 3.125
                  : 0,
            ),
            child: Text(
              'Account Settings',
              overflow: TextOverflow.ellipsis,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenHeight > 680
                    ? SizeConfig.heightMultiplier * 3.136
                    : 21,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 0.746),
            child: Text(
              'Personal Information',
              overflow: TextOverflow.ellipsis,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenHeight < 680
                    ? 15
                    : SizeConfig.heightMultiplier * 1.86,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 5.46),
            child: Text(
              'Lorem Ipsum is not simply random text. It has roots',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenHeight < 680
                    ? 12
                    : SizeConfig.heightMultiplier * 1.26,
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 0.746),
            child: Text(
              'Avatar',
              overflow: TextOverflow.ellipsis,
              style: kDashWidgetBigTitleBlackStyle.copyWith(
                fontSize: SizeConfig.screenHeight < 680
                    ? 15
                    : SizeConfig.heightMultiplier * 1.56,
              ),
            ),
          ),
          SizedBox(
            width: 550,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_imageProvider.imageModel != null)
                  loadAnImage(_imageProvider.imageModel!.avatarUrl!)
                else if (_userProvider.userInfo!.avatarUrl != null)
                  loadAnImage(_userProvider.userInfo!.avatarUrl!)
                else
                  imageContainer(
                    imagePath: 'assets/images/no_profile.png',
                    containerHeight: 72,
                    containerWidth: 72,
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier * 0.403,
                  ),
                  child: Consumer<ImageUploadingProvider>(
                      builder: (_, imgProvider, __) {
                    return _isLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            children: [
                              Buttons.outlinePrimaryButton(
                                onPressed: () async {
                                  Uint8List? image = await _imageProvider
                                      .getImage(ImageSource.gallery);

                                  if (image != null) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _imageProvider.uploadImageToServer(
                                        context, image);
                                    _isLoading = false;
                                    setState(() {});
                                  }
                                },
                                title: 'Upload',
                                fontSize:
                                    SizeConfig.screenHeight < 680 ? 11 : 12,
                                borderColor: kBorderColor,
                                buttonColor: Colors.white,
                                borderRoundness: 10,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 0.331,
                              ),
                              Buttons.outlinePrimaryButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  bool isSuccess = await _imageProvider
                                      .removeAvatar(_userProvider);
                                  String message =
                                      "Something went wrong please try agin";
                                  if (isSuccess) {
                                    message = "Image removed successfully";
                                  }
                                  ShowSnackBar.showSnackBar(
                                      context: context, title: message);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                fontSize:
                                    SizeConfig.screenHeight < 680 ? 11 : 12,
                                title: 'Remove',
                                textColor: Colors.redAccent,
                                buttonColor: Colors.white,
                                borderRoundness: 10,
                                borderColor: kBorderColor,
                              ),
                            ],
                          );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 450,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: SizeConfig.screenWidth < 820
                        ? _smBody(context)
                        : _lgBody(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8,
                              bottom: SizeConfig.heightMultiplier * 0.818),
                          child: Text(
                            'Email',
                            style: kProfileNameTextStyle.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: SizeConfig.screenWidth < 1400 ? 11 : 15,
                            ),
                          ),
                        ),
                        TextFields.withController(
                            controller: _emailController,
                            onTapped: () {},
                            borderRoundness: 15,
                            hint: 'Email Address',
                            mapKey: 'email',
                            onSaved: _onSaved,
                            isEmailValidation: true,
                            errorMessage: 'Email required'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smBody(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 8),
              child: Text(
                'First Name',
                style: kProfileNameTextStyle.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: SizeConfig.screenHeight < 680 ? 11 : 15,
                ),
              ),
            ),
            TextFields.withController(
              borderRoundness: 15,
              hint: 'First Name',
              mapKey: 'first_name',
              onSaved: _onSaved,
              controller: _firstNameController,
              onTapped: () {},
              errorMessage: 'Please provide your first name',
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
              child: Text(
                'Last Name',
                style: kProfileNameTextStyle.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: SizeConfig.screenHeight < 680 ? 11 : 15,
                ),
              ),
            ),
            TextFields.withController(
                borderRoundness: 15,
                hint: 'Last Name',
                mapKey: 'last_name',
                onSaved: _onSaved,
                onTapped: () {},
                controller: _lastNameController,
                errorMessage: 'Please provide your last name'),
          ],
        ),
      ],
    );
  }

  Widget _lgBody(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SizedBox(
      width: 650,
      child: Row(
        children: [
          SizedBox(
            width: 184,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text(
                    'First Name',
                    style: kProfileNameTextStyle.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: SizeConfig.screenHeight < 680 ? 11 : 15,
                    ),
                  ),
                ),
                TextFields.withController(
                  borderRoundness: 15,
                  hint: 'First Name',
                  onTapped: () {},
                  mapKey: 'first_name',
                  onSaved: _onSaved,
                  controller: _firstNameController,
                  errorMessage: 'Please provide your first name',
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 184,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text(
                    'Last Name',
                    style: kProfileNameTextStyle.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: SizeConfig.screenHeight < 680 ? 11 : 15,
                    ),
                  ),
                ),
                TextFields.withController(
                    borderRoundness: 15,
                    hint: 'Last Name',
                    mapKey: 'last_name',
                    onSaved: _onSaved,
                    onTapped: () {},
                    controller: _lastNameController,
                    errorMessage: 'Please provide your last name'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

loadAnImage(url) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(60)),
    child: SizedBox(
      height: SizeConfig.screenWidth < 1300
          ? 42
          : SizeConfig.heightMultiplier * 7.617, // 128
      width: SizeConfig.screenWidth < 1300
          ? 42
          : SizeConfig.widthMultiplier * 3.984,
      child: Image.network(
        url,
      ),
    ),
  );
}
