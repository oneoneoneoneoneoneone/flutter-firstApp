import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MyAppState.dart';

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
