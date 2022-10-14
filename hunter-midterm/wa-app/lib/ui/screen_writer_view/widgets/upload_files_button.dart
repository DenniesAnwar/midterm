import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class UploadFilesButtons extends StatefulWidget {
  const UploadFilesButtons(
      {Key? key, required this.uploadFile, required this.title})
      : super(key: key);
  final String title;
  final Function(File) uploadFile;
  @override
  State<UploadFilesButtons> createState() => _UploadFilesButtonsState();
}

class _UploadFilesButtonsState extends State<UploadFilesButtons> {
  String chosenFileName = 'No File Chosen';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          _customButton(Colors.grey[200]!, Colors.black, widget.title,
              () async {
            FilePickerResult? result = await FilePicker.platform
                .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
            if (result != null) {
              // File file = File(String.fromCharCodes(result.files.first.bytes!));
              File file = File(result.files.first.bytes!.toString());
              widget.uploadFile(file);

              chosenFileName = result.files.first.name.toLowerCase();
            } else {
              // User canceled the picker
            }
            setState(() {});
          }),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              chosenFileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadFilesButtonsWithTitle extends StatefulWidget {
  const UploadFilesButtonsWithTitle(
      {Key? key, required this.uploadFile, required this.title})
      : super(key: key);
  final String title;
  final Function(dynamic) uploadFile;
  @override
  State<UploadFilesButtonsWithTitle> createState() =>
      _UploadFilesButtonsWithTitleState();
}

class _UploadFilesButtonsWithTitleState
    extends State<UploadFilesButtonsWithTitle> {
  String chosenFileName = 'Choose file (max size 1 MB)';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
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
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['pdf']);

                if (result != null) {
                  Uint8List bytes = result.files.first.bytes!;
                  int fileSizeInBytes = bytes.length;
                  // i=["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

                  var i = (log(fileSizeInBytes) / log(1024)).floor();
                  final fileSize = fileSizeInBytes / pow(1024, i);
                  if (i < 2 || (i == 2 && fileSize < 1)) {
                    widget.uploadFile(bytes);

                    chosenFileName = result.files.first.name;
                  } else {
                    widget.uploadFile(
                        "File size should be not be greater then 1 mb");
                    setState(() {
                      chosenFileName = 'Choose file (max size 1 MB)';
                    });
                  }
                } else {
                  // User canceled the picker
                }
                setState(() {});
              },
              child: Container(
                color: kUploadDottedButtonColor,
                width: 250,
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
                      children: [
                        const Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.blue,
                          size: 23,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            chosenFileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
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
      ),
    );
  }
}

Widget _customButton(
    Color bgColor, Color txtColor, String text, GestureTapCallback onPress) {
  return InkWell(
    onTap: onPress,
    child: Container(
      width: 100,
      height: 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: bgColor),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: txtColor, fontSize: 13),
        ),
      ),
    ),
  );
}
