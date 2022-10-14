// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/custom_widgets/log_out_dialog.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/network/models/country_model.dart';
import 'package:wa_app/providers/producer_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/user_registration/components/form_submitted_page.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

class ProducerApplicationForm extends StatefulWidget {
  const ProducerApplicationForm({Key? key}) : super(key: key);

  @override
  _ProducerApplicationFormState createState() =>
      _ProducerApplicationFormState();
}

enum producingExperience { yes, no }
enum UserChoice { yes, iWillMove, no }

enum BelongTo {
  memberOfPGA,
  memberOfDGA,
  memberOfSAGAFTRA,
  memberOfASC,
  meberOfProducerUnion,
  nonUnioNonTradeAssociation
}

class _ProducerApplicationFormState extends State<ProducerApplicationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late UserProvider _userProvider;
  Map<String, dynamic> formData = {};

  late CountryModel _countryModel;

  List<CountryModel> _countryList = [];
  _onSaved(String key, dynamic value) {
    formData[key] = value;
  }

  bool isCheckBoxChecked = false;
  var _producingExperience = producingExperience.yes;
  var _interview = UserChoice.yes;
  var _belognsTo = BelongTo.memberOfPGA;
  bool _isLoading = true;
  bool _isApplicationRejected = false;
  String countryValue = 'US';

  ///List<DropdownMenuItem<Str ing>> countriesList = getDropDownItems().toList();

  @override
  void initState() {
    formData['country'] = countryValue;
    formData['experienced'] = false;
    formData['application_type'] = 'producer';
    formData['trade_associations'] = "memberOfPGA";
    formData['meeting_preference'] = "yes";
    _userProvider = Provider.of<UserProvider>(context, listen: false);

    Future.microtask(() async {
      if (_userProvider.userInfo == null) {
        await _userProvider.getUserInfo();
      }

      if (_userProvider.userInfo!.accountType != null) {
        onTapped();
      } else {
        Future.microtask(() async {
          await getCountriesList().then((value) {
            _isLoading = false;
            setState(() {});
          });
        });
      }
    });

    super.initState();
  }

  onTapped() async {
    await _userProvider.getProducerApplications(context).then((value) async {
      await getCountriesList();
      _isApplicationRejected = value!;
      _isLoading = false;
      setState(() {});
    });
  }

  Future getCountriesList() async {
    if (_userProvider.countryList.isEmpty) {
      _countryList = await _userProvider.getCountryList();
      _countryModel = _countryList[0];
    } else {
      _countryModel = _userProvider.countryList[0];
      _countryList = _userProvider.countryList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? loadingWidget()
            : _userProvider.userInfo!.accountType != null
                ? FormSubmittedPage(isRejected: _isApplicationRejected)
                : Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 60.0, bottom: 10, left: 45, right: 45),
                            child: Text(
                              'WoAccelerator Producer Application',
                              overflow: TextOverflow.ellipsis,
                              style: sBigTitleTextStyle.copyWith(fontSize: 40),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 30, right: 45),
                            child: Text(
                              'Please complete the form below to apply to the WoAccelerator Producers',
                              overflow: TextOverflow.ellipsis,
                              style: sSmallTitleTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                          ),
                          bigDivider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30, top: 30, left: 45, right: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sectionTitle(title: 'Basic Info'),
                                _loadFormTileInput(
                                  isRequired: false,
                                  childWidget: TextFields.withoutController(
                                      hint: 'i.e. he/she they ',
                                      mapKey: 'pronoun',
                                      onSaved: (key, value) {}),
                                  label:
                                      'What pronoun do you prefer (Optional)?',
                                ),
                                // _fullNameModule(),
                                // _emailModule(),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // _fullNameModule(),
                                      _countryModule(),
                                      _producingExperienceModule(),
                                      _belongsToModule(),
                                      _iMDBExperienceModule(),
                                      _candidateChoiceModule(),
                                      _youLikeUsToKnowModule(),
                                      smallDivider(),
                                      _agreeToTermsModule(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bigDivider(),
                          Visibility(
                            visible:
                                _userProvider.userInfo!.accountType == null,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Buttons.submitButton(
                                buttonHeight: 45.5,
                                buttonWidth: 178,
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  if (_formKey.currentState!.validate()) {
                                    if (!isCheckBoxChecked) {
                                      ShowSnackBar.showSnackBar(
                                          context: context,
                                          title:
                                              'Please accept terms & conditions');
                                      return;
                                    }

                                    Map<String, String> data = {
                                      "account_type": _userProvider.accountType,
                                      "first_name":
                                          "${_userProvider.userInfo!.firstName}",
                                      "last_name":
                                          "${_userProvider.userInfo!.lastName}",
                                      "country": formData['country']
                                    };

                                    await _updateCurrentUser(
                                        data: data, context: context);
                                    await Provider.of<ProducerProvider>(context,
                                            listen: false)
                                        .producerApplicationRequest(
                                            context, formData)
                                        .then((value) async {
                                      await showApplicationSuccessDialog(
                                          context: context, isRejected: false);
                                      setState(() {});
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  // _fullNameModule() => _loadFormTileInput(
  //       isRequired: false,
  //       childWidget: Row(
  //         children: [
  //           Expanded(
  //             child: TextFields.withoutController(
  //                 hint: 'First Name',
  //                 mapKey: 'first_name',
  //                 onSaved: (key, value) {},
  //                 errorMessage: 'Please provide your first name'),
  //           ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: TextFields.withoutController(
  //                 hint: 'Last Name',
  //                 mapKey: 'last_name',
  //                 onSaved: (key, value) {},
  //                 errorMessage: 'Please provide your last name'),
  //           ),
  //         ],
  //       ),
  //       label: 'Full Name',
  //     );

  // _emailModule() => _loadFormTileInput(
  //       isRequired: false,
  //       childWidget: TextFields.withoutController(
  //           hint: 'example@example.com',
  //           mapKey: 'email',
  //           isEmailValidation: true,
  //           onSaved: (key, value) {},
  //           errorMessage: 'Please provide your email'),
  //       label: 'Email',
  //     );

  _countryModule() => _loadFormTileInput(
        childWidget: countriesDownMenu(),
        label: 'What Country are you from?',
      );

  _producingExperienceModule() => _loadFormTileInput(
        childWidget: _producingExperienceTiles(),
        label: 'Do you have any producing experience?',
      );

  _iMDBExperienceModule() => _loadFormTileInput(
        isRequired: false,
        childWidget: TextFields.imdbTextField(
            hint: 'Only IMDB Links accepted',
            mapKey: 'imdb_link',
            errorMessage:
                'Please provide your IMDB Link that list your experience',
            onSaved: _onSaved),
        label: 'Please provide your IMDB Link that list your experience',
      );

  _belongsToModule() => _loadFormTileInput(
        childWidget: _belongsToOptions(),
        label: belongsTo,
      );

  _candidateChoiceModule() => _loadFormTileInput(
        childWidget: _meetingInterview(),
        label: availableForMeeting,
      );

  _youLikeUsToKnowModule() => _loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'more',
          maxLine: 8,
          maxLength: 100,
          errorMessage: 'Please provide some description',
          onSaved: _onSaved,
        ),
        label: youLikeUsToKnow,
      );

  _agreeToTermsModule({bool isRequired = true}) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
          child: Wrap(
            children: [
              SizedBox(
                width: 340,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                        value: isCheckBoxChecked,
                        onChanged: (val) {
                          setState(() {
                            isCheckBoxChecked = val!;
                            //todo: clarify whether to send it or not
                            //formData['agree_to_terms'] = isCheckBoxChecked;
                          });
                        }),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'I agree to ',
                          style: sBigTitleTextStyle.copyWith(
                              height: 1.3,
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                                text: 'terms & conditions',
                                style: sBigTitleTextStyle.copyWith(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                      child: Visibility(
                        visible: isRequired,
                        child: const Text(
                          '*',
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(width: 400, child: Container()),
            ],
          ),
        ),
      );

  _producingExperienceTiles() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _producingExperience = value;
                formData['experienced'] =
                    _producingExperience == producingExperience.yes
                        ? true
                        : false;
              },
              item: _producingExperience,
              groupValue: producingExperience.yes,
              title: 'Yes'),
          _radioTileItem(
              onChangedCall: (value) {
                _producingExperience = value;
                formData['experienced'] =
                    _producingExperience == producingExperience.yes
                        ? true
                        : false;
              },
              item: _producingExperience,
              groupValue: producingExperience.no,
              title: 'No'),
        ],
      );

  _belongsToOptions() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _belognsTo = value;
                if (_belognsTo == BelongTo.memberOfPGA) {
                  formData["trade_associations"] = "memberOfPGA";
                }
              },
              item: _belognsTo,
              groupValue: BelongTo.memberOfPGA,
              title: 'Member of PGA'),
          _radioTileItem(
              onChangedCall: (value) {
                _belognsTo = value;
                if (_belognsTo == BelongTo.memberOfDGA) {
                  formData["trade_associations"] = "memberOfDGA";
                }
              },
              item: _belognsTo,
              groupValue: BelongTo.memberOfDGA,
              title: 'Member of DGA'),
          _radioTileItem(
              onChangedCall: (value) {
                _belognsTo = value;
                if (_belognsTo == BelongTo.memberOfSAGAFTRA) {
                  formData["trade_associations"] = "memberOfSAGAFTRA";
                }
              },
              item: _belognsTo,
              groupValue: BelongTo.memberOfSAGAFTRA,
              title: 'Member of SAG/AFTRA'),
          _radioTileItem(
              onChangedCall: (value) {
                _belognsTo = value;
                if (_belognsTo == BelongTo.memberOfASC) {
                  formData["trade_associations"] = "memberOfASC";
                }
              },
              item: _belognsTo,
              groupValue: BelongTo.memberOfASC,
              title: 'Member of ASC'),
          _radioTileItem(
              onChangedCall: (value) {
                _belognsTo = value;
                if (_belognsTo == BelongTo.meberOfProducerUnion) {
                  formData["trade_associations"] = "meberOfProducerUnion";
                }
              },
              item: _belognsTo,
              groupValue: BelongTo.meberOfProducerUnion,
              title: 'Member of Producer Unoin'),
          _radioTileItem(
              onChangedCall: (value) {
                _belognsTo = value;
                if (_belognsTo == BelongTo.nonUnioNonTradeAssociation) {
                  formData["trade_associations"] = "nonUnioNonTradeAssociation";
                }
              },
              item: _belognsTo,
              groupValue: BelongTo.nonUnioNonTradeAssociation,
              title: 'Non-Union/Non Trade Association'),
        ],
      );

  _meetingInterview() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _interview = value;
                if (_interview == UserChoice.yes) {
                  formData['meeting_preference'] = "yes";
                }
              },
              item: _interview,
              groupValue: UserChoice.yes,
              title: 'Yes'),
          _radioTileItem(
              onChangedCall: (value) {
                _interview = value;
                if (_interview == UserChoice.iWillMove) {
                  formData['meeting_preference'] = "iWillMove";
                }
              },
              item: _interview,
              groupValue: UserChoice.iWillMove,
              title: 'I\'ll move things around'),
          _radioTileItem(
              onChangedCall: (value) {
                _interview = value;
                if (_interview == UserChoice.no) {
                  formData['meeting_preference'] = "no";
                }
              },
              item: _interview,
              groupValue: UserChoice.no,
              title: 'No'),
        ],
      );
  Widget countriesDownMenu() {
    return Container(
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
        underline: Container(),
        onChanged: (CountryModel? newValue) {
          setState(() {
            _countryModel = newValue!;
            formData['country'] = _countryModel.countryCode;
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
    );
  }

  RadioListTile _radioTileItem(
          {required item,
          required groupValue,
          required String title,
          required Function(dynamic) onChangedCall}) =>
      RadioListTile(
        contentPadding: const EdgeInsets.all(0),
        activeColor: Colors.indigo,
        groupValue: item,
        title: Text(title,
            style: const TextStyle(color: Colors.black54, fontSize: 15)),
        value: groupValue,
        onChanged: (val) {
          setState(() {
            item = val;
            onChangedCall(item);
          });
        },
      );
  _loadFormTileInput(
          {bool isRequired = true,
          required Widget childWidget,
          required String label}) =>
      Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
          child: Wrap(
            children: [
              SizedBox(
                  width: 290,
                  child: RichText(
                    text: TextSpan(
                      text: label,
                      style: const TextStyle(
                          height: 1.3,
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                      children: <TextSpan>[
                        if (isRequired)
                          const TextSpan(
                              text: '*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  )),
              const SizedBox(
                width: 20,
              ),
              SizedBox(width: 470, child: childWidget),
            ],
          ),
        ),
      );
}

Future<void> _updateCurrentUser({
  required BuildContext context,
  required Map<String, String> data,
}) async {
  Helpers.showAppDialog(context: context);
  await Provider.of<UserProvider>(context, listen: false)
      .updateCurrentUser(data)
      .then((value) {
    Navigator.of(context).pop();
    showApplicationSuccessDialog(context: context, isRejected: false);
  });
}
