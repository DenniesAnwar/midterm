class ProducerFormResponse {
  String? id;
  String? userId;
  String? applicationableType;
  String? applicationableId;
  String? approvedAt;
  String? rejectedAt;
  String? createdAt;
  String? updatedAt;

  ProducerFormResponse(
      {this.id,
      this.userId,
      this.applicationableType,
      this.applicationableId,
      this.approvedAt,
      this.rejectedAt,
      this.createdAt,
      this.updatedAt});

  ProducerFormResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    applicationableType = json['applicationable_type'];
    applicationableId = json['applicationable_id'];
    approvedAt = json['approved_at'];
    rejectedAt = json['rejected_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['applicationable_type'] = applicationableType;
    data['applicationable_id'] = applicationableId;
    data['approved_at'] = approvedAt;
    data['rejected_at'] = rejectedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
