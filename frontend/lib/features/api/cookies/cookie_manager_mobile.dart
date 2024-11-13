import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'cookie_manager.dart';

class CookieManagerMobile extends CookieManager {
  final _storage = FlutterSecureStorage();

  @override
  Future<String?> loadCookies(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> saveCookies(String name, String value, {int days = 0}) async {
    final rawCookie = '$name=$value';
    final parts = rawCookie.split(';')[0].split('=');
    if (parts.length == 2) {
      await _storage.write(key: parts[0], value: parts[1]);
    }
  }

  @override
  Future<void> deleteCookie(String name) {
    // TODO: implement deleteCookie
    throw UnimplementedError();
  }
}
