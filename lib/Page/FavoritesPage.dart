import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MyAppState.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Center(
      child: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text('You have ''${appState.favorites.length} favorites:'),
            ),
          // ... - 배열안에 단일 요소와 List 사이에 추가
          ...
          appState.favorites.map((pair) => 
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(pair.asLowerCase)
            )
          )
        ]  
      ),
    );
  }
}
