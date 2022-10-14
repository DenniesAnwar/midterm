class CreateBankAccount {
  String? object;
  String? country;
  String? currency;
  String? accountNumber;
  String? accountHolderName;
  String? accountHolderType;
  String? routingNumber;

  CreateBankAccount(
      {this.object,
      this.country,
      this.currency,
      this.accountNumber,
      this.accountHolderName,
      this.accountHolderType,
      this.routingNumber});

  CreateBankAccount.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    country = json['country'];
    currency = json['currency'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    accountHolderType = json['account_holder_type'];
    routingNumber = json['routing_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['country'] = country;
    data['currency'] = currency;
    data['account_number'] = accountNumber;
    data['account_holder_name'] = accountHolderName;
    data['account_holder_type'] = accountHolderType;
    data['routing_number'] = routingNumber;
    return data;
  }
}
