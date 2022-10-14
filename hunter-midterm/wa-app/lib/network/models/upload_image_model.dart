class UploadImageModel {
  String? avatarUrl;

  UploadImageModel({this.avatarUrl});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
