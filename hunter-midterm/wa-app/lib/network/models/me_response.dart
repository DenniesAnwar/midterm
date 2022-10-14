class MeResponse {
  String? id;
  String? name;
  String? firstName;
  String? lastName;
  String? uid;
  String? avatarUrl;
  String? email;
  String? phone;
  bool? active;
  bool? verified;
  String? country;
  String? accountType;
  String? createdAt;
  String? updatedAt;
  String? stripeId;
  String? pmType;
  String? pmLastFour;
  String? trialEndsAt;
  Subscription? subscription;
  SellerRequirements? sellerRequirements;

  MeResponse(
      {this.id,
      this.firstName,
      this.lastName,
      this.uid,
      this.email,
      this.avatarUrl,
      this.phone,
      this.active,
      this.verified,
      this.accountType,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.pmType,
      this.pmLastFour,
      this.trialEndsAt,
      this.subscription});

  MeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    firstName = json['first_name'];
    lastName = json['last_name'];
    name = "$firstName $lastName";
    uid = json['uid'];
    avatarUrl = json['avatar_url'];
    email = json['email'];
    phone = json['phone'];
    active = json['active'];
    country = json['country'];
    verified = json['verified'];
    accountType = json['account_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;

    sellerRequirements = json['seller_requirements'] != null
        ? SellerRequirements.fromJson(json['seller_requirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['uid'] = uid;
    data['avatar_url'] = avatarUrl;
    data['email'] = email;
    data['phone'] = phone;
    data['country'] = country;
    data['active'] = active;
    data['verified'] = verified;
    data['account_type'] = accountType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['stripe_id'] = stripeId;
    data['pm_type'] = pmType;
    data['pm_last_four'] = pmLastFour;
    data['trial_ends_at'] = trialEndsAt;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }

    return data;
  }
}

class Subscription {
  int? id;
  String? userId;
  String? name;
  String? stripeId;
  String? stripeStatus;
  String? stripePrice;
  int? quantity;
  String? trialEndsAt;
  String? endsAt;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Subscription(
      {this.id,
      this.userId,
      this.name,
      this.stripeId,
      this.stripeStatus,
      this.stripePrice,
      this.quantity,
      this.trialEndsAt,
      this.endsAt,
      this.createdAt,
      this.updatedAt,
      this.items});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    stripeId = json['stripe_id'];
    stripeStatus = json['stripe_status'];
    stripePrice = json['stripe_price'];
    quantity = json['quantity'];
    trialEndsAt = json['trial_ends_at'];
    endsAt = json['ends_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['stripe_id'] = stripeId;
    data['stripe_status'] = stripeStatus;
    data['stripe_price'] = stripePrice;
    data['quantity'] = quantity;
    data['trial_ends_at'] = trialEndsAt;
    data['ends_at'] = endsAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Items {
  int? id;
  int? subscriptionId;
  String? stripeId;
  String? stripeProduct;
  String? stripePrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
      this.subscriptionId,
      this.stripeId,
      this.stripeProduct,
      this.stripePrice,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionId = json['subscription_id'];
    stripeId = json['stripe_id'];
    stripeProduct = json['stripe_product'];
    stripePrice = json['stripe_price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['subscription_id'] = subscriptionId;
    data['stripe_id'] = stripeId;
    data['stripe_product'] = stripeProduct;
    data['stripe_price'] = stripePrice;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SellerRequirements {
  List<String>? alternatives;
  dynamic currentDeadline;
  List<String>? currentlyDue;
  String? disabledReason;
  List<dynamic>? errors;
  List<String>? eventuallyDue;
  List<String>? pastDue;
  List<String>? pendingVerification;

  SellerRequirements(
      {this.alternatives,
      this.currentDeadline,
      this.currentlyDue,
      this.disabledReason,
      this.errors,
      this.eventuallyDue,
      this.pastDue,
      this.pendingVerification});

  SellerRequirements.fromJson(Map<String, dynamic> json) {
    if (json['alternatives'] != null) {
      alternatives = [];
      json['alternatives'].forEach((v) {
        alternatives!.add(v);
      });
    }
    currentDeadline = json['current_deadline'];
    currentlyDue = json['currently_due'].cast<String>();
    disabledReason = json['disabled_reason'];
    if (json['errors'] != null) {
      errors = <Null>[];
      json['errors'].forEach((v) {
        errors!.add(v);
      });
    }
    eventuallyDue = json['eventually_due'].cast<String>();
    pastDue = json['past_due'].cast<String>();
    if (json['pending_verification'] != null) {
      pendingVerification = [];
      json['pending_verification'].forEach((v) {
        pendingVerification!.add(v);
      });
    }
  }
}
