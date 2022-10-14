import 'package:wa_app/ui/producer_view/producer_screens/my_orders_screen.dart';
import 'package:wa_app/ui/producer_view/producer_screens/pro_market_place.dart';
import 'package:wa_app/ui/shared/settings/settings_main.dart';
import '../../../models/option_item_model.dart';

class ProducerSideMenuOptions {
  static List producerSideMenuButtons = [
    Options(
      title: 'Marketplace',
      iconPath: 'assets/icons/marketplace.png',
      index: 0,
      loadWidget: const MarketPlace(),
    ),
    Options(
      title: 'My Orders',
      iconPath: 'assets/icons/my_orders.png',
      index: 1,
      //todo: make sure to pass the plan type either basic or premier
      loadWidget: const MyOrdersScreen(isPremier: false,isFullMember: true,),
    ),

    Options(
      title: 'Settings',
      iconPath: 'assets/icons/settings.png',
      index: 2,
      loadWidget: const SharedSettings(),
    ),


  ];
}
