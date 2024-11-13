import 'dart:html' as html;
import 'package:flutter/material.dart';

import 'cookie_manager.dart';

class CookieManagerWeb extends CookieManager {
  @override
  Future<String?> loadCookies(String name) async {
    debugPrint('Loading cookie function $name');
    final allCookies = html.document.cookie?.split('; ') ?? [];
    for (final cookie in allCookies) {
      debugPrint('Loading cookie: $cookie');
      final parts = cookie.split('=');
      if (parts[0] == name) {
        return parts.sublist(1).join('=');
      }
    }
    return null;
  }

  @override
  Future<void> saveCookies(String name, String value, {int days = 7}) async {
    debugPrint('Saving cookie $name with value $value');
    final expires =
        DateTime.now().add(Duration(days: days)).toUtc().toIso8601String();
    final rawCookie = '$name=$value; expires=$expires; path=/';
    html.document.cookie = rawCookie;
  }

  @override
  Future<void> deleteCookie(String name) {
    // TODO: implement deleteCookie
    throw UnimplementedError();
  }
}
