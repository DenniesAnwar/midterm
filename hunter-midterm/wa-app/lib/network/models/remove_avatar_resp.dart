class RemoveAvatarResp {
  late bool status;

  RemoveAvatarResp({required this.status});

  RemoveAvatarResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
