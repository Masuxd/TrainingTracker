import 'package:universal_platform/universal_platform.dart';
import 'cookie_manager_mobile.dart';
import 'cookie_manager_web.dart';

abstract class CookieManager {
  Future<void> saveCookies(String name, String value, {int days});
  Future<String?> loadCookies(String name);
  Future<void> deleteCookie(String name);

  static final CookieManager instance =
      UniversalPlatform.isWeb ? CookieManagerWeb() : CookieManagerMobile();
}
