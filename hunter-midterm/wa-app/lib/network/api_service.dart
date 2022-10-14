import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:wa_app/network/endpoints.dart';
import 'package:wa_app/network/models/category_content_resp_model.dart';
import 'package:wa_app/network/models/country_model.dart';
import 'package:wa_app/network/models/order_response.dart';
import 'package:wa_app/network/models/producer_form_response.dart';
import 'package:wa_app/network/models/me_response.dart';
import 'package:wa_app/network/models/producer_get_application_response.dart';
import 'package:wa_app/network/models/remove_avatar_resp.dart';
import 'package:wa_app/network/models/script_detail_model.dart';
import 'package:wa_app/network/models/script_model.dart';
import 'package:wa_app/network/models/writer_form_response.dart';
import 'package:wa_app/network/models/writer_get_application_response.dart';
import 'models/checkout_response.dart';
import 'models/create_bank_acocunt.dart';
import 'models/onboarding_response.dart';
import 'models/subscription.dart';
import 'models/upload_image_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create({String? baseUrl}) {
    return baseUrl == null
        ? ApiService(Dio())
        : ApiService(Dio(), baseUrl: baseUrl);
  }

//

  /// Settings functions ------------------------------------------------------
  @MultiPart()
  @POST("${EndPoints.me}/avatar")
  Future<UploadImageModel> uploadProfilePic(
    @Part(name: 'avatar') File profileImage,
  );

  /// User info requests -------------------------------------------------------
  @GET(EndPoints.me)
  @Headers({
    "Content-Type": "application/json",
  })
  Future<MeResponse> getUserInfo();

  @POST(EndPoints.removeAvatar)
  Future<RemoveAvatarResp> removeAvatar();

  @POST(EndPoints.passwordChanged)
  Future<dynamic> passwordChanged();

  @PUT(EndPoints.me)
  Future<MeResponse> updateUserName(@Body() Map<String, dynamic> data);

  @PUT(EndPoints.me)
  Future<MeResponse> updateUserActiveStatus(@Body() Map<String, dynamic> data);

  /// update currentUser ---------------------------------------------------------
  @PUT(EndPoints.me)
  Future<MeResponse> updateCurrentUser(@Body() Map<String, dynamic> data);

  /// Script requests ------------------------------------------------------------
  @GET(EndPoints.scripts)
  Future<ScriptResponse> getScripts();

  @POST(EndPoints.onBoarding)
  Future<OnBoardingResponse> getOnBoardingLink(
      @Body() Map<String, dynamic> data);

  @POST(EndPoints.connectBankAccount)
  Future<CreateBankAccount> connectBankAccount(
      @Body() Map<String, dynamic> data);

  @GET(EndPoints.countries)
  Future<List<CountryModel>> getCountries();

  @POST(EndPoints.scripts)
  Future<DataModel> uploadScriptInfo(@Body() Map<String, dynamic> data);

  @GET(EndPoints.genres)
  Future<CategoryContentRespModel> getGenres();
  @GET(EndPoints.budget)
  Future<CategoryContentRespModel> getBudget();

  @GET(EndPoints.timeLines)
  Future<CategoryContentRespModel> getTimeLines();

  @GET(EndPoints.categories)
  Future<CategoryContentRespModel> getCategories();

  @GET(EndPoints.contentRatings)
  Future<CategoryContentRespModel> contentRatings();

  @GET("${EndPoints.scripts}/{scriptId}")
  Future<ScriptDetailModel> getScriptById(@Path() String scriptId);

  @PUT("${EndPoints.scripts}/{scriptId}")
  Future<DataModel> updateScript(
      @Path() String scriptId, @Body() Map<String, dynamic> data);

  @POST("${EndPoints.scripts}/{scriptId}/submit")
  Future<dynamic> submitScript(@Path() String scriptId);

  /// form requests -----------------------------------------------

  @POST(EndPoints.applicationProducer)
  @Headers({
    "Content-Type": "application/json",
  })
  Future<ProducerFormResponse> uploadProducerFormData(
      @Body() Map<String, dynamic> data);

  @POST(EndPoints.applicationWriter)
  @Headers({
    "Content-Type": "application/json",
  })
  Future<WriterFormResponse> uploadScreenWriterFormData(
      @Body() Map<String, dynamic> data);

  @GET(EndPoints.applications)
  @Headers({
    "Content-Type": "application/json",
  })
  Future<GetScreenWriterApplicationResponse> getWriterApplications();
  @GET(EndPoints.applications)
  @Headers({
    "Content-Type": "application/json",
  })
  Future<GetProducerApplicationResponse> getProducerApplications();

  @GET("${EndPoints.applications}/{applicationId}")
  @Headers({
    "Content-Type": "application/json",
  })
  Future<WriterFormResponse> getApplicationById(@Path() String applicationId);

  /// subscriptions
  @POST("${EndPoints.billing}/subscribe")
  Future<SubscriptionResponseURL> scriptPaymentSubscription(
    @Body() Map<String, dynamic> data,
  );

  /// marketplace scripts

  @GET(EndPoints.marketplace)
  Future<ScriptResponse> getMarketplaceScripts();

  @GET(EndPoints.orders)
  Future<OrderResponse> getOrders();

  @GET("${EndPoints.marketplace}/early-access")
  Future<ScriptResponse> getMarketplaceEarlyAccessScripts();

  @POST("${EndPoints.marketplace}/checkout/{scriptId}")
  Future<CheckoutResponse> marketPlaceCheckout(
      @Path() String scriptId, @Body() Map<String, dynamic> data);
}
