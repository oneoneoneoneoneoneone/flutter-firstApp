import 'package:flutter/material.dart';

import 'FavoritesPage.dart';
import 'GeneratorPage.dart';

// StatefulWidget - ���°� �ִ� ����(�ٸ� �������� �ش� ������ flag ������ ������ �����ؾ��ϴ� ���?). notifyListeners() ȣ�� ���� ����
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// StatefulWidget���� Convert�ϴ� ���, _@State: State<@> Ŭ������ ���� - State Ȯ��, ��ü �� ����
// Ŭ���� ���� ���� ����(_)�� ����ϴ� ���, �ش� Ŭ������ ������� ����� �����Ϸ��� ���� �����
class _MyHomePageState extends State<MyHomePage> {
  // ������ ����
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // ����� �� �ִ� ������ �翡 ���� ���� Ʈ���� ����
    return LayoutBuilder(
      // builder - ���� ����(â ũ�� ����, ����/���� ��� ����, Ÿ ���� ũ�� ����)�� ����� ������ ȣ���
      // constraints - MyHomePage�� ���������� ���ǵǾ� ����
      builder: (context, constraints) {
        // Scaffold - �ֻ��� ����. build() �޼��尡 ��ȯ�� ���� or ���� Ʈ��
        return Scaffold(
          body: Row(
            children: [
              // SafeArea - ���� ��Ұ� �ϵ���� ��ġ�� ���� ǥ���ٷ� �������� ����
              SafeArea(
                child: NavigationRail(
                  // extended: false - ������ ���� �� ǥ������ ����
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  // onDestinationSelected - NavigationRailDestination�� �������� �� ���� ����
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              // Expanded - ���� ������ ����(NavigationRail)�� �ʿ�� �ϴ� ���� �ܿ� ���� ������ �ִ��� �����ϴ� ���̾ƿ� ǥ��
              Expanded(
                // Container - ?
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
