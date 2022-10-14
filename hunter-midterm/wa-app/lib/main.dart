//Import Core Libraries First
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Import Flutter Non Google Libraries
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import "package:universal_html/html.dart";

//Import Everything Else
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:beamer/beamer.dart';
import 'package:wa_app/custom_widgets/request_submitted_page.dart';
import 'package:wa_app/providers/image_provider.dart';
import 'package:wa_app/providers/order_provider.dart';
import 'package:wa_app/providers/payment_card_selection_provider.dart';
import 'package:wa_app/providers/payment_provider.dart';
import 'package:wa_app/providers/producer_provider.dart';
import 'package:wa_app/providers/producer_script_purchase_provider.dart';
import 'package:wa_app/providers/sc_scripts_provider.dart';
import 'package:wa_app/providers/screenwriter_dash_board_provider.dart';
import 'package:wa_app/providers/settings_provider.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/ui/producer_view/producer_main_screen.dart';
import 'package:wa_app/ui/producer_view/producer_screens/producer_selection.dart';
import 'package:wa_app/ui/screen_writer_view/screens/screen_writer_main_screen.dart';
import 'package:wa_app/ui/screen_writer_view/screens/submit_to_marketplace_forms/info_about_script_screen.dart';
import 'package:wa_app/ui/screen_writer_view/screens/submit_to_marketplace_forms/script_submitted_to_marketplace.dart';
import 'package:wa_app/ui/screen_writer_view/screens/submit_to_marketplace_forms/scripts_submittion_steps.dart';
import 'package:wa_app/ui/screen_writer_view/widgets/market_place_or_program_selection_dialog.dart';
import 'package:wa_app/ui/shared/user_registration/forms/producer_application_form.dart';
import 'package:wa_app/ui/shared/user_registration/forms/screen_writer_application_form.dart';
import 'package:wa_app/ui/shared/user_registration/login.dart';
import 'package:wa_app/ui/shared/user_registration/registration_screen.dart';
import 'package:wa_app/ui/shared/user_registration/reset_password_screens/confirm_email_screen.dart';
import 'package:wa_app/ui/shared/user_registration/reset_password_screens/set_new_password_screen.dart';
import 'package:wa_app/ui/shared/user_registration/select_side.dart';
import 'package:wa_app/utills/routes.dart';
//import 'firebase_options.dart';  Used for testing only

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var currentUrl = window.location.href;
  if (currentUrl == "https://flutter-midterm-8d336.web.app" ||
      currentUrl == "https://woaccelerator-dev.web.app/" ||
      currentUrl == "https://woaccelerator-dev.firebaseapp.com/#/" ||
      currentUrl == "https://woaccelerator-dev.web.app/#/" ||
      currentUrl == "http://localhost:4242/#/") {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform);
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCWaJYBzEcfJp7PkwUg9MHQiVspYceSfgA',
      appId: '1:36287972865:web:4d7b3d0ac766323b122200',
      messagingSenderId: '36287972865',
      projectId: 'flutter-midterm-8d336',
      authDomain: 'flutter-midterm-8d336.firebaseapp.com',
      storageBucket: 'flutter-midterm-8d336.appspot.com',
      measurementId: 'G-GL5YXW8H8W',
    ));
    print("test");
  } else if (currentUrl == "https://woaccelerator-qa.firebaseapp.com/" ||
      currentUrl == "https://woaccelerator-qa.web.app/" ||
      currentUrl == "https://woaccelerator-qa.firebaseapp.com/#/" ||
      currentUrl == "https://woaccelerator-qa.web.app/#/") {
    await Firebase.initializeApp(
        //  options: DefaultFirebaseOptions.currentPlatform,
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCWaJYBzEcfJp7PkwUg9MHQiVspYceSfgA',
      appId: '1:36287972865:web:4d7b3d0ac766323b122200',
      messagingSenderId: '36287972865',
      projectId: 'flutter-midterm-8d336',
      authDomain: 'flutter-midterm-8d336.firebaseapp.com',
      storageBucket: 'flutter-midterm-8d336.appspot.com',
      measurementId: 'G-GL5YXW8H8W',
    ));
    print("test2");
  } else if (currentUrl == "https://woaccelerator-pre-prod.firebaseapp.com/" ||
      currentUrl == "https://woaccelerator-preprod.web.app/" ||
      currentUrl == "https://woaccelerator-pre-prod.firebaseapp.com/#/" ||
      currentUrl == "https://woaccelerator-preprod.web.app/#/") {
    await Firebase.initializeApp(
        //  options: DefaultFirebaseOptions.currentPlatform,
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCWaJYBzEcfJp7PkwUg9MHQiVspYceSfgA',
      appId: '1:36287972865:web:4d7b3d0ac766323b122200',
      messagingSenderId: '36287972865',
      projectId: 'flutter-midterm-8d336',
      authDomain: 'flutter-midterm-8d336.firebaseapp.com',
      storageBucket: 'flutter-midterm-8d336.appspot.com',
      measurementId: 'G-GL5YXW8H8W',
    ));
  } else if (currentUrl == "https://flutter-midterm-8d336.web.app" ||
      currentUrl == "https://flutter-midterm-8d336.web.app") {
    await Firebase.initializeApp(
        //  options: DefaultFirebaseOptions.currentPlatform,
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCWaJYBzEcfJp7PkwUg9MHQiVspYceSfgA',
      appId: '1:36287972865:web:4d7b3d0ac766323b122200',
      messagingSenderId: '36287972865',
      projectId: 'flutter-midterm-8d336',
      authDomain: 'flutter-midterm-8d336.firebaseapp.com',
      storageBucket: 'flutter-midterm-8d336.appspot.com',
      measurementId: 'G-GL5YXW8H8W',
    ));
  }

  await GetStorage.init();
  //Beamer.setPathUrlStrategy();
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.instance.webInitialize(
      appId: "225700546408886",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _routerDelegate = BeamerDelegate(
    //initialPath: Routes.screenWriterViewMainScreen,
    notFoundPage: BeamPage(
        key: const ValueKey("login"),
        title: "wa_app",
        child: const LoginScreen()),
    locationBuilder: SimpleLocationBuilder(routes: {
      Routes.login: (context, state) => BeamPage(
          key: const ValueKey("login"),
          title: "wa_app",
          child: const LoginScreen()),
      Routes.registration: (context, state) => BeamPage(
          key: const ValueKey("registration"),
          child: const RegistrationScreen()),
      Routes.selectedSideScreen: (context, state) => BeamPage(
          key: const ValueKey("side_screen"),
          title: "wa_app",
          child: const SelectSideScreen()),
      Routes.screenWriterApplicationForm: (context, state) => BeamPage(
          key: const ValueKey("screen_writer_application_form"),
          title: "wa_app",
          child: const ScreenWriterApplicationForm()),
      Routes.producerApplicationForm: (context, state) => BeamPage(
          key: const ValueKey("producer_application_form"),
          title: "wa_app",
          child: const ProducerApplicationForm()),
      Routes.confirmEmailScreen: (context, state) => BeamPage(
          key: const ValueKey("confirm_email"),
          title: "wa_app",
          child: const ConfirmEmailScreen()),
      Routes.newPasswordScreen: (context, state) => BeamPage(
          key: const ValueKey("new_password_screen"),
          title: "wa_app",
          child: const SetNewPasswordScreen()),
      Routes.screenWriterViewMainScreen: (context, state) => BeamPage(
          key: const ValueKey("screen_writer_main_screen"),
          title: "wa_app",
          child: const ScreenWriterViewMainScreen()),
      Routes.producerViewMainScreen: (context, state) => BeamPage(
          key: const ValueKey("producer_main_screen"),
          title: "wa_app",
          child: const ProducerViewMainScreen()),
      Routes.infoAboutScrept: (context, state) => BeamPage(
          key: const ValueKey("script_info"),
          title: "wa_app",
          child: const InformationAboutScriptForm()),
      Routes.scriptSubmitToMarketPlace: (context, state) => BeamPage(
          key: const ValueKey("submit_script"),
          title: "wa_app",
          child: const ScriptSubmittedToMarketPlace()),
      Routes.scriptSubmissionSteps: (context, state) => BeamPage(
          key: const ValueKey("submission_steps"),
          title: "wa_app",
          child: const ScriptPaymentSubmissionSteps()),
      Routes.requestSubmittedPage: (context, state) => BeamPage(
          key: const ValueKey("request_accepted_page"),
          title: "wa_app",
          child: const RequestSubmittedPage()),
      Routes.writerSelectionPage: (context, state) => BeamPage(
          key: const ValueKey("market_place_selection_page"),
          title: "wa_app",
          child: const WriterSelectionPage()),
      Routes.producerSelctionPage: (context, state) => BeamPage(
          key: const ValueKey("producer_selection"),
          title: "wa_app",
          child: const ProducerSelectionPage()),
    }),
    // guards: [
    //   BeamGuard(
    //     pathBlueprints: [
    //       Routes.login,
    //       Routes.registration,
    //       Routes.confirmEmailScreen,
    //     ],
    //     check: (context, location) =>
    //         context.watch<UserProvider>().authenticated,
    //     guardNonMatching: true,
    //     beamToNamed: Routes.login,
    //   ),
    // ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScreenWriterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProducerScriptPurchaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProducerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScScriptProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentCardSelectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImageUploadingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _routerDelegate,
        title: 'Wo_Accelelerator',
        routeInformationParser: BeamerParser(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
