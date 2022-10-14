class ScResponseModel {
  late String id;
  late String userId;
  late String title;
  late String synopsis;
  late String logline;
  late String tagline;
  late int pages;
  late int budget;
  late int timeline;
  late String where;
  late int contentRatingId;
  late int categoryId;
  late String createdAt;
  late String? updatedAt;

  ScResponseModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.synopsis,
      required this.logline,
      required this.tagline,
      required this.pages,
      required this.budget,
      required this.timeline,
      required this.where,
      required this.contentRatingId,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});

  ScResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    synopsis = json['synopsis'];
    logline = json['logline'];
    tagline = json['tagline'];
    pages = json['pages'];
    budget = json['budget'];
    timeline = json['timeline'];
    where = json['where'];
    contentRatingId = json['content_rating_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['synopsis'] = synopsis;
    data['logline'] = logline;
    data['tagline'] = tagline;
    data['pages'] = pages;
    data['budget'] = budget;
    data['timeline'] = timeline;
    data['where'] = where;
    data['content_rating_id'] = contentRatingId;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
