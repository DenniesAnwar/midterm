import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/endpoints.dart';
import 'package:wa_app/network/init_retrofit.dart';
import 'package:wa_app/network/models/category_content_resp_model.dart';
import 'package:wa_app/network/models/checkout_response.dart';
import 'package:wa_app/network/models/script_detail_model.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/constants.dart';

class ScScriptProvider extends ChangeNotifier {
  int _activeWidgetIndex = 0;
  int? _totalScripts = 0;
  List<DataModel> _scripts = [];
  List<DataItemsModel> _contentRatings = [];
  List<DataItemsModel> _genres = [];
  List<DataItemsModel> _budget = [];
  List<DataItemsModel> _timeLines = [];
  List<DataModel> _filteredScripts = [];

  List<DataModel> get scripts => _scripts;
  int? get totalScripts => _totalScripts;
  List<DataModel> get filteredScripts => _filteredScripts;
  List<DataItemsModel> get contentRatings => _contentRatings;
  List<DataItemsModel> get genres => _genres;
  List<DataItemsModel> get budget => _budget;
  List<DataItemsModel> get timeLines => _timeLines;

  set totalScripts(value) {
    _totalScripts = value;
  }

  int get activeWidgetIndex => _activeWidgetIndex;

  set activeWidgetIndex(int value) {
    _activeWidgetIndex = value;
    notifyListeners();
  }

  void filterScripts({required String scriptType}) {
    _filteredScripts = [];
    notifyListeners();
    if (scriptType.toLowerCase() == 'all') {
      _filteredScripts = _scripts;
    } else {
      for (var element in _scripts) {
        if (getScriptStatus(element.application) == scriptType) {
          _filteredScripts.add(element);
        }
      }
    }
    notifyListeners();
  }

  Future<ScriptDetailModel> getScriptById(String scriptId) async {
    final client = InitRetrofit.apiService;
    late ScriptDetailModel model;
    await client!.getScriptById(scriptId).then((value) {
      model = value;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return model;
  }

  Future<void> getUploadDialogData(BuildContext context) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String token = "";
    final box = GetStorage();
    if (user != null) {
      token = await user.getIdToken();
    } else {
      token = box.read(tokenKey) ?? "";
    }
    await InitRetrofit().init(token);
    final client = InitRetrofit.apiService;
    await _getGenres(client);
    await _getBudget(client);
    await _getTimeLines(client);
    await _getContentRating(client);
  }

  List<DataItemsModel> uniqueItemList(theList) {
    List<DataItemsModel> data = [];
    Set<String> theSet = <String>{};
    for (DataItemsModel item in theList) {
      if (theSet.add(item.name!)) {
        data.add(item);
      }
    }
    return data;
  }

  Future<void> _getContentRating(retClient) async {
    await retClient!.contentRatings().then((value) {
      _contentRatings = uniqueItemList(value.data);
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }

  Future<void> _getGenres(retClient) async {
    await retClient!.getGenres().then((value) {
      _genres = uniqueItemList(value.data);
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }

  Future<void> _getBudget(retClient) async {
    await retClient!.getBudget().then((value) {
      _budget = uniqueItemList(value.data);
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }

  Future<void> _getTimeLines(retClient) async {
    await retClient!.getTimeLines().then((value) {
      _timeLines = uniqueItemList(value.data);
      //print(_budget);
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }

  Future<List<DataModel>> getUserScripts() async {
    final client = InitRetrofit.apiService;
    await _getGenres(client);
    await _getTimeLines(client);
    await _getBudget(client);
    await _getContentRating(client);

    await client!.getScripts().then((value) {
      _totalScripts = value.total;
      _scripts = value.data!;
      _filteredScripts = _scripts;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return _scripts;
  }

  Future<void> getUserMarketplaceScripts() async {
    final client = InitRetrofit.apiService;

    await client!.getMarketplaceEarlyAccessScripts().then((value) {
      _totalScripts = value.total;
      _scripts = value.data!;
      _filteredScripts = _scripts;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }

  Future<CheckoutResponse?> marketPlaceCheckout(
      String scriptId, Map<String, dynamic> data) async {
    final client = InitRetrofit.apiService;
    CheckoutResponse? response;
    await client!.marketPlaceCheckout(scriptId, data).then((value) {
      response = value;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
    return response;
  }

  Future<DataModel> uploadScripts(
      BuildContext context, Map<String, dynamic> data) async {
    final client = InitRetrofit.apiService;

    late DataModel fileUploaded;
    await client!.uploadScriptInfo(data).then((value) {
      fileUploaded = value;
      _scripts.add(value);
      notifyListeners();
    });

    return fileUploaded;
  }

  Future<bool> uploadScriptFiles(
      BuildContext context, Map<String, dynamic> data, String scriptId) async {
    bool uploadStatus = false;

    User? user = Provider.of<UserProvider>(context, listen: false).user;

    String token = "";
    final box = GetStorage();
    if (user != null) {
      token = await user.getIdToken();
    } else {
      token = box.read(tokenKey) ?? "";
    }

    final formData = FormData();
    formData.files.addAll([
      MapEntry(
        'treatment',
        MultipartFile.fromBytes(
          data['treatment'],
          filename: 'treatment',
          contentType: MediaType('application', 'octet-stream'),
        ),
      ),
      MapEntry(
        'screenplay',
        MultipartFile.fromBytes(
          data['screenplay'],
          filename: 'screenplay',
          contentType: MediaType('application', 'octet-stream'),
        ),
      )
    ]);

    Dio dio = Dio();
    await dio
        .post(
      "${EndPoints.baseUrl}scripts/$scriptId/upload",
      data: formData,
      options: Options(contentType: 'multipart/form-data', headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "Content-Type": "application/json"
      }),
    )
        .then((response) async {
      await submitScript(scriptId);
      Navigator.of(context).pop();
      Navigator.of(context).maybePop();
      notifyListeners();
      uploadStatus = true;
    }).catchError((error) {
      Navigator.of(context).maybePop();
    });
    return uploadStatus;
  }

  Future<void> submitScript(String scriptId) async {
    final client = InitRetrofit.apiService;
    await client!.submitScript(scriptId).then((value) {}).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
  }

  int getPublishedScriptCount() {
    int counter = 0;

    for (var element in _scripts) {
      if (getScriptStatus(element.application) == ScriptStatus.approved) {
        counter++;
      }
    }
    return counter;
  }

  Future<DataModel> updateScripts(BuildContext context,
      Map<String, dynamic> data, DataModel model, String scriptId) async {
    final client = InitRetrofit.apiService;

    await client!.updateScript(scriptId, data).then((value) {
      _scripts[_scripts.indexOf(model)] = value;
      model = value;
      notifyListeners();
      ShowSnackBar.showSnackBar(context: context, title: 'Script updated.....');
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return model;
  }
}
