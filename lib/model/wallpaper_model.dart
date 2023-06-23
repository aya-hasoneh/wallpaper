import 'dart:convert';

class WallpaperModel {
  int? totalResults;
  int? page;
  int? perPage;
  List<Photos>? photos;
  String? nextPage;

  WallpaperModel(
      {this.totalResults, this.page, this.perPage, this.photos, this.nextPage});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_results'] = this.totalResults;
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this.nextPage;
    return data;
  }
}

class Photos {
  int? id;

  Src? src;

  Photos({
    this.id,
    this.src,
  });

  Photos copyWith({int? id, Src? src}) {
    return Photos(
      id: id ?? this.id,
      src: src ?? this.src,
    );
  }

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    src = json['src'] != null ? Src.fromJson(json['src']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    if (src != null) {
      data['src'] = src!.toJson();
    }
    return data;
  }
}

class Src {
  bool isDownload = false;
  bool isFavorite = false;
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Src(
      {required this.isDownload,
      required this.isFavorite,
      this.original,
      this.large2x,
      this.large,
      this.medium,
      this.small,
      this.portrait,
      this.landscape,
      this.tiny});

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['large2x'] = this.large2x;
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['small'] = this.small;
    data['portrait'] = this.portrait;
    data['landscape'] = this.landscape;
    data['tiny'] = this.tiny;
    return data;
  }
}
