// ignore: implementation_imports
import 'dart:math';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/custom_widgets.dart';
import 'package:wa_app/custom_widgets/log_out_dialog.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/network/models/country_model.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/user_registration/components/form_submitted_page.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/styles.dart';

class ScreenWriterApplicationForm extends StatefulWidget {
  const ScreenWriterApplicationForm({Key? key}) : super(key: key);

  @override
  _ScreenWriterApplicationFormState createState() =>
      _ScreenWriterApplicationFormState();
}

enum AgeRange { age18to25, age26to39, age40to55, age56plus }
enum UserChoice { yes, iWillMove, no }
enum WriterType { drama, comedy, other }
enum WritingDiscipline { tvWriting, filmWriting, videoGameWriting, aRVrWriting }

class _ScreenWriterApplicationFormState
    extends State<ScreenWriterApplicationForm> {
  final TextEditingController yearsKnownController1 = TextEditingController();
  final TextEditingController yearsKnownController2 = TextEditingController();
  late UserProvider _userProvider;

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> formData = {};

  late CountryModel _countryModel;
  List<CountryModel> _countryList = [];

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  _onSaved(String key, dynamic value) {
    formData[key] = value;
  }

  bool isCheckBoxChecked = false;
  var _ageRange = AgeRange.age18to25;
  var _endeavor = UserChoice.yes;
  var _writerType = WriterType.comedy;
  var _writingDiscipline = WritingDiscipline.tvWriting;
  bool _isLoading = true;
  String _applicationStatus = ApplicationStatus.notSubmitted;

  String countryValue = 'USA';
  String fileName = "Browse File";
  bool isFileSizeGreater = false;
  //List<DropdownMenuItem<String>> countriesList = getDropDownItems().toList();

  @override
  void initState() {
    formData['country'] = 'US';
    formData['age_group'] = 1;
    formData['committed'] = 1;
    formData['consider_type'] = 1;
    formData['skill_discipline'] = 1;
    formData['scripted'] = 1;
    formData['application_type'] = 'writer';
    _userProvider = Provider.of<UserProvider>(context, listen: false);

    Future.microtask(() async {
      if (_userProvider.userInfo == null) {
        await _userProvider.getUserInfo();
      }
      if (_userProvider.userInfo!.accountType != null) {
        await _userProvider
            .getScWriterApplications(context)
            .then((value) async {
          await loadCountryList();
          _applicationStatus = value;
          _isLoading = false;
          setState(() {});
        });
      } else {
        Future.microtask(() async {
          await loadCountryList();
          _isLoading = false;
          setState(() {});
        });
      }
    });

    super.initState();
  }

  Future loadCountryList() async {
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
            : _userProvider.userInfo!.accountType != null &&
                    _applicationStatus != ApplicationStatus.notSubmitted
                ? FormSubmittedPage(
                    isRejected:
                        _applicationStatus == ApplicationStatus.rejected)
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
                              'WoAccelerator ScreenWriter Application',
                              style: sBigTitleTextStyle.copyWith(fontSize: 40),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 30, right: 45),
                            child: Text(
                              'Please complete the form below to apply to the WoAccelerator program',
                              style: sSmallTitleTextStyle.copyWith(
                                  fontSize: 19,
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
                                Form(
                                  key: _formKey,
                                  autovalidateMode: _autoValidate,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      loadFormTileInput(
                                        isRequired: false,
                                        childWidget:
                                            TextFields.withoutController(
                                          hint: 'i.e. he/she they ',
                                          mapKey: 'pronoun',
                                          onSaved: (key, val) {},
                                        ),
                                        label:
                                            'What pronoun do you prefer (Optional)?',
                                      ),
                                      // _fullNameModule(),
                                      // _emailModule(),
                                      _ageRangeModule(),
                                      _countryModule(),
                                      _candidateCommitmentChoice(),
                                      _admirerModule(),
                                      _screenWritingModule(),
                                      sectionTitle(
                                        title: 'Screenwriting Background',
                                      ),
                                      _screenWriterModule(),
                                      _scriptOptionedModule(),
                                      _interestsAboutWoAcceleratorModule(),
                                      _writingDisciplineModule(),
                                      _youLikeUsToKnowModule(),
                                      _learningProExpectModule(),
                                      _industryAwardModule(),
                                      _noOfCompletedScriptsModule(),
                                      _scriptOfInterestModule(),
                                      _fileUploadingModules(),
                                      sectionTitle(title: 'References'),
                                      sectionSubTitle(
                                        subtitle: referencesSubTitle,
                                      ),
                                      _loadReferenceWidget(
                                        reference: 'Reference 1',
                                        controller: yearsKnownController1,
                                      ),
                                      _loadReferenceWidget(
                                        reference: 'Reference 2',
                                        controller: yearsKnownController2,
                                      ),
                                      _agreeToTermsModule(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                _userProvider.userInfo!.accountType == null ||
                                    _applicationStatus ==
                                        ApplicationStatus.notSubmitted,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 30.0,
                                top: 25,
                              ),
                              child: Buttons.customPrimaryButton(
                                  title: 'Send',
                                  buttonHeight: 50,
                                  buttonWidth: 128.78,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      var data =
                                          _formServerRequestData(formData);

                                      await _updateCurrentUser(
                                          context: context,
                                          data: {
                                            "account_type":
                                                _userProvider.accountType,
                                            "first_name":
                                                "${_userProvider.userInfo!.firstName}",
                                            "last_name":
                                                "${_userProvider.userInfo!.lastName}",
                                            "country": formData['country']
                                          });
                                      await Provider.of<ScreenWriterProvider>(
                                              context,
                                              listen: false)
                                          .screenWriterApplicationRequest(
                                              context, data)
                                          .then((value) {});
                                    } else {
                                      setState(() {
                                        _autoValidate = AutovalidateMode.always;
                                      });
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  _fullNameModule() => loadFormTileInput(
        isRequired: false,
        childWidget: Row(
          children: [
            Expanded(
              child: TextFields.withoutController(
                  hint: 'First Name',
                  mapKey: 'first_name',
                  onSaved: _onSaved,
                  errorMessage: 'Please provide your first name'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFields.withoutController(
                  hint: 'Last Name',
                  mapKey: 'last_name',
                  onSaved: _onSaved,
                  errorMessage: 'Please provide your last name'),
            ),
          ],
        ),
        label: 'Full Name',
      );

  // _emailModule() => loadFormTileInput(
  //       childWidget: TextFields.withoutController(
  //           hint: 'example@example.com',
  //           mapKey: 'email',
  //           isEmailValidation: true,
  //           onSaved: _onSaved,
  //           errorMessage: 'Please provide your email'),
  //       label: 'Email',
  //     );

  _ageRangeModule() => loadFormTileInput(
        childWidget: _ageRangeTiles(),
        label: 'Age Ranges',
      );
  _countryModule() => loadFormTileInput(
        childWidget: countriesDownMenu(),
        label: 'What Country are you from?',
      );
  _candidateCommitmentChoice() => loadFormTileInput(
        childWidget: _candidatesChoice(),
        label: endeavorCommitment,
      );
  _admirerModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
            hint: 'Type here....',
            mapKey: 'industry_admire',
            maxLine: 8,
            maxLength: 100,
            onSaved: _onSaved,
            errorMessage: 'Please provide reference to someone you admire'),
        label: someAdmirer,
      );
  _screenWritingModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'lng_term_plans',
          maxLine: 8,
          onSaved: _onSaved,
          errorMessage: 'Please provide some text',
        ),
        label: screenWritingRelation,
      );
  _screenWriterModule() => loadFormTileInput(
        childWidget: _screenWriterTypeTiles(),
        label: screenWritingBackground,
      );
  _scriptOptionedModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'script_ptn',
          maxLine: 8,
          maxLength: 100,
          errorMessage: 'Please provide script optioned description',
          onSaved: _onSaved,
        ),
        label: scriptOptioned,
      );
  _interestsAboutWoAcceleratorModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'about_us',
          maxLine: 8,
          maxLength: 100,
          errorMessage:
              'Please provide script interests of wo accelerator description',
          onSaved: _onSaved,
        ),
        label: interestWoAccelerator,
      );
  _writingDisciplineModule() => loadFormTileInput(
        childWidget: _writingDisciplineTiles(),
        label: writingDiscipline,
      );
  _youLikeUsToKnowModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'more',
          maxLength: 100,
          maxLine: 8,
          errorMessage: 'Please provide some description',
          onSaved: _onSaved,
        ),
        label: youLikeUsToKnow,
      );

  _learningProExpectModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'except_learn',
          errorMessage: 'Please provide some description',
          maxLine: 8,
          maxLength: 100,
          onSaved: _onSaved,
        ),
        label: learningProExpect,
      );

  _industryAwardModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type here....',
          mapKey: 'awards_achievements',
          errorMessage: 'Please provide some description',
          maxLine: 8,
          maxLength: 100,
          onSaved: _onSaved,
        ),
        label: industryAwards,
      );

  _noOfCompletedScriptsModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'ex: 23',
          mapKey: 'scripted',
          errorMessage: 'Please provide some description',
          maxLine: 1,
          onSaved: _onSaved,
        ),
        label: completedScripts,
      );

  _scriptOfInterestModule() => loadFormTileInput(
        childWidget: TextFields.withoutController(
          hint: 'Type Here...',
          mapKey: 'interested_in',
          errorMessage: 'Please provide some description',
          maxLine: 8,
          maxLength: 100,
          onSaved: _onSaved,
        ),
        label: scriptOfInterest,
      );

  _fileUploadingModules() => loadFormTileInput(
        childWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dragAndDropFiles(onTapFunction: () async {
              FilePickerResult? result = await FilePicker.platform
                  .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

              if (result != null) {
                Uint8List bytes = result.files.first.bytes!;
                int fileSizeInBytes = bytes.length;
                // i=["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

                var i = (log(fileSizeInBytes) / log(1024)).floor();
                final fileSize = fileSizeInBytes / pow(1024, i);
                if (i < 2 || (i == 2 && fileSize < 1)) {
                  //widget.uploadFile(bytes);

                  fileName = result.files.first.name;
                  isFileSizeGreater = false;
                } else {
                  //fileName = "File size must not be greater then 1 mb";
                  isFileSizeGreater = true;
                }
              } else {
                // User canceled the picker
              }
              setState(() {});
            }),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        label: uploadFiles,
      );

  _loadReferenceWidget(
          {required String reference,
          required TextEditingController controller}) =>
      Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Text(
                reference,
                style: sSmallTitleTextStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
            ),
            _fullNameModule(),
            loadFormTileInput(
              childWidget: TextFields.withoutController(
                hint: '(000) 000-0000',
                isPhoneNumberValidator: true,
                errorMessage: 'Please enter a valid phone number',
                mapKey: '${reference.toLowerCase()}_phone',
                inputType: TextInputType.phone,
                onSaved: _onSaved,
              ),
              label: 'Phone Number',
            ),
            loadFormTileInput(
              childWidget: TextFields.withoutController(
                errorMessage: 'Please provide some description',
                onSaved: _onSaved,
                hint: 'example@example.com',
                mapKey: '${reference.toLowerCase()}_email',
                isEmailValidation: true,
              ),
              label: 'Email Address',
            ),
            loadFormTileInput(
              childWidget: TextFields.yearsKnown(
                  onSaved: _onSaved,
                  controller: controller,
                  hint: '0',
                  mapKey: '${reference.toLowerCase()}_years_known',
                  removeNumberCall: () {
                    if (int.parse(controller.text) == 0) {
                      setState(() {
                        controller.text = (0).toString();
                      });
                    } else if (controller.text != '') {
                      setState(() {
                        controller.text =
                            (int.parse(controller.text) - 1).toString();
                      });
                    } else {
                      setState(() {
                        controller.text = (0).toString();
                      });
                    }
                  },
                  addNumberCall: () {
                    if (controller.text == '') {
                      setState(() {
                        controller.text = (1).toString();
                      });
                    } else if (int.parse(controller.text) <= 100) {
                      setState(() {
                        controller.text =
                            (int.parse(controller.text) + 1).toString();
                      });
                    } else {
                      // showSnackBar
                      // ignore: avoid_print
                      print('Age should not be greator then 100');
                    }
                  }),
              label: 'Years Known',
            )
          ],
        ),
      );
  _agreeToTermsModule({bool isRequired = true}) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
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
                            formData['agree_to_terms'] = isCheckBoxChecked;
                          });
                        }),
                    InkWell(
                      onTap: () {
                        launch("https://woaccelerator.com/terms.html");
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'I agree to ',
                            style: sBigTitleTextStyle.copyWith(
                                height: 1.3,
                                fontSize: 14,
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

  _ageRangeTiles() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _ageRange = value;
                formData['age_group'] = 1;
              },
              item: _ageRange,
              groupValue: AgeRange.age18to25,
              title: '18-25'),
          _radioTileItem(
              onChangedCall: (value) {
                _ageRange = value;
                formData['age_group'] = 2;
              },
              item: _ageRange,
              groupValue: AgeRange.age26to39,
              title: '26-39'),
          _radioTileItem(
              onChangedCall: (value) {
                _ageRange = value;
                formData['age_group'] = 3;
              },
              item: _ageRange,
              groupValue: AgeRange.age40to55,
              title: '40-55'),
          _radioTileItem(
              onChangedCall: (value) {
                _ageRange = value;
                formData['age_group'] = 4;
              },
              item: _ageRange,
              groupValue: AgeRange.age56plus,
              title: '56+'),
        ],
      );
  _screenWriterTypeTiles() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _writerType = value;
                formData['consider_type'] = 1;
              },
              item: _writerType,
              groupValue: WriterType.drama,
              title: 'Drama'),
          _radioTileItem(
              onChangedCall: (value) {
                _writerType = value;
                formData['consider_type'] = 2;
              },
              item: _writerType,
              groupValue: WriterType.comedy,
              title: 'Comedy'),
          _radioTileItem(
              onChangedCall: (value) {
                _writerType = value;
                formData['consider_type'] = 3;
              },
              item: _writerType,
              groupValue: WriterType.other,
              title: 'Other'),
        ],
      );
  _writingDisciplineTiles() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _writingDiscipline = value;
                formData['skill_discipline'] = 1;
              },
              item: _writingDiscipline,
              groupValue: WritingDiscipline.tvWriting,
              title: 'TV Writing'),
          _radioTileItem(
              onChangedCall: (value) {
                _writingDiscipline = value;
                formData['skill_discipline'] = 2;
              },
              item: _writingDiscipline,
              groupValue: WritingDiscipline.filmWriting,
              title: 'Film Writing'),
          _radioTileItem(
              onChangedCall: (value) {
                _writingDiscipline = value;
                formData['skill_discipline'] = 3;
              },
              item: _writingDiscipline,
              groupValue: WritingDiscipline.videoGameWriting,
              title: 'Video Game Writing'),
          _radioTileItem(
              onChangedCall: (value) {
                _writingDiscipline = value;
                formData['skill_discipline'] = 4;
              },
              item: _writingDiscipline,
              groupValue: WritingDiscipline.aRVrWriting,
              title: 'AR/VR Writing'),
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
        style: const TextStyle(color: Colors.deepPurple),
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

  _candidatesChoice() => Column(
        children: [
          _radioTileItem(
              onChangedCall: (value) {
                _endeavor = value;
                formData['committed'] = 1;
              },
              item: _endeavor,
              groupValue: UserChoice.yes,
              title: 'Yes'),
          _radioTileItem(
              onChangedCall: (value) {
                _endeavor = value;
                formData['committed'] = 2;
              },
              item: _endeavor,
              groupValue: UserChoice.iWillMove,
              title: 'I\'ll move things around'),
          _radioTileItem(
              onChangedCall: (value) {
                _endeavor = value;
                formData['committed'] = 3;
              },
              item: _endeavor,
              groupValue: UserChoice.no,
              title: 'No'),
        ],
      );
  RadioListTile _radioTileItem(
          {required item,
          required groupValue,
          title,
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

  dragAndDropFiles({
    required onTapFunction,
  }) =>
      InkWell(
        onTap: onTapFunction,
        child: Center(
          child: DottedBorder(
            padding: const EdgeInsets.all(8),
            strokeCap: StrokeCap.butt,
            dashPattern: const [9, 6],
            borderType: BorderType.RRect,
            strokeWidth: 1.8,
            radius: const Radius.circular(8),
            color: Colors.black,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      size: 45,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      fileName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      isFileSizeGreater
                          ? 'File size must not be greater then 1 mb'
                          : '1 MB max size',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isFileSizeGreater ? kRedColor : Colors.black54,
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

loadFormTileInput(
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
              width: 300,
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
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(width: 470, child: childWidget),
          ],
        ),
      ),
    );

Map<String, dynamic> _formServerRequestData(Map<String, dynamic> formData) {
  Map<String, dynamic> data = {};
  data['application_type'] = formData['application_type'];
  data['country'] = formData['country'];
  data['more'] = formData['more'];
  data['age_group'] = formData['age_group'];
  data['committed'] = formData['committed'];
  data['industry_admire'] = formData['industry_admire'];
  data['lng_term_plans'] = formData['lng_term_plans'];
  data['consider_type'] = formData['consider_type'];
  data['script_ptn'] = formData['script_ptn'];
  data['about_us'] = formData['about_us'];
  data['skill_discipline'] = formData['skill_discipline'];
  data['except_learn'] = formData['except_learn'];
  data['awards_achievements'] = formData['awards_achievements'];
  data['interested_in'] = formData['interested_in'];
  data['scripted'] = formData['scripted'];
  return data;
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
