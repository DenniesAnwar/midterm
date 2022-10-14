class CountryModel {
  late String countryCode;
  late String countryName;

  CountryModel({required this.countryCode, required this.countryName});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryName = json['name'];
    countryCode = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = countryCode;
    data['name'] = countryName;
    return data;
  }
}
