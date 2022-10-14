class ScriptResponse {
  int? currentPage;
  List<DataModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ScriptResponse(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ScriptResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class DataModel {
  String? id;
  String? title;
  String? synopsis;
  String? logline;
  String? tagline;
  int? pages;
  String? where;
  String? similarStories;
  String? optionedUntil;
  String? publishedAt;
  String? userId;
  String? applicationType;
  String? applicationId;
  int? budgetId;
  int? timelineId;
  int? categoryId;
  int? contentRatingId;
  String? createdAt;
  String? updatedAt;
  Application? application;
  String? willExpireIn;
  bool? isExpired;

  DataModel(
      {this.id,
      this.title,
      this.synopsis,
      this.logline,
      this.tagline,
      this.pages,
      this.budgetId,
      this.timelineId,
      this.where,
      this.userId,
      this.optionedUntil,
      this.publishedAt,
      this.applicationType,
      this.applicationId,
      this.categoryId,
      this.contentRatingId,
      this.createdAt,
      this.updatedAt,
      this.application,
      this.willExpireIn,
      this.isExpired});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    synopsis = json['synopsis'];
    logline = json['logline'];
    tagline = json['tagline'];
    pages = json['pages'];
    budgetId = json['budget_id'];
    timelineId = json['timeline_id'];
    where = json['where'];
    userId = json['user_id'];
    optionedUntil = json['optioned_until'];
    similarStories = json['similar_stories'];
    publishedAt = json['published_at'];
    applicationType = json['application_type'];
    applicationId = json['application_id'];
    categoryId = json['category_id'];
    contentRatingId = json['content_rating_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    application = json['application'] != null
        ? Application.fromJson(json['application'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['synopsis'] = synopsis;
    data['logline'] = logline;
    data['tagline'] = tagline;
    data['pages'] = pages;
    data['budget_id'] = budgetId;
    data['timeline_id'] = timelineId;
    data['where'] = where;
    data['similar_stories'] = similarStories;
    data['user_id'] = userId;
    data['optioned_until'] = optionedUntil;
    data['published_at'] = publishedAt;
    data['application_type'] = applicationType;
    data['application_id'] = applicationId;
    data['category_id'] = categoryId;
    data['content_rating_id'] = contentRatingId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (application != null) {
      data['application'] = application!.toJson();
    }
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class Application {
  String? id;
  String? acceptedAt;
  String? rejectedAt;
  String? createdAt;
  String? updatedAt;

  Application(
      {this.id,
      this.acceptedAt,
      this.rejectedAt,
      this.createdAt,
      this.updatedAt});

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptedAt = json['accepted_at'];
    rejectedAt = json['rejected_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accepted_at'] = acceptedAt;
    data['rejected_at'] = rejectedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
