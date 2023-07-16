import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MyApp ����
void main() {
  runApp(const MyApp());
}

// StatelessWidget - flutter ���� ���� (�� = ����)
// Stateless - ���� ������ ��ü ���¸� �������� ����. MyAppState�� ���ľ� ���� ����
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider: ChangeNotifier - ��������� �ٸ� �׸� �˸� �� ����
    return ChangeNotifierProvider(
      // �� ��ü ���� ����
      create: (context) => MyAppState(),
      child: MaterialApp(
        // �� �̸� ����
        title: 'Namer App',
        // �ð��� �׸� ����
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        //'Ȩ' ����(���� ������) ����
        home: MyHomePage(),
      ),
    );
  }
}

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
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // Scaffold - �ֻ��� ����. build() �޼��尡 ��ȯ�� ���� or ���� Ʈ��
    return Scaffold(
      body: Row(
        children: [
          // SafeArea - ���� ��Ұ� �ϵ���� ��ġ�� ���� ǥ���ٷ� �������� ����
          SafeArea(
            child: NavigationRail(
              // extended: false - ������ ���� �� ǥ������ ����
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
}

class GeneratorPage extends StatelessWidget {
  @override
  // build() - ������ ����� ������ �ڵ� ȣ��Ǵ� �޼���
  Widget build(BuildContext context) {
    // watch() - ���� ������� ����
    var appState = context.watch<MyAppState>();
    //appState.current - appState�� ���� ���(WordPair)�� ������.
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    // Column - �⺻���� ���̾ƿ� ����
    return Center(
      child: Column(
        // �⺻�� ���� Column ���� ��� ����
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          // ������ �����ϰ� ������X
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

// Extract Widget - �����ڵ� �ڵ� ����
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    // ���� �׸��� ��û
    final theme = Theme.of(context);
    // textTheme - �۲� �׸� ����
    // displayMedium - 'display'(��ü) / 'Medium'(ũ��)
    // copyWith - ���ǵ� ��������� ���Ե� �ؽ�Ʈ ��Ÿ���� �纻 ��ȯ (�⺻��Ÿ�� �Ӽ��� ����ϵ�, �Ϻ� ��Ÿ�ϸ� ������ ��)
    final style = theme.textTheme.displayMedium!.copyWith(
      // onPrimary - ���� �⺻ �������� ������ ���� ����
      color: theme.colorScheme.onPrimary,
    );

    // ��� ��� �������� ���
    // Padding - �Ӽ�X ����O (������ �����ϴ� �׸� ���X)
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          // semanticsLabel - TalkBack, VoiceOver���� �����ϴ� �ǹ�? (UI ���� X)
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
