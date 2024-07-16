import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'Light';

  ThemeProvider() {
    loadData();
  }

  changeTheme({required String theme}) async {
    currentTheme = theme;
    notifyListeners();
    await saveData();
  }

  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("THEME", currentTheme);
    notifyListeners();
  }

  loadData() async {
    final prefs = await SharedPreferences.getInstance();

    String? curntTheme = prefs.getString("THEME");

    if (curntTheme != null) {
      currentTheme = curntTheme;
      notifyListeners();
    }
  }
}
