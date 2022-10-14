class ScriptDetailModel {
  String? id;
  String? title;
  String? synopsis;
  String? logline;
  String? tagline;
  int? pages;
  int? budget;
  int? timeline;
  String? where;
  String? userId;
  String? optionedUntil;
  String? publishedAt;
  String? applicationType;
  String? applicationId;
  int? categoryId;
  int? contentRatingId;
  String? createdAt;
  String? updatedAt;
  Author? author;
  List<Genres>? genres;
  Category? category;
  ContentRating? contentRating;
  List<ScriptRatings>? scriptRatings;
  String? application;

  ScriptDetailModel(
      {this.id,
        this.title,
        this.synopsis,
        this.logline,
        this.tagline,
        this.pages,
        this.budget,
        this.timeline,
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
        this.author,
        this.genres,
        this.category,
        this.contentRating,
        this.scriptRatings,
        this.application});

  ScriptDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    synopsis = json['synopsis'];
    logline = json['logline'];
    tagline = json['tagline'];
    pages = json['pages'];
    budget = json['budget'];
    timeline = json['timeline'];
    where = json['where'];
    userId = json['user_id'];
    optionedUntil = json['optioned_until'];
    publishedAt = json['published_at'];
    applicationType = json['application_type'];
    applicationId = json['application_id'];
    categoryId = json['category_id'];
    contentRatingId = json['content_rating_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    contentRating = json['content_rating'] != null
        ? ContentRating.fromJson(json['content_rating'])
        : null;
    if (json['script_ratings'] != null) {
      scriptRatings = <ScriptRatings>[];
      json['script_ratings'].forEach((v) {
        scriptRatings!.add(ScriptRatings.fromJson(v));
      });
    }
    application = json['application'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['synopsis'] = synopsis;
    data['logline'] = logline;
    data['tagline'] = tagline;
    data['pages'] = pages;
    data['budget'] = budget;
    data['timeline'] = timeline;
    data['where'] = where;
    data['user_id'] = userId;
    data['optioned_until'] = optionedUntil;
    data['published_at'] = publishedAt;
    data['application_type'] = applicationType;
    data['application_id'] = applicationId;
    data['category_id'] = categoryId;
    data['content_rating_id'] = contentRatingId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (contentRating != null) {
      data['content_rating'] = contentRating!.toJson();
    }
    if (scriptRatings != null) {
      data['script_ratings'] =
          scriptRatings!.map((v) => v.toJson()).toList();
    }
    data['application'] = application;
    return data;
  }
}

class Author {
  String? id;
  String? name;
  String? uid;
  String? email;
  String? phone;
  String? avatar;
  bool? active;
  bool? verified;
  String? accountType;
  String? createdAt;
  String? updatedAt;
  String? stripeId;
  String? pmType;
  String? pmLastFour;
  String? trialEndsAt;

  Author(
      {this.id,
        this.name,
        this.uid,
        this.email,
        this.phone,
        this.avatar,
        this.active,
        this.verified,
        this.accountType,
        this.createdAt,
        this.updatedAt,
        this.stripeId,
        this.pmType,
        this.pmLastFour,
        this.trialEndsAt});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uid = json['uid'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    active = json['active'];
    verified = json['verified'];
    accountType = json['account_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uid'] = uid;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['active'] = active;
    data['verified'] = verified;
    data['account_type'] = accountType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['stripe_id'] = stripeId;
    data['pm_type'] = pmType;
    data['pm_last_four'] = pmLastFour;
    data['trial_ends_at'] = trialEndsAt;
    return data;
  }
}

class Genres {
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Genres(
      {this.id,
        this.name,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? scriptId;
  int? genreId;

  Pivot({this.scriptId, this.genreId});

  Pivot.fromJson(Map<String, dynamic> json) {
    scriptId = json['script_id'];
    genreId = json['genre_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['script_id'] = scriptId;
    data['genre_id'] = genreId;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.name, this.slug, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ContentRating {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  ContentRating({this.id, this.name, this.createdAt, this.updatedAt});

  ContentRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ScriptRatings {
  int? id;
  int? character;
  int? conflict;
  int? dialogue;
  int? logic;
  int? originality;
  int? pacing;
  int? premise;
  int? structure;
  int? tone;
  String? feedback;
  int? scriptId;
  String? createdAt;
  String? updatedAt;

  ScriptRatings(
      {this.id,
        this.character,
        this.conflict,
        this.dialogue,
        this.logic,
        this.originality,
        this.pacing,
        this.premise,
        this.structure,
        this.tone,
        this.feedback,
        this.scriptId,
        this.createdAt,
        this.updatedAt});

  ScriptRatings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    character = json['character'];
    conflict = json['conflict'];
    dialogue = json['dialogue'];
    logic = json['logic'];
    originality = json['originality'];
    pacing = json['pacing'];
    premise = json['premise'];
    structure = json['structure'];
    tone = json['tone'];
    feedback = json['feedback'];
    scriptId = json['script_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['character'] = character;
    data['conflict'] = conflict;
    data['dialogue'] = dialogue;
    data['logic'] = logic;
    data['originality'] = originality;
    data['pacing'] = pacing;
    data['premise'] = premise;
    data['structure'] = structure;
    data['tone'] = tone;
    data['feedback'] = feedback;
    data['script_id'] = scriptId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

