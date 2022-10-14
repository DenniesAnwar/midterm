class CheckoutResponse {
  String? id;
  String? scriptId;
  String? userId;
  String? checkout;
  String? period;
  int? checkoutAmount;
  String? checkoutUrl;
  String? checkoutUntil;
  String? checkoutCompleted;
  String? checkoutCanceled;
  String? createdAt;
  String? updatedAt;

  CheckoutResponse(
      {this.id,
        this.scriptId,
        this.userId,
        this.checkout,
        this.period,
        this.checkoutAmount,
        this.checkoutUrl,
        this.checkoutUntil,
        this.checkoutCompleted,
        this.checkoutCanceled,
        this.createdAt,
        this.updatedAt});

  CheckoutResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scriptId = json['script_id'];
    userId = json['user_id'];
    checkout = json['checkout'];
    period = json['period'];
    checkoutAmount = json['checkout_amount'];
    checkoutUrl = json['checkout_url'];
    checkoutUntil = json['checkout_until'];
    checkoutCompleted = json['checkout_completed'];
    checkoutCanceled = json['checkout_canceled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['script_id'] = scriptId;
    data['user_id'] = userId;
    data['checkout'] = checkout;
    data['period'] = period;
    data['checkout_amount'] = checkoutAmount;
    data['checkout_url'] = checkoutUrl;
    data['checkout_until'] = checkoutUntil;
    data['checkout_completed'] = checkoutCompleted;
    data['checkout_canceled'] = checkoutCanceled;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
