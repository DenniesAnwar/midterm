class ConnectBankAccountResp {
  String? id;
  String? object;
  String? account;
  String? accountHolderName;
  String? accountHolderType;
  String? accountType;
  List<String>? availablePayoutMethods;
  String? bankName;
  String? country;
  String? currency;
  bool? defaultForCurrency;
  String? fingerprint;
  String? last4;
  String? routingNumber;
  String? status;

  ConnectBankAccountResp(
      {this.id,
      this.object,
      this.account,
      this.accountHolderName,
      this.accountHolderType,
      this.accountType,
      this.availablePayoutMethods,
      this.bankName,
      this.country,
      this.currency,
      this.defaultForCurrency,
      this.fingerprint,
      this.last4,
      this.routingNumber,
      this.status});

  ConnectBankAccountResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    account = json['account'];
    accountHolderName = json['account_holder_name'];
    accountHolderType = json['account_holder_type'];
    accountType = json['account_type'];
    availablePayoutMethods = json['available_payout_methods'].cast<String>();
    bankName = json['bank_name'];
    country = json['country'];
    currency = json['currency'];
    defaultForCurrency = json['default_for_currency'];
    fingerprint = json['fingerprint'];
    last4 = json['last4'];

    routingNumber = json['routing_number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['account'] = account;
    data['account_holder_name'] = accountHolderName;
    data['account_holder_type'] = accountHolderType;
    data['account_type'] = accountType;
    data['available_payout_methods'] = availablePayoutMethods;
    data['bank_name'] = bankName;
    data['country'] = country;
    data['currency'] = currency;
    data['default_for_currency'] = defaultForCurrency;
    data['fingerprint'] = fingerprint;
    data['last4'] = last4;

    data['routing_number'] = routingNumber;
    data['status'] = status;
    return data;
  }
}
