// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/models/sc_current_status_model.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/resources/size_config.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/sc_current_status_widget.dart';
import 'package:wa_app/utills/styles.dart';

class MyCurrentStatus extends StatelessWidget {
  MyCurrentStatus(
      {Key? key, this.heightSize = 0.0, this.size = const Size(0.0, 0.0)})
      : super(key: key);
  double heightSize;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    heightSize = size.height / 100;
    SizeConfig().init(MediaQuery.of(context).size);
    ScCurrentStatusInfoList().getStatusInfo(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
      ),
      child: Consumer<ScreenWriterProvider>(builder: (_, writerProvider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: heightSize * 0.867, bottom: heightSize * 5.667),
              child: Text(
                'My Current Status',
                style: kProfileNameTextStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.screenHeight < 680 ? 15 : 20),
              ),
            ),
            ...List.generate(
                writerProvider.isScreenWriter
                    ? ScCurrentStatusInfoList.screenWriter.length
                    : ScCurrentStatusInfoList.nonScreenWriter.length, (index) {
              var item = writerProvider.isScreenWriter
                  ? ScCurrentStatusInfoList.screenWriter[index]
                  : ScCurrentStatusInfoList.nonScreenWriter[index];
              return ScCurrentStatusInfoTile(statusModel: item);
            })
          ],
        );
      }),
    );
  }
}
