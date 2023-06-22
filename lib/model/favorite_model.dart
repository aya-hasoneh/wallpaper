String favoriteTable = 'favorite';

class FavoriteFields {
  static final List<String> values = [id, imageUrl];
  static String id = '_id';
  static String imageUrl = 'imageUrl';
}

class FavoriteModel {
  final int? id;
  final String? imageUrl;

  FavoriteModel({required this.id, required this.imageUrl});

  FavoriteModel copy({int? id, String? imageUrl}) =>
      FavoriteModel(id: id ?? this.id, imageUrl: imageUrl ?? this.imageUrl);

  static FavoriteModel fromJson(Map<String, Object?> json) => FavoriteModel(
      id: json[FavoriteFields.id] as int?,
      imageUrl: json[FavoriteFields.imageUrl] as String?);
  Map<String, Object?> toJson() =>
      {FavoriteFields.id: id, FavoriteFields.imageUrl: imageUrl};
}
