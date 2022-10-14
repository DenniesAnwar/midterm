// ignore: implementation_imports
import "package:beamer/src/beamer.dart";
import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/routes.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  _SetNewPasswordScreenState createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};
  bool _newIsSecured = true;
  bool _confirmIsSecured = true;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const LoadMenu(),
              Center(
                child: Column(
                  children: [
                    _loadBigTitle(),
                    _loadDescription(),
                    SizedBox(width: 476, child: _loadForm()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _loadBigTitle() => Padding(
        padding: EdgeInsets.only(
            bottom: SizeConfig.heightMultiplier * 2.493,
            top: SizeConfig.screenHeight > 500
                ? SizeConfig.heightMultiplier * 4.493
                : 20),
        child: Text(
          'Reset Your Password',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SizeConfig.screenWidth < 950
                  ? 25
                  : SizeConfig.heightMultiplier * 5.734,
              fontWeight: FontWeight.w600),
        ),
      );

  _loadDescription() => SizedBox(
        width: 550,
        child: Padding(
          padding: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 1.120,
              bottom: SizeConfig.heightMultiplier * 5.601),
          child: Text(
            'Enter new your password',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Open Sans',
                height: 1.4,
                fontSize: SizeConfig.screenWidth < 920 ? 15 : 19,
                fontWeight: FontWeight.w400),
          ),
        ),
      );

  Widget _loadForm() => Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier * 3.601, left: 25, right: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              const FieldTitle(title: 'New Password'),
              TextFields.withController(
                controller: _newPasswordController,
                hint: 'New password',
                mapKey: 'new_password',
                onSaved: _onSaved,
                secureText: _newIsSecured,
                errorMessage: 'New Password required',
                trailingIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _newIsSecured = !_newIsSecured;
                    });
                  },
                  child: Icon(
                    !_newIsSecured
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                    size: 20,
                    color: kIconColor,
                  ),
                ),
                isTrailing: true,
                onTapped: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              const FieldTitle(title: 'Confirm your password'),
              TextFields.withConfirmController(
                controller: _confirmPasswordController,
                confirmController: _newPasswordController,
                hint: 'Confirm Password',
                mapKey: 'confirm_password',
                onSaved: _onSaved,
                secureText: _confirmIsSecured,
                errorMessage: 'Confirm Password required',
                trailingIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _confirmIsSecured = !_confirmIsSecured;
                    });
                  },
                  child: Icon(
                    !_confirmIsSecured
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                    size: 20,
                    color: kIconColor,
                  ),
                ),
                isTrailing: true,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.heightMultiplier * 1.94,
                    top: SizeConfig.heightMultiplier * 3.601),
                child: Buttons.customPrimaryButton(
                    onPressed: () => context.beamToNamed(Routes.login),
                    title: 'Continue',
                    buttonHeight: 50),
              )
            ],
          ),
        ),
      );

  _onSaved(String key, dynamic value) {
    _formData[key] = value;
  }
}
