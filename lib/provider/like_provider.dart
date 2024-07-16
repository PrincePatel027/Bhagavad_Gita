import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LikeProvider extends ChangeNotifier {
  List likedList = [];

  LikeProvider() {
    loadLikedList();
  }

  toggleLike({required Map e}) async {
    if (likedList.contains(e)) {
      likedList.remove(e);
    } else {
      likedList.add(e);
    }
    notifyListeners();
    await saveLikedList();
  }

  bool isLiked(Map e) {
    return likedList.contains(e);
  }

  Future<void> saveLikedList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList =
        likedList.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('likedList', stringList);
  }

  Future<void> loadLikedList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('likedList');
    if (stringList != null) {
      likedList = stringList.map((item) => jsonDecode(item) as Map).toList();
      notifyListeners();
    }
  }
}
