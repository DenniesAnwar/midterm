import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/network/endpoints.dart';
import 'package:wa_app/network/models/upload_image_model.dart';
import 'package:wa_app/providers/user_provider.dart';

import '../network/init_retrofit.dart';
import '../services/functions/helpers.dart';

class ImageUploadingProvider extends ChangeNotifier {
  final picker = ImagePicker();
  //bool _isLoading = false;

  //bool get isLoading => _isLoading;

  // set isLoading(value){
  //   _isLoading = value;
  //   notifyListeners();
  // }

  UploadImageModel? imageModel;

  Future<dynamic> getImage(ImageSource imageSource) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Uint8List? imageBytes;
    if (result != null) {
      imageBytes = result.files.first.bytes;
    }
    return imageBytes;
  }

  Future<bool> removeAvatar(UserProvider provider) async {
    bool isSuccess = false;
    final client = InitRetrofit.apiService;
    await client!.removeAvatar().then((value) async {
      if (value.status) {
        isSuccess = true;
        provider.userInfo!.avatarUrl = null;
        imageModel = null;

        notifyListeners();
      }
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return isSuccess;
  }

  Future<bool> uploadImageToServer(
      BuildContext context, Uint8List _image) async {
    bool uploadStatus = false;
    String _token = await Provider.of<UserProvider>(context, listen: false)
        .user!
        .getIdToken();
    final formData = FormData();
    formData.files.add(
      MapEntry(
        'avatar',
        MultipartFile.fromBytes(
          _image,
          filename: 'avatar',
          contentType: MediaType('application', 'octet-stream'),
        ),
      ),
    );

    Dio dio = Dio();
    await dio
        .post(
      "${EndPoints.baseUrl}me/avatar",
      data: formData,
      options: Options(contentType: 'multipart/form-data', headers: {
        "Authorization": 'Bearer $_token',
        "Accept": "application/json",
        "Content-Type": "application/json"
      }),
    )
        .then((response) {
      imageModel = UploadImageModel.fromJson(jsonDecode(response.toString()));

      uploadStatus = true;
      notifyListeners();
    }).catchError((error) {
      uploadStatus = false;
    });
    return uploadStatus;
  }
}
