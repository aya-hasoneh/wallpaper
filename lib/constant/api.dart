abstract class API {
  /// Base URL
  static var base = 'https://api.pexels.com/v1/';

  ///API KEY
  static var apiKey =
      'lHKqad9yYfy7B76f484U5SC1SKWc0sLjDrCdBnj7POaHAn5D7wHl8rh4';

  /// API for get wallpaper images
  static String apiUrlWallpaper() => "${base}curated?per_page=80";

  /// API for search
  static String apiSearch(String query) =>
      "${base}search?query=$query&per_page=1";

}
