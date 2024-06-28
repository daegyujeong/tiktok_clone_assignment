import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone_assignment/features/settings/models/setting_model.dart';

class SettingRepository {
  static const String _darkmode = "darkmode";

  final SharedPreferences _preferences;

  SettingRepository(this._preferences);

  Future<void> setDarkMode(DarkMode mode) async {
    await _preferences.setInt(_darkmode, mode.index);
  }

  DarkMode getDarkMode() {
    final index = _preferences.getInt(_darkmode) ?? DarkMode.system.index;
    return DarkMode.values[index];
  }
}
