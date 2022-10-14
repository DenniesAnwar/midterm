class SubscriptionResponseURL {
  String? checkoutUrl;

  SubscriptionResponseURL({this.checkoutUrl});

  SubscriptionResponseURL.fromJson(Map<String, dynamic> json) {
    checkoutUrl = json['checkout_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkout_url'] = checkoutUrl;
    return data;
  }
}
