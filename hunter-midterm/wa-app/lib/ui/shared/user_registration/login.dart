// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
// import 'package:wa_app/custom_widgets/log_out_dialog.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/auth_services/auth_services.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/routes.dart';

import 'components/auth_buttons.dart';
import 'components/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _checkVal = false;

  String? _email;
  String? _password;
  final Map<String, dynamic> _formData = {};

  late SharedPreferences _preferences;
  bool _isLoading = true;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

// Our variables for the user session login attempts
  int invalidTryCount = 0;
  int invalidTryLimit = 5;
  DateTime lastTry = DateTime.now().subtract(const Duration(days: 1));
  bool isInvalidTry = false;
  var invKeys = InvalidTryKeys();
  int hoursLimit = 2;
  String invalidMessage =
      "You have reached login attempt limit, please try again in few hours.";

  @override
  void initState() {
    Future.microtask(() async {
      await Helpers.getPref().then((value) {
        _preferences = value;
        _checkVal = value.getBool(rememberMeKey) ?? false;
        _email = value.getString(emailKey) ?? "";
        _password = value.getString(passwordKey) ?? "";

        if ((value.getString(invKeys.dateTime) ?? "").isNotEmpty) {
          lastTry = DateTime.parse(value.getString(invKeys.dateTime)!);
          if (DateTime.now().difference(lastTry).inMinutes < hoursLimit) {
            invalidTryCount = value.getInt(invKeys.counter)!;
          }
        }
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? loadingWidget()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // logo container
                    const LoadMenu(isLogin: true),
                    _loadBigTitle(),
                    Center(
                      child:
                          SizeConfig.screenWidth < 920 ? _smBody() : _lgBody(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _smBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const LoadAuthButtons(
            isRegistering: false,
          ),
          SizedBox(
              width: 576,
              child: Column(
                children: [
                  customDivider(),
                  _loadForm(),
                ],
              )),
        ],
      ),
    );
  }

  Widget _lgBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: LoadAuthButtons(
            isRegistering: false,
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _loadForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _loadBigTitle() => Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier * 2.63,
            bottom: SizeConfig.heightMultiplier * 6.76),
        child: Text(
          'Login',
          style: TextStyle(
              fontSize: SizeConfig.screenWidth < 920 ? 20 : 50,
              fontWeight: FontWeight.w600),
        ),
      );

  Widget _loadForm() => Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FieldTitle(title: 'Email Address'),
            TextFields.withoutController(
                initialValue: _email ?? "",
                hint: 'Email Address',
                mapKey: 'email',
                onSaved: _onSaved,
                isEmailValidation: true,
                errorMessage: 'Email required'),
            const SizedBox(
              height: 15,
            ),
            const FieldTitle(title: 'Password'),
            TextFields.withoutController(
              initialValue: _password ?? "",
              secureText: true,
              hint: 'Password',
              mapKey: 'password',
              errorMessage: 'Password required',
              onSaved: _onSaved,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Checkbox(
                      value: _checkVal,
                      onChanged: (val) {
                        setState(() {
                          _checkVal = val!;
                        });
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      context.beamToNamed(Routes.confirmEmailScreen);
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 17,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isInvalidTry)
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red[100]!),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  invalidMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: SizeConfig.heightMultiplier * 1.94, top: 30),
              child: Buttons.customPrimaryButton(
                  onPressed: () async {
                    if (invalidTryCount >= invalidTryLimit &&
                        DateTime.now().difference(lastTry).inMinutes <=
                            hoursLimit) {
                      setState(() {
                        isInvalidTry = true;
                        invalidMessage =
                            "You have reached login attempt limit, please try again in few hours.";
                      });
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (invalidTryCount >= invalidTryLimit) {
                        invalidTryCount = 0;
                      }
                      Helpers.showAppDialog(
                          context: context, widget: loadingWidget());
                      var resp =
                          await FirebaseAuthServices.signInWithEmailAndPassword(
                        context: context,
                        email: _formData['email'],
                        password: _formData['password'],
                      );
                      if (resp['isSuccess']) {
                        Provider.of<UserProvider>(context, listen: false).user =
                            resp['user'];
                        await Helpers.redirectUser(
                            isRegistering: false,
                            context: context,
                            user: resp['user']);
                        //SharedPreferences preferences = await Helpers.getPref();

                        if (_checkVal) {
                          _preferences.setString(emailKey, _formData['email']);
                          _preferences.setString(
                              passwordKey, _formData['password']);
                          _preferences.setBool(rememberMeKey, _checkVal);
                        } else {
                          _preferences.clear();
                        }
                        isInvalidTry = false;
                      } else {
                        if (!resp['isNetworkError']) {
                          invalidTryCount += 1;
                          lastTry = DateTime.now();
                          _preferences.setString(
                              invKeys.dateTime, lastTry.toString());
                          _preferences.setInt(invKeys.counter, invalidTryCount);
                          setState(() {
                            isInvalidTry = true;
                            invalidMessage =
                                'Login failed, Username or password is incorect, please try again.';
                          });
                        }
                        Navigator.of(context).maybePop();
                      }
                    } else {
                      setState(() => _autoValidate = AutovalidateMode.always);
                    }
                  },
                  title: 'Login',
                  buttonHeight: 65),
            )
          ],
        ),
      );

  _onSaved(String key, dynamic value) {
    _formData[key] = value;
  }
}
