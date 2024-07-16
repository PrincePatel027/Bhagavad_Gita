import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String language = "English";

  LanguageProvider() {
    loadData();
  }

  Future<void> changeLanguage({required String lnga}) async {
    language = lnga;
    notifyListeners();
    await saveData();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('LANGUAGE', language);
    notifyListeners();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? lng = prefs.getString("LANGUAGE");
    if (lng != null) {
      language = lng;
      notifyListeners();
    }
  }
}
