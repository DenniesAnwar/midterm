class SellerRequirements {
  List<dynamic>? alternatives;
  String? currentDeadline;
  List<String>? currentlyDue;
  String? disabledReason;
  List<dynamic>? errors;
  List<String>? eventuallyDue;
  List<String>? pastDue;
  List<dynamic>? pendingVerification;

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
      alternatives =[];
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
      pendingVerification = <Null>[];
      json['pending_verification'].forEach((v) {
        pendingVerification!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (alternatives != null) {
      data['alternatives'] = alternatives!.map((v) => v.toJson()).toList();
    }
    data['current_deadline'] = currentDeadline;
    data['currently_due'] = currentlyDue;
    data['disabled_reason'] = disabledReason;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['eventually_due'] = eventuallyDue;
    data['past_due'] = pastDue;
    if (pendingVerification != null) {
      data['pending_verification'] =
          pendingVerification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
