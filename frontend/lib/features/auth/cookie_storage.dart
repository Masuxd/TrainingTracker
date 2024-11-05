import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CookieStorage {
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> parseAndStoreCookies(String rawCookie) async {
    // Split the raw cookie string into individual cookies
    List<String> cookies = rawCookie.split(';');
    for (String cookie in cookies) {
      List<String> cookieParts = cookie.split('=');
      if (cookieParts.length == 2) {
        String key = cookieParts[0].trim();
        String value = cookieParts[1].trim();
        await secureStorage.write(key: key, value: value);
      }
    }
  }

  static Future<Map<String, String>> loadCookies() async {
    return await secureStorage.readAll();
  }

  static Future<void> deleteCookie(String key) async {
    await secureStorage.delete(key: key);
  }
}