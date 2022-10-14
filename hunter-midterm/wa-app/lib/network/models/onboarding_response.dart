class OnBoardingResponse {
  String? object;
  int? created;
  int? expiresAt;
  String? url;

  OnBoardingResponse({this.object, this.created, this.expiresAt, this.url});

  OnBoardingResponse.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    created = json['created'];
    expiresAt = json['expires_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['created'] = created;
    data['expires_at'] = expiresAt;
    data['url'] = url;
    return data;
  }
}
