import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    // ���Ҵ�
    current = WordPair.random();
    // MyAppState �����ڿ��� �˸�
    notifyListeners();
  }

  // [] - List, {} - Set
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}