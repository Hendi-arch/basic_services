import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences _prefs;

  Future initialiseSharedPrefsService() async => _prefs = await SharedPreferences.getInstance();

  void removeKey(String key) => _prefs.remove(key);

  void clearPreferences() => _prefs.clear();

  dynamic getFromDisk(String key) {
    var value = _prefs.get(key);
    return value;
  }

  void saveToDisk(String key, dynamic content) {
    if (content is String) {
      _prefs.setString(key, content);
    }
    if (content is bool) {
      _prefs.setBool(key, content);
    }
    if (content is int) {
      _prefs.setInt(key, content);
    }
    if (content is double) {
      _prefs.setDouble(key, content);
    }
    if (content is List<String>) {
      _prefs.setStringList(key, content);
    }
  }
}
