class WriterFormResponse {
  int? currentPage;
  int? perPage;
  String? prevPageUrl;
  int? total;
  List<Data>? data;

  WriterFormResponse(
      {currentPage,
        perPage,
        prevPageUrl,
        total,
        data});

  WriterFormResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['total'] = total;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? applicationableType;
  String? applicationableId;
  String? approvedAt;
  String? rejectedAt;
  String? createdAt;
  String? updatedAt;
  Applicationable? applicationable;

  Data(
      {id,
        userId,
        applicationableType,
        applicationableId,
        approvedAt,
        rejectedAt,
        createdAt,
        updatedAt,
        applicationable});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    applicationableType = json['applicationable_type'];
    applicationableId = json['applicationable_id'];
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
    data['user_id'] = userId;
    data['applicationable_type'] = applicationableType;
    data['applicationable_id'] = applicationableId;
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
  String? type;
  String? desc;
  String? country;
  String? more;
  int? ageGroup;
  int? committed;
  String? industryAdmire;
  String? lngTermPlans;
  int? considerType;
  String? scriptPtn;
  String? aboutUs;
  int? skillDiscipline;
  String? exceptLearn;
  String? awardsAchievements;
  String? interestedIn;
  int? scripted;
  String? createdAt;
  String? updatedAt;

  Applicationable(
      {id,
        type,
        desc,
        country,
        more,
        ageGroup,
        committed,
        industryAdmire,
        lngTermPlans,
        considerType,
        scriptPtn,
        aboutUs,
        skillDiscipline,
        exceptLearn,
        awardsAchievements,
        interestedIn,
        scripted,
        createdAt,
        updatedAt});

  Applicationable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    desc = json['desc'];
    country = json['country'];
    more = json['more'];
    ageGroup = json['age_group'];
    committed = json['committed'];
    industryAdmire = json['industry_admire'];
    lngTermPlans = json['lng_term_plans'];
    considerType = json['consider_type'];
    scriptPtn = json['script_ptn'];
    aboutUs = json['about_us'];
    skillDiscipline = json['skill_discipline'];
    exceptLearn = json['except_learn'];
    awardsAchievements = json['awards_achievements'];
    interestedIn = json['interested_in'];
    scripted = json['scripted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['desc'] = desc;
    data['country'] = country;
    data['more'] = more;
    data['age_group'] = ageGroup;
    data['committed'] = committed;
    data['industry_admire'] = industryAdmire;
    data['lng_term_plans'] = lngTermPlans;
    data['consider_type'] = considerType;
    data['script_ptn'] = scriptPtn;
    data['about_us'] = aboutUs;
    data['skill_discipline'] = skillDiscipline;
    data['except_learn'] = exceptLearn;
    data['awards_achievements'] = awardsAchievements;
    data['interested_in'] = interestedIn;
    data['scripted'] = scripted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
