import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_side_menu.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';

class ScreenWriterViewMainScreen extends StatefulWidget {
  const ScreenWriterViewMainScreen({Key? key}) : super(key: key);

  @override
  _ScreenWriterViewMainScreenState createState() =>
      _ScreenWriterViewMainScreenState();
}

class _ScreenWriterViewMainScreenState
    extends State<ScreenWriterViewMainScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    if (Provider.of<UserProvider>(context, listen: false).userInfo == null) {
      Future.microtask(() async {
        await Helpers.getUserData(context);
        if (Provider.of<UserProvider>(context, listen: false)
                .userInfo!
                .accountType ==
            'writer_non_program') {
          Provider.of<ScreenWriterProvider>(context, listen: false)
              .isScreenWriter = false;
        } else {
          Provider.of<ScreenWriterProvider>(context, listen: false)
              .isScreenWriter = true;
        }
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? Center(
                child: loadingWidget(),
              )
            : Row(
                children: [
                  const ScreenWriterSideMenu(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Consumer<ScreenWriterProvider>(
                        builder: (_, dashProvider, __) {
                          return dashProvider.activeWidget;
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
