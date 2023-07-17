import 'package:flutter/material.dart';

import 'FavoritesPage.dart';
import 'GeneratorPage.dart';

// StatefulWidget - 상태가 있는 위젯(다른 위젯에서 해당 위젯의 flag 역할의 변수를 참조해야하는 경우?). notifyListeners() 호출 없이 동작
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// StatefulWidget으로 Convert하는 경우, _@State: State<@> 클래스를 생성 - State 확장, 자체 값 관리
// 클래스 명에서 시작 밑줄(_)을 사용하는 경우, 해당 클래스를 비공개로 만들며 컴파일러에 의해 시행됨
class _MyHomePageState extends State<MyHomePage> {
  // 추적할 변수
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

    // 사용할 수 있는 공간의 양에 따라 위젯 트리를 변경
    return LayoutBuilder(
      // builder - 제약 조건(창 크기 변경, 가로/세로 모드 변경, 타 위젯 크기 변경)이 변경될 때마다 호출됨
      // constraints - MyHomePage의 제약조건이 정의되어 있음
      builder: (context, constraints) {
        // Scaffold - 최상위 위젯. build() 메서드가 반환할 위젯 or 위젯 트리
        return Scaffold(
          body: Row(
            children: [
              // SafeArea - 하위 요소가 하드웨어 노치나 상태 표시줄로 가려지지 않음
              SafeArea(
                child: NavigationRail(
                  // extended: false - 아이콘 옆에 라벨 표시하지 않음
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
                  // onDestinationSelected - NavigationRailDestination을 선택했을 때 동작 정의
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              // Expanded - 같은 계층의 위젯(NavigationRail)이 필요로 하는 공간 외에 남은 공간을 최대한 차지하는 레이아웃 표현
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
