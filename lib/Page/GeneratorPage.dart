import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MyAppState.dart';

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
