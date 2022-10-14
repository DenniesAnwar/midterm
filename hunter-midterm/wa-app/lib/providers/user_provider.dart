import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as fr;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/network/init_retrofit.dart';
import 'package:wa_app/network/models/country_model.dart';
import 'package:wa_app/network/models/create_bank_acocunt.dart';
import 'package:wa_app/network/models/me_response.dart';
import 'package:wa_app/network/models/onboarding_response.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/utills/constants.dart';

class UserProvider extends ChangeNotifier {
  fr.User? _user;

  bool _isLoading = false;

  fr.User? get user => _user;
  bool _isProducer = false;
  String _accountType = '';
  String _applicationId = '';

  bool get isProducer => _isProducer;
  String get accountType => _accountType;
  String get applicationId => _applicationId;

  List<CountryModel> _countryList = [];
  List<CountryModel> get countryList => _countryList;

  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  set countryList(countryList) {
    _countryList = countryList;
  }

  set isProducer(value) {
    _isProducer = value;
  }

  set accountType(value) {
    _accountType = value;
  }

  set applicationId(value) {
    _applicationId = value;
  }

  set user(user) {
    _user = user;
    notifyListeners();
  }

  bool _authenticated = false;

  bool get authenticated => _authenticated;
  set authenticated(value) {
    _authenticated = value;
  }

  MeResponse? _userInfo;

  MeResponse? get userInfo => _userInfo;

  set userInfo(userInfo) {
    _userInfo = userInfo;
  }

  UserProvider() {
    fr.User? _autUser = fr.FirebaseAuth.instance.currentUser;

    if (_autUser == null) {
      _authenticated = false;
      notifyListeners();
    } else {
      _authenticated = true;
      _user = _autUser;
      notifyListeners();
    }
  }
  Future<List<CountryModel>> getCountryList() async {
    // String token = await user.getIdToken();
    // await InitRetrofit().init("");
    // final client = InitRetrofit.apiService;
    // await client!.getCountries().then((value) async {
    //   _countryList = value;
    // }).catchError((onError) {
    //   switch (onError.runtimeType) {
    //     case DioError:
    //       var response = (onError as DioError).response;
    //       Helpers.logger.e("Got error :-> $response");
    //       break;
    //     default:
    //   }
    // });

    _countryList.add(CountryModel(countryCode: 'US', countryName: 'USA'));

    return _countryList;
  }

  Future<OnBoardingResponse?> getOnBoardLink() async {
    OnBoardingResponse? onBoardingResponse;

    final client = InitRetrofit.apiService;
    await client!.getOnBoardingLink({
      "refresh_url": OnBoardUrls.refreshUrl,
      "return_url": OnBoardUrls.retrunUrl,
    }).then((value) async {
      onBoardingResponse = value;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return onBoardingResponse;
  }

  Future<CreateBankAccount?> connectBankAccount(data) async {
    CreateBankAccount? createBankAccount;

    final client = InitRetrofit.apiService;
    await client!.connectBankAccount(data).then((value) async {
      createBankAccount = value;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return createBankAccount;
  }

  Future<MeResponse?> getUserInfo() async {
    String token = "";
    final box = GetStorage();
    if (user != null) {
      token = await user!.getIdToken();
    } else {
      token = box.read(tokenKey) ?? "";
    }
    await InitRetrofit().init(token);
    final client = InitRetrofit.apiService;
    await client!.getUserInfo().then((value) async {
      _userInfo = value;
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
    return _userInfo;
  }

  Future<MeResponse?> updateCurrentUser(Map<String, dynamic> data) async {
    String token = "";
    final box = GetStorage();
    if (user != null) {
      token = await user!.getIdToken();
    } else {
      token = box.read(tokenKey) ?? "";
    }
    await InitRetrofit().init(token);
    final client = InitRetrofit.apiService;
    await client!.updateCurrentUser(data).then((value) async {
      _userInfo = value;
      notifyListeners();
    }).catchError((onError) {
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });

    return userInfo!;
  }

  Future<String> getScWriterApplications(
    BuildContext context,
  ) async {
    final client = InitRetrofit.apiService;
    String status = ApplicationStatus.notSubmitted;
    await client!.getWriterApplications().then((value) {
      if (value.data!.isNotEmpty) {
        if (value.data![0].rejectedAt != null) {
          status = ApplicationStatus.rejected;
        } else {
          status = ApplicationStatus.accpted;
        }
      } else {
        status = ApplicationStatus.notSubmitted;
      }
    }).catchError((onError) {
      Navigator.of(context).maybePop();
      ShowSnackBar.showSnackBar(
          context: context, title: 'Something went wrong!');
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
    return status;
  }

  Future<bool?> getProducerApplications(
    BuildContext context,
  ) async {
    final client = InitRetrofit.apiService;
    bool isRejected = false;
    await client!.getProducerApplications().then((value) {
      if (value.data![0].rejectedAt != null) {
        isRejected = true;
      } else {
        isRejected = false;
      }
    }).catchError((onError) {
      Navigator.of(context).maybePop();
      ShowSnackBar.showSnackBar(
          context: context, title: 'Something went wrong!');
      switch (onError.runtimeType) {
        case DioError:
          var response = (onError as DioError).response;
          Helpers.logger.e("Got error :-> $response");
          break;
        default:
      }
    });
    return isRejected;
  }

  Future<void> passwordChanged() async {
    final client = InitRetrofit.apiService;
    await client!.passwordChanged().then((value) {
      //print(value.toString());
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
}
