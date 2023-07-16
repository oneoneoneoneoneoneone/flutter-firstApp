import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MyApp 실행
void main() {
  runApp(const MyApp());
}

// StatelessWidget - flutter 앱을 빌드 (앱 = 위젯)
// Stateless - 변경 가능한 자체 상태를 포함하지 않음. MyAppState를 거쳐야 변경 가능
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider: ChangeNotifier - 변경사항을 다른 항목에 알릴 수 있음
    return ChangeNotifierProvider(
      // 앱 전체 상태 생성
      create: (context) => MyAppState(),
      child: MaterialApp(
        // 앱 이름 지정
        title: 'Namer App',
        // 시각적 테마 정의
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        //'홈' 위젯(앱의 시작점) 설정
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    // 재할당
    current = WordPair.random();
    // MyAppState 관찰자에게 알림
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
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // Scaffold - 최상위 위젯. build() 메서드가 반환할 위젯 or 위젯 트리
    return Scaffold(
      body: Row(
        children: [
          // SafeArea - 하위 요소가 하드웨어 노치나 상태 표시줄로 가려지지 않음
          SafeArea(
            child: NavigationRail(
              // extended: false - 아이콘 옆에 라벨 표시하지 않음
              extended: false,
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
}

class GeneratorPage extends StatelessWidget {
  @override
  // build() - 위젯이 변경될 때마다 자동 호출되는 메서드
  Widget build(BuildContext context) {
    // watch() - 상태 변경사항 추적
    var appState = context.watch<MyAppState>();
    //appState.current - appState의 유일 멤버(WordPair)에 엑세스.
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    // Column - 기본적인 레이아웃 위젯
    return Center(
      child: Column(
        // 기본축 기준 Column 하위 요소 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          // 공간만 차지하고 렌더링X
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like')),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Extract Widget - 위젯코드 자동 생성
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    // 현재 테마를 요청
    final theme = Theme.of(context);
    // textTheme - 글꼴 테마 지정
    // displayMedium - 'display'(서체) / 'Medium'(크기)
    // copyWith - 정의된 변경사항이 포함된 텍스트 스타일의 사본 반환 (기본스타일 속성을 사용하되, 일부 스타일만 변경할 때)
    final style = theme.textTheme.displayMedium!.copyWith(
      // onPrimary - 앱의 기본 색상으로 적합한 색상 정의
      color: theme.colorScheme.onPrimary,
    );

    // 상속 대신 컴포지션 사용
    // Padding - 속성X 위젯O (위젯은 래핑하는 항목에 상관X)
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          // semanticsLabel - TalkBack, VoiceOver에서 인지하는 의미? (UI 영향 X)
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
