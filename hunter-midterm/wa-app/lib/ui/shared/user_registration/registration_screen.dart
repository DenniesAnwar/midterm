import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/network/models/country_model.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/auth_services/auth_services.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/colors.dart';
import 'components/auth_buttons.dart';
import 'components/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _checkVal = false;
  final Map<String, dynamic> _formData = {};

  late CountryModel _countryModel;
  List<CountryModel> _countryList = [];
  bool _isLoading = true;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    UserProvider _uProvider = Provider.of<UserProvider>(context, listen: false);

    Future.microtask(() async {
      _countryList = await _uProvider.getCountryList();
      _countryModel = _countryList[0];
      setState(() {
        _isLoading = false;
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
            ? Center(child: loadingWidget())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // logo container
                    const LoadMenu(),
                    _loadRegistrationForm(),
                  ],
                ),
              ),
      ),
    );
  }

  _loadRegistrationForm() {
    return Column(children: [
      _loadBigTitle(),
      Center(
        child: SizeConfig.screenWidth < 920 ? _smBody() : _lgBody(),
      ),
    ]);
  }

  Widget _smBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const LoadAuthButtons(isRegistering: true),
          SizedBox(
              width: 576,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
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
          child: LoadAuthButtons(isRegistering: true),
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
          'Create An Account',
          style: TextStyle(
            fontSize: SizeConfig.screenWidth < 920 ? 25 : 50,
            fontWeight: FontWeight.w600,
            fontFamily: 'Open Sans',
          ),
        ),
      );

  _loadForm() => Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldTitle(title: 'First Name'),
                    TextFields.withoutController(
                        hint: 'First Name',
                        mapKey: 'first_name',
                        onSaved: _onSaved,
                        errorMessage: 'First name required'),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldTitle(title: 'Last Name'),
                    TextFields.withoutController(
                        hint: 'Last Name',
                        mapKey: 'last_name',
                        onSaved: _onSaved,
                        errorMessage: 'Last name required'),
                  ],
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: FieldTitle(title: 'Email Address'),
            ),
            TextFields.withoutController(
                hint: 'Email Address',
                mapKey: 'email',
                onSaved: _onSaved,
                isEmailValidation: true,
                errorMessage: 'Email required'),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: FieldTitle(title: 'Password'),
            ),
            TextFields.withoutController(
              secureText: true,
              hint: 'Password',
              mapKey: 'password',
              errorMessage: 'Password required',
              onSaved: _onSaved,
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: FieldTitle(title: 'Country'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  border: Border.all(
                    color: kBorderColor,
                  )),
              child: DropdownButton<CountryModel>(
                isExpanded: true,
                value: _countryModel,
                icon: const Image(
                  image: AssetImage('assets/icons/down_arrow.png'),
                  color: Colors.black,
                  height: 10,
                  width: 12,
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(),
                onChanged: (CountryModel? newValue) {
                  setState(() {
                    _countryModel = newValue!;
                  });
                },
                items: _countryList
                    .map<DropdownMenuItem<CountryModel>>((CountryModel value) {
                  return DropdownMenuItem<CountryModel>(
                    value: value,
                    child: Text(value.countryName),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Checkbox(
                      value: _checkVal,
                      onChanged: (val) {
                        setState(() {
                          _checkVal = val!;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Accept Terms & Conditions and Privacy Policy',
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth < 1050 ? 15 : 19,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 20),
              child: Buttons.customPrimaryButton(
                  fontSize: SizeConfig.screenWidth < 920 ? 16 : 20,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (_checkVal) {
                        // SharedPrefHelper.prefs
                        //     .setBool(acceptPrivacyPolicy, _checkVal);
                        _formData['country'] = _countryModel.countryCode;
                        Helpers.showAppDialog(
                            context: context, widget: loadingWidget());
                        User? authUser = await FirebaseAuthServices
                            .signUpWithEmailAndPassword(
                                context: context, data: _formData);
                        if (authUser != null) {
                          await Helpers.redirectUser(
                              isRegistering: true,
                              context: context,
                              user: authUser);
                        }
                      } else {
                        ShowSnackBar.showSnackBar(
                            context: context,
                            title:
                                'Accept Terms And Conditions and Privacy Policy');
                      }
                    } else {
                      setState(() {
                        _autoValidate = AutovalidateMode.always;
                      });
                    }
                  },
                  title: 'Create An Account',
                  buttonHeight: SizeConfig.screenWidth < 920 ? 45 : 65),
            )
          ],
        ),
      );

  _onSaved(String key, dynamic value) {
    _formData[key] = value;
  }
}
