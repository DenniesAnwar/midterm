class MyOrdersResponse {
  int? currentPage;
  List<MyOrdersDataModel>? data;
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

  MyOrdersResponse(
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

  MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MyOrdersDataModel>[];
      json['data'].forEach((v) {
        data!.add(MyOrdersDataModel.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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

class MyOrdersDataModel {
  String? id;
  String? scriptId;
  String? userId;
  String? checkout;
  String? period;
  int? checkoutAmount;
  String? checkoutUrl;
  String? checkoutUntil;
  String? checkoutCompleted;
  String? checkoutCanceled;
  String? createdAt;
  String? updatedAt;
  Script? script;

  MyOrdersDataModel(
      {this.id,
        this.scriptId,
        this.userId,
        this.checkout,
        this.period,
        this.checkoutAmount,
        this.checkoutUrl,
        this.checkoutUntil,
        this.checkoutCompleted,
        this.checkoutCanceled,
        this.createdAt,
        this.updatedAt,
        this.script});

  MyOrdersDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scriptId = json['script_id'];
    userId = json['user_id'];
    checkout = json['checkout'];
    period = json['period'];
    checkoutAmount = json['checkout_amount'];
    checkoutUrl = json['checkout_url'];
    checkoutUntil = json['checkout_until'];
    checkoutCompleted = json['checkout_completed'];
    checkoutCanceled = json['checkout_canceled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    script =
    json['script'] != null ? Script.fromJson(json['script']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['script_id'] = scriptId;
    data['user_id'] = userId;
    data['checkout'] = checkout;
    data['period'] = period;
    data['checkout_amount'] = checkoutAmount;
    data['checkout_url'] = checkoutUrl;
    data['checkout_until'] = checkoutUntil;
    data['checkout_completed'] = checkoutCompleted;
    data['checkout_canceled'] = checkoutCanceled;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (script != null) {
      data['script'] = script!.toJson();
    }
    return data;
  }
}

class Script {
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

  Script(
      {this.id,
        this.title,
        this.synopsis,
        this.logline,
        this.tagline,
        this.pages,
        this.where,
        this.similarStories,
        this.optionedUntil,
        this.publishedAt,
        this.userId,
        this.applicationType,
        this.applicationId,
        this.budgetId,
        this.timelineId,
        this.categoryId,
        this.contentRatingId,
        this.createdAt,
        this.updatedAt});

  Script.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    synopsis = json['synopsis'];
    logline = json['logline'];
    tagline = json['tagline'];
    pages = json['pages'];
    where = json['where'];
    similarStories = json['similar_stories'];
    optionedUntil = json['optioned_until'];
    publishedAt = json['published_at'];
    userId = json['user_id'];
    applicationType = json['application_type'];
    applicationId = json['application_id'];
    budgetId = json['budget_id'];
    timelineId = json['timeline_id'];
    categoryId = json['category_id'];
    contentRatingId = json['content_rating_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['synopsis'] = synopsis;
    data['logline'] = logline;
    data['tagline'] = tagline;
    data['pages'] = pages;
    data['where'] = where;
    data['similar_stories'] = similarStories;
    data['optioned_until'] = optionedUntil;
    data['published_at'] = publishedAt;
    data['user_id'] = userId;
    data['application_type'] = applicationType;
    data['application_id'] = applicationId;
    data['budget_id'] = budgetId;
    data['timeline_id'] = timelineId;
    data['category_id'] = categoryId;
    data['content_rating_id'] = contentRatingId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
