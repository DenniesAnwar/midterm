// ignore: implementation_imports
import 'package:beamer/src/beamer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/custom_widgets/buttons.dart';
import 'package:wa_app/custom_widgets/text_fields.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/producer_view/pro_widgets/drop_menu_filter_widget.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/footer_widget.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/constants.dart';
import 'package:wa_app/utills/routes.dart';
import 'package:wa_app/utills/styles.dart';

class InformationAboutScriptForm extends StatefulWidget {
  const InformationAboutScriptForm({Key? key}) : super(key: key);

  @override
  _InformationAboutScriptFormState createState() =>
      _InformationAboutScriptFormState();
}

class _InformationAboutScriptFormState
    extends State<InformationAboutScriptForm> {
  double _topLgContainer = 0.0;
  double _bottomLgContainer = 0.0;
  double _middleLgContainer = 0.0;
  double _allContainerHeights = 0.0;

  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SafeArea(
        child: Scaffold(
      body: MediaQuery.of(context).size.height < 665 ||
              MediaQuery.of(context).size.width < 820
          ? _smBody(context)
          : _lgBody(context),
    ));
  }

  Widget _smBody(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadMenu(),
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              alignment: Alignment.center,
              image:
                  AssetImage('assets/images/screenwriter_type_selection.jpg'),
            )),
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Information about the script',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.screenWidth > 1100 ? 26 : 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 475,
                    child: Text(
                      loremIpsumText,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: kProfileNameTextStyle.copyWith(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _loadForm(context),
          SizeConfig.screenHeight > 820
              ? const Spacer()
              : SizedBox(
                  height: SizeConfig.screenWidth < 920
                      ? SizeConfig.heightMultiplier * 9.68
                      : SizeConfig.heightMultiplier * 13.68,
                ),
          const Footer(),
        ],
      ),
    );
  }

  Widget _loadForm(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    return Container(
      constraints: const BoxConstraints(
        minHeight: 300,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 19, bottom: 12.0, left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please fill in all the information before you submit your script',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                minWidth: 400,
              ),
              width: 820,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 820,
                      child: Wrap(
                        spacing:
                            2, // to apply margin in the main axis of the wrap
                        runSpacing: 0, //
                        children: [
                          _genreModule(),
                          _categoryModule(),
                          _pagesModule(),
                          _mPaaRatingModule(),
                          _budgetRatingModule(),
                          _storiesModule(),
                          _timePeriodModule(),
                          _placeModule(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _uploadPdfModule(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Buttons.customPrimaryButton(
                            buttonHeight: 45,
                            fontSize: 14,
                            onPressed: () {
                              context.beamToNamed(Routes.selectedSideScreen);
                            },
                            title: 'Back',
                            buttonColor: Colors.white,
                            borderColor: Colors.red,
                            textColor: Colors.red),
                        const SizedBox(
                          width: 12,
                        ),
                        Buttons.customPrimaryButton(
                            buttonHeight: 45,
                            onPressed: () {
                              context.beamToNamed(
                                  Routes.scriptSubmitToMarketPlace);
                            },
                            title: 'Send',
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onSaved(String key, String value) {
    _formData[key] = value;
  }

  _genreModule() => _widgetWithLabel(
      FilterDropDownMenu(
        optionList: const [
          'Genre',
          'Rated',
          'Budget',
          'Timeline',
          'Pages',
          'Similar Stories',
          'Where',
        ],
        onChangedFunction: (val) {},
      ),
      'Genre');
  _categoryModule() => _widgetWithLabel(
      FilterDropDownMenu(
        optionList: const [
          'Genre',
          'Rated',
          'Budget',
          'Timeline',
          'Pages',
          'Similar Stories',
          'Where',
        ],
        onChangedFunction: (val) {},
      ),
      'Category');
  _pagesModule() => _widgetWithLabel(
      TextFields.withoutController(
          hint: 'Pages',
          mapKey: 'pages',
          onSaved: _onSaved),
      'Pages');
  _mPaaRatingModule() => _widgetWithLabel(
      FilterDropDownMenu(
        optionList: const [
          'Genre',
          'Rated',
          'Budget',
          'Timeline',
          'Pages',
          'Similar Stories',
          'Where',
        ],
        onChangedFunction: (val) {},
      ),
      'MPAA Rating');
  _budgetRatingModule() => _widgetWithLabel(
      FilterDropDownMenu(
        optionList: const [
          'Genre',
          'Rated',
          'Budget',
          'Timeline',
          'Pages',
          'Similar Stories',
          'Where',
        ],
        onChangedFunction: (val) {},
      ),
      'Budget');
  _storiesModule() => _widgetWithLabel(
      TextFields.withoutController(
          hint: 'Similar Stories',
          mapKey: 'similar_stories',
          onSaved: _onSaved),
      'Similar Stories');
  _timePeriodModule() => _widgetWithLabel(
      TextFields.withoutController(
          hint: 'Time Period',
          mapKey: 'time_period',
          onSaved: _onSaved),
      'Time Period');
  _placeModule() => _widgetWithLabel(
      TextFields.withoutController(
          hint: 'Place',
          mapKey: 'place',
          onSaved: _onSaved),
      'Place');

  _uploadPdfModule() => Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Treatment (Pdf)',
              style: kProfileNameTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                color: kUploadDottedButtonColor,
                width: 214,
                child: DottedBorder(
                  strokeCap: StrokeCap.butt,
                  dashPattern: const [9, 6],
                  borderType: BorderType.RRect,
                  strokeWidth: 1.8,
                  radius: const Radius.circular(8),
                  color: Colors.blue.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.blue,
                          size: 23,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Drag and drop your pdf here',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _lgBody(BuildContext context) {
    SizeConfig().init(MediaQuery.of(context).size);

    _topLgContainer = MediaQuery.of(context).size.width < 1400 ? 240 : 260;
    _bottomLgContainer = 325;
    _middleLgContainer = MediaQuery.of(context).size.width < 1400 ? 90 : 120;
    _allContainerHeights =
        _middleLgContainer + _topLgContainer + _bottomLgContainer;

    return ((_allContainerHeights + 20 + 450) >
            MediaQuery.of(context).size.height)
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: _middleLgContainer, child: const LoadMenu()),
                Container(
                  height: _topLgContainer,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        'assets/images/screenwriter_type_selection.jpg'),
                  )),
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth > 1100
                            ? SizeConfig.screenWidth > 1400
                                ? 150
                                : 80
                            : 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Information about the script',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.screenWidth > 1100
                                  ? SizeConfig.screenWidth > 1400
                                      ? 50
                                      : 26
                                  : 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 475,
                          child: Text(
                            loremIpsumText,
                            maxLines: 2,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            style: kProfileNameTextStyle.copyWith(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _loadForm(context),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(height: _bottomLgContainer, child: const Footer()),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _middleLgContainer, child: const LoadMenu()),
              Container(
                height: _topLgContainer,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  image: AssetImage(
                      'assets/images/screenwriter_type_selection.jpg'),
                )),
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth > 1100
                          ? SizeConfig.screenWidth > 1400
                              ? 150
                              : 80
                          : 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Information about the script',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.screenWidth > 1100
                                ? SizeConfig.screenWidth > 1400
                                    ? 50
                                    : 26
                                : 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 475,
                        child: Text(
                          loremIpsumText,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: kProfileNameTextStyle.copyWith(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _loadForm(context),
              const Spacer(),
              SizedBox(height: _bottomLgContainer, child: const Footer()),
            ],
          );
  }

  _widgetWithLabel(Widget child, String title) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kProfileNameTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(width: 250, child: child)
          ],
        ),
      );
}
