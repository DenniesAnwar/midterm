import 'package:wa_app/ui/screen_writer_view/screens/sc_dashboard.dart';
import 'package:wa_app/ui/screen_writer_view/screens/sc_marketplace.dart';
import 'package:wa_app/ui/screen_writer_view/screens/sc_script_page.dart';
import 'package:wa_app/ui/shared/settings/settings_main.dart';

import '../../../models/option_item_model.dart';
import '../screens/sc_ciriculum.dart';

class ScreenWriterViewSideMenuOptions {
  static List screenWriterSideMenuButtons = [
    Options(
      title: 'Dashboard',
      iconPath: 'assets/icons/grid.png',
      index: 0,
      loadWidget: const ScDashboard(),
    ),
    Options(
      title: 'My Script',
      iconPath: 'assets/icons/script.png',
      index: 1,
      loadWidget: const ScScriptPage(),
    ),
    Options(
      title: 'Marketplace Scripts',
      iconPath: 'assets/icons/marketplace.png',
      index: 2,
      loadWidget: const ScMarketplacePage(),
    ),
    // Options(
    //   title: 'Schedule',
    //   iconPath: 'assets/icons/schedule.png',
    //   index: 3,
    //   loadWidget: const ScScheduleView(),
    // ),
    Options(
      title: 'Cirriculum',
      iconPath: 'assets/icons/circulum.png',
      index: 3,
      loadWidget: const ScCurriculum(),
    ),
    Options(
      title: 'Settings',
      iconPath: 'assets/icons/settings.png',
      index: 4,
      loadWidget: const SharedSettings(),
    ),
  ];
  static List nonScreenWriterSideMenuButtons = [
    Options(
      title: 'Dashboard',
      iconPath: 'assets/icons/grid.png',
      index: 0,
      loadWidget: const ScDashboard(),
    ),
    Options(
      title: 'My Script',
      iconPath: 'assets/icons/script.png',
      index: 1,
      loadWidget: const ScScriptPage(),
    ),
    Options(
      title: 'Marketplace Scripts',
      iconPath: 'assets/icons/marketplace.png',
      index: 2,
      loadWidget: const ScMarketplacePage(),
    ),
    Options(
      title: 'Settings',
      iconPath: 'assets/icons/settings.png',
      index: 3,
      loadWidget: const SharedSettings(),
    ),
  ];
}
