import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CookieStorage extends PersistCookieJar {
  final FlutterSecureStorage secureStorage;

  CookieStorage({required this.secureStorage});

  @override
  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
    final key = _getKey(uri);
    final value = _encodeCookies(cookies);
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<List<Cookie>> loadForRequest(Uri uri) async {
    final key = _getKey(uri);
    final value = await secureStorage.read(key: key);
    return _decodeCookies(value);
  }

  String _getKey(Uri uri) {
    return uri.host;
  }

  String _encodeCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }

  List<Cookie> _decodeCookies(String? value) {
    if (value == null) return [];
    return value.split('; ').map((cookie) {
      final parts = cookie.split('=');
      return Cookie(parts[0], parts[1]);
    }).toList();
  }
}
