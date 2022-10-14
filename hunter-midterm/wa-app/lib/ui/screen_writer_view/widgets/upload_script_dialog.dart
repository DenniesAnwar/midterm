import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/network/models/category_content_resp_model.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/drop_menu_filter_widget.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/upload_files_button.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

showUploadScriptDialog(BuildContext context,
    {bool isFromNonScriptWriter = false}) {
  return Helpers.showAppDialog(
      context: context,
      widget: SizedBox(
          width: 720,
          height: 650,
          child: UploadScriptDialog(isFromNonScriptWriter)));
}

class UploadScriptDialog extends StatefulWidget {
  final bool isNonScreenWriter;
  const UploadScriptDialog(this.isNonScreenWriter, {Key? key})
      : super(key: key);

  @override
  _UploadScriptDialogState createState() => _UploadScriptDialogState();
}

final Map<String, dynamic> _uploadingData = {};

class _UploadScriptDialogState extends State<UploadScriptDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late ScScriptProvider scriptProvider;
  bool _isLoading = true;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  String _errorMessage = "";
  @override
  void initState() {
    scriptProvider = Provider.of<ScScriptProvider>(context, listen: false);
    if (scriptProvider.genres.isEmpty &&
        scriptProvider.budget.isEmpty &&
        scriptProvider.contentRatings.isEmpty &&
        scriptProvider.timeLines.isEmpty) {
      Future.microtask(() async {
        await scriptProvider.getUploadDialogData(context);
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      if (scriptProvider.genres.isNotEmpty) {
        _uploadingData['genres'] = [scriptProvider.genres.first.id];
      }

      if (scriptProvider.contentRatings.isNotEmpty) {
        _uploadingData['content_rating_id'] =
            scriptProvider.contentRatings.first.id;
      }

      if (scriptProvider.budget.isNotEmpty) {
        _uploadingData['budget_id'] = scriptProvider.budget.first.id;
      }
      if (scriptProvider.timeLines.isNotEmpty) {
        _uploadingData['timeline_id'] = scriptProvider.timeLines.first.id;
      }
      setState(() {
        _isLoading = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : SizedBox(
              width: 720,
              height: 650,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                      child: Row(
                        children: [
                          Text(
                            'Upload your script',
                            overflow: TextOverflow.ellipsis,
                            style: kProfileNameTextStyle.copyWith(
                              fontSize: SizeConfig.screenHeight > 680 ? 20 : 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: const CloseButton())
                        ],
                      ),
                    ),
                    Form(
                        key: _formKey,
                        autovalidateMode: _autoValidate,
                        child: _formBody(context)),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Buttons.customPrimaryButton(
                            buttonHeight: 35,
                            buttonWidth: 80,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            title: 'Back',
                            buttonColor: Colors.white,
                            textColor: Colors.red),
                        const SizedBox(
                          width: 12,
                        ),
                        Buttons.customPrimaryButton(
                            buttonHeight: 35,
                            buttonWidth: 105,
                            title: 'Upload',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_uploadingData['treatment'] == null ||
                                    _uploadingData['screenplay'] == null) {
                                  setState(() {
                                    _errorMessage =
                                        "Treatment (pdf) and Screenplay (pdf) both required";
                                  });
                                  return;
                                }
                                _formKey.currentState!.save();
                                Map<String, dynamic> fileMap = {};
                                Map<String, dynamic> infoMap = {};
                                fileMap = _filesMap(_uploadingData);
                                infoMap = _infoMap(_uploadingData);

                                // _uploadingData.remove('treatment');
                                // _uploadingData.remove('screenplay');

                                Helpers.showAppDialog(
                                    context: context, widget: loadingWidget());

                                DataModel _script =
                                    await Provider.of<ScScriptProvider>(context,
                                            listen: false)
                                        .uploadScripts(context, infoMap);

                                await Provider.of<ScScriptProvider>(context,
                                        listen: false)
                                    .uploadScriptFiles(
                                        context, fileMap, _script.id!);

                                _uploadingData.remove('treatment');
                                _uploadingData.remove('screenplay');
                                Navigator.pop(context);
                                Navigator.of(context).pop();
                                setState(() {});
                              } else {
                                setState(() {
                                  _autoValidate = AutovalidateMode.always;
                                });
                              }
                            }),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _formBody(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          _sectionTitle('1', 'Marketplace Details'),
          Container(
            constraints: const BoxConstraints(
              minWidth: 400,
            ),
            width: 820,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 820,
                  child: Wrap(
                    spacing: 2, // to apply margin in the main axis of the wrap
                    runSpacing: 0, //
                    children: [
                      _genreModule(),
                      _mPaaRatingModule(),
                      _timePeriodModule(_onSaved),
                      _pagesModule(_onSaved),
                      _storiesModule(_onSaved),
                      _placeModule(_onSaved),
                      _budgetRatingModule(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          _sectionTitle('2', 'Script Details'),
          DialogTextFieldWithLabel(
            title: 'Title',
            mapKey: 'title',
            errorMessage: 'Script title required',
            onSaved: _onSaved,
          ),
          DialogTextFieldWithLabel(
            title: 'Synopsis',
            mapKey: 'synopsis',
            errorMessage: 'Synopsis required',
            onSaved: _onSaved,
          ),
          DialogTextFieldWithLabel(
            title: 'Log Line',
            mapKey: 'logline',
            errorMessage: 'log line required',
            onSaved: _onSaved,
          ),
          DialogTextFieldWithLabel(
            title: 'Tag Line',
            mapKey: 'tagline',
            errorMessage: 'Tag line required',
            onSaved: _onSaved,
          ),
          const SizedBox(
            height: 15,
          ),
          _uploadPdfModule(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              _errorMessage,
              style: const TextStyle(
                  color: kRedColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  _uploadPdfModule() => SizedBox(
        width: 600,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: UploadFilesButtonsWithTitle(
                uploadFile: (dynamic data) {
                  if (data is String) {
                    setState(() {
                      _errorMessage = data;
                    });
                    _uploadingData.remove('treatment');
                  } else {
                    setState(() {
                      _errorMessage = "";
                    });
                    _uploadingData['treatment'] = data;
                  }
                },
                title: 'Treatment (Pdf)',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: UploadFilesButtonsWithTitle(
                uploadFile: (dynamic data) {
                  if (data is String) {
                    setState(() {
                      _errorMessage = data;
                    });
                    _uploadingData.remove('screenplay');
                  } else {
                    setState(() {
                      _errorMessage = "";
                    });
                    _uploadingData['screenplay'] = data;
                  }
                },
                title: 'Screenplay (Pdf)',
              ),
            ),
          ],
        ),
      );

  _sectionTitle(String number, title) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 12),
        child: Text.rich(
          TextSpan(
            text: '$number. ', // default text style
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            children: [
              TextSpan(
                  text: title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      );

  _onSaved(String key, String value) {
    _uploadingData[key] = value;
  }

  _genreModule() => _widgetWithLabel(
      FilterDropDownMenu(
        applyBorder: false,
        optionList: [...scriptProvider.genres.map((e) => e.name.toString())],
        onChangedFunction: (val) {
          DataItemsModel item = scriptProvider.genres
              .singleWhere((element) => element.name == val);
          _uploadingData['genres'] = [item.id];
        },
      ),
      'Genre');

  _pagesModule(_onSaved) => _widgetWithLabel(
      TextFields.withoutController(
          isFilled: true,
          fillColor: kDropdownContainerColor,
          hint: 'ie. 120',
          mapKey: 'pages',
          onSaved: _onSaved),
      'Pages');
  _mPaaRatingModule() => _widgetWithLabel(
      FilterDropDownMenu(
        applyBorder: false,
        optionList: [
          ...scriptProvider.contentRatings.map((e) => e.name.toString())
        ],
        onChangedFunction: (val) {
          DataItemsModel item = scriptProvider.contentRatings
              .singleWhere((element) => element.name == val);
          _uploadingData['content_rating_id'] = item.id;
        },
      ),
      'MPAA Rating');
  _budgetRatingModule() => _widgetWithLabel(
      FilterDropDownMenu(
        applyBorder: false,
        width: 425,
        optionList: [...scriptProvider.budget.map((e) => e.name.toString())],
        onChangedFunction: (val) {
          DataItemsModel item = scriptProvider.budget
              .singleWhere((element) => element.name == val);
          _uploadingData['budget_id'] = item.id;
        },
      ),
      'Budget',
      width: 425);
  _storiesModule(_onSaved) => _widgetWithLabel(
      TextFields.withoutController(
          isFilled: true,
          fillColor: kDropdownContainerColor,
          hint: 'ie. Gone with the wind',
          mapKey: 'similar_stories',
          onSaved: (ky, val) {}),
      'Similar Stories');
  _timePeriodModule(_onSaved) => _widgetWithLabel(
      FilterDropDownMenu(
        applyBorder: false,
        optionList: [...scriptProvider.timeLines.map((e) => e.name.toString())],
        onChangedFunction: (val) {
          DataItemsModel item = scriptProvider.timeLines
              .singleWhere((element) => element.name == val);
          _uploadingData['timeline_id'] = item.id;
        },
      ),
      'Timeline');
  _placeModule(_onSaved) => _widgetWithLabel(
      TextFields.withoutController(
          isFilled: true,
          fillColor: kDropdownContainerColor,
          hint: 'ie. New York',
          mapKey: 'where',
          onSaved: _onSaved),
      'Place');
}

Map<String, dynamic> _infoMap(Map<String, dynamic> uploadingData) {
  Map<String, dynamic> data = {};
  uploadingData.forEach((key, value) {
    if (key == 'pages') {
      data[key] = int.parse(value);
    }
    if (!(key == 'treatment' || key == 'screenplay')) {
      data[key] = value;
    }
  });

  return data;
}

Map<String, dynamic> _filesMap(Map<String, dynamic> uploadingData) {
  Map<String, dynamic> data = {};
  data['treatment'] = uploadingData['treatment'];
  data['screenplay'] = uploadingData['screenplay'];
  return data;
}

class DialogTextFieldWithLabel extends StatelessWidget {
  const DialogTextFieldWithLabel(
      {Key? key,
      required this.title,
      required this.errorMessage,
      required this.mapKey,
      required this.onSaved})
      : super(key: key);
  final String title;
  final String mapKey;
  final String errorMessage;
  final Function onSaved;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.heightMultiplier * 0.415,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFields.withoutController(
              borderRoundness: SizeConfig.heightMultiplier * 0.672,
              isFilled: true,
              fillColor: kDropdownContainerColor,
              hint: title,
              mapKey: mapKey,
              onSaved: onSaved,
              errorMessage: errorMessage),
        ],
      ),
    );
  }
}

// String _pickFile({key}) async {
//   FilePickerResult? result = await FilePicker.platform
//       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//   if (result != null) {
//     Uint8List bytes = result.files.first.bytes!;
//     _uploadingData[key] = bytes;
//     return result.files.first.name;
//   }
// }

_widgetWithLabel(Widget child, String title, {double width = 200}) => Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(width: width, child: child)
        ],
      ),
    );
