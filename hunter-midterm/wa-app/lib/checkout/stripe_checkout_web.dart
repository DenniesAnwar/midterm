@JS()
library stripe;

import 'package:js/js.dart';
import 'package:wa_app/utills/constants.dart';

void redirectToCheckout() {
  Stripe(stripekey).redirectToCheckout(CheckoutOptions(
    lineItems: [
      LineItem(
        price: "price_1K6xs9CrdFKycvGvNpcYAKYj",
        quantity: 1,
      )
    ],
    mode: 'subscription',
    successUrl: 'http://localhost:5000/#/checkout_success',
    cancelUrl: 'http://localhost:5000/#/checkout_cancel',
  ));
}

@JS()
class Stripe {
  external Stripe(String key);
  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external String get sessionId;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
