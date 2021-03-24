import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferencesService {
  final _prefs = FlutterSecureStorage();

  void removeKey(String key) async => await _prefs.delete(key: key);

  void clearPreferences() async => await _prefs.deleteAll();

  dynamic getFromDisk(String key) async {
    var value = await _prefs.read(key: key);
    return value as dynamic;
  }

  void saveToDisk(String key, dynamic content) => _prefs.write(key: key, value: content);
}
