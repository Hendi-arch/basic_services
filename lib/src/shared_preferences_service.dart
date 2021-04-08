import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesService._(await SharedPreferences.getInstance());
    }
    return _instance!;
  }

  final SharedPreferences _preferences;
  SharedPreferencesService._(this._preferences);

  void removeKey(String key) async => await _preferences.remove(key);

  void clearPreferences() async => await _preferences.clear();

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    print('key:$key value:$value');
    return value;
  }

  void saveToDisk(String key, dynamic content) {
    print('key:$key value:$content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
