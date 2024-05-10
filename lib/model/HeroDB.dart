class HeroDB {
  final bool? success;
  final int? status;
  final int? rowCount;
  final String? message;
  final List<HeroDetail>? hero;

  HeroDB({
    this.success,
    this.status,
    this.rowCount,
    this.message,
    this.hero,
  });

  HeroDB.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        status = json['status'] as int?,
        rowCount = json['rowCount'] as int?,
        message = json['message'] as String?,
        hero = (json['hero'] as List?)?.map((dynamic e) => HeroDetail.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'status' : status,
    'rowCount' : rowCount,
    'message' : message,
    'hero' : hero?.map((e) => e.toJson()).toList()
  };
}

class HeroDetail {
  final int? heroId;
  final String? heroName;
  final String? heroAvatar;
  final String? heroRole;
  final String? heroSpecially;

  HeroDetail({
    this.heroId,
    this.heroName,
    this.heroAvatar,
    this.heroRole,
    this.heroSpecially,
  });

  HeroDetail.fromJson(Map<String, dynamic> json)
      : heroId = json['hero_id'] as int?,
        heroName = json['hero_name'] as String?,
        heroAvatar = json['hero_avatar'] as String?,
        heroRole = json['hero_role'] as String?,
        heroSpecially = json['hero_specially'] as String?;

  Map<String, dynamic> toJson() => {
    'hero_id' : heroId,
    'hero_name' : heroName,
    'hero_avatar' : heroAvatar,
    'hero_role' : heroRole,
    'hero_specially' : heroSpecially
  };
}