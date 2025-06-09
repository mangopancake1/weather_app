import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _keyUsername = 'logged_in_username';
  static const _keyProfileImagePath = 'profile_image_path';

  static Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  static Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
  }

  static Future<void> saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    final username = await getSession();
    if (username != null) {
      await prefs.setString('profile_image_$username', path);
    }
  }

  static Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final username = await getSession();
    if (username != null) {
      return prefs.getString('profile_image_$username');
    }
    return null;
  }

  static Future<String?> getLoggedInUsername() async {
    return await getSession();
  }
}
