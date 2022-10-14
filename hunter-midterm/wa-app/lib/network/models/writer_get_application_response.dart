class GetScreenWriterApplicationResponse {
  int? currentPage;
  List<Data>? data;
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

  GetScreenWriterApplicationResponse(
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

  GetScreenWriterApplicationResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
    final Map<String, dynamic> data = {};
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

class Data {
  String? id;
  String? applicationableType;
  String? applicationableId;
  String? userId;
  String? approvedAt;
  String? rejectedAt;
  String? createdAt;
  String? updatedAt;
  Applicationable? applicationable;

  Data(
      {this.id,
      this.applicationableType,
      this.applicationableId,
      this.userId,
      this.approvedAt,
      this.rejectedAt,
      this.createdAt,
      this.updatedAt,
      this.applicationable});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationableType = json['applicationable_type'];
    applicationableId = json['applicationable_id'];
    userId = json['user_id'];
    approvedAt = json['approved_at'];
    rejectedAt = json['rejected_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    applicationable = json['applicationable'] != null
        ? Applicationable.fromJson(json['applicationable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['applicationable_type'] = applicationableType;
    data['applicationable_id'] = applicationableId;
    data['user_id'] = userId;
    data['approved_at'] = approvedAt;
    data['rejected_at'] = rejectedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (applicationable != null) {
      data['applicationable'] = applicationable!.toJson();
    }
    return data;
  }
}

class Applicationable {
  String? id;
  String? country;
  String? industryAdmire;
  String? lngTermPlans;
  String? scriptPtn;
  String? aboutUs;
  String? other;
  String? exceptLearn;
  String? awardsAchievements;
  String? interestedIn;
  int? scripted;
  int? considerType;
  int? skillDiscipline;
  int? committed;
  int? ageGroup;
  String? createdAt;
  String? updatedAt;

  Applicationable(
      {this.id,
      this.country,
      this.industryAdmire,
      this.lngTermPlans,
      this.scriptPtn,
      this.aboutUs,
      this.other,
      this.exceptLearn,
      this.awardsAchievements,
      this.interestedIn,
      this.scripted,
      this.considerType,
      this.skillDiscipline,
      this.committed,
      this.ageGroup,
      this.createdAt,
      this.updatedAt});

  Applicationable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    industryAdmire = json['industry_admire'];
    lngTermPlans = json['lng_term_plans'];
    scriptPtn = json['script_ptn'];
    aboutUs = json['about_us'];
    other = json['other'];
    exceptLearn = json['except_learn'];
    awardsAchievements = json['awards_achievements'];
    interestedIn = json['interested_in'];
    scripted = json['scripted'];
    considerType = json['consider_type'];
    skillDiscipline = json['skill_discipline'];
    committed = json['committed'];
    ageGroup = json['age_group'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['country'] = country;
    data['industry_admire'] = industryAdmire;
    data['lng_term_plans'] = lngTermPlans;
    data['script_ptn'] = scriptPtn;
    data['about_us'] = aboutUs;
    data['other'] = other;
    data['except_learn'] = exceptLearn;
    data['awards_achievements'] = awardsAchievements;
    data['interested_in'] = interestedIn;
    data['scripted'] = scripted;
    data['consider_type'] = considerType;
    data['skill_discipline'] = skillDiscipline;
    data['committed'] = committed;
    data['age_group'] = ageGroup;
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
