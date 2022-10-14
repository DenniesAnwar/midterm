// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/auth_services/auth_services.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({Key? key}) : super(key: key);

  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  final String _successMessage =
      "Please check your email and follow the link to change password";
  final String _errorMessage = "No user register with given email";

  bool _isEmailSent = true;

  bool _showEmailNotification = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const LoadMenu(),
              Center(
                child: SizedBox(
                  width: 576,
                  child: Column(
                    children: [
                      _loadBigTitle(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _loadDescription(),
                          _loadForm(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadBigTitle() => Padding(
        padding: EdgeInsets.only(
            bottom: SizeConfig.heightMultiplier * 3.493,
            top: SizeConfig.screenHeight > 500
                ? SizeConfig.heightMultiplier * 6.493
                : 20),
        child: Text(
          'Reset Your Password',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SizeConfig.screenWidth < 950
                  ? 25
                  : SizeConfig.heightMultiplier * 5.734,
              fontWeight: FontWeight.w600,
              fontFamily: 'Open Sans'),
        ),
      );

  _loadDescription() => SizedBox(
        width: 550,
        child: Padding(
          padding: EdgeInsets.only(
              left: 25,
              right: 25,
              top: SizeConfig.heightMultiplier * 1.120,
              bottom: SizeConfig.heightMultiplier * 5.601),
          child: Text(
            'Enter the email address you used when you joined and we\'ll send you instructions to reset your password',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                height: 1.4,
                fontSize: SizeConfig.screenWidth < 920 ? 15 : 19,
                fontWeight: FontWeight.w400,
                fontFamily: 'Open Sans'),
          ),
        ),
      );

  Widget _loadForm() => Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier * 5.601, left: 25, right: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FieldTitle(title: 'Email Address'),
              TextFields.withoutController(
                  borderRoundness: SizeConfig.heightMultiplier * 0.715,
                  hint: 'Email Address',
                  mapKey: 'email',
                  isEmailValidation: true,
                  onSaved: _onSaved,
                  errorMessage: 'email required'),
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.heightMultiplier * 1.94,
                    top: SizeConfig.heightMultiplier * 2.601),
                child: Buttons.customPrimaryButton(
                    fontSize: SizeConfig.screenWidth < 920 ? 15 : 20,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Helpers.showAppDialog(context: context);
                        _isEmailSent =
                            await FirebaseAuthServices.forgotPassword(
                                context: context, email: _formData['email']);

                        setState(() {
                          _showEmailNotification = true;
                        }); //context.beamToNamed(Routes.newPasswordScreen);
                      }
                    },
                    title: 'Continue',
                    buttonHeight: 50),
              ),
              if (_showEmailNotification)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _isEmailSent ? _successMessage : _errorMessage,
                    style: TextStyle(
                        color: _isEmailSent ? kPrimaryColor : kRedColor),
                  ),
                )
            ],
          ),
        ),
      );

  _onSaved(String key, dynamic value) {
    _formData[key] = value;
  }
}
