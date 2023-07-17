import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyAppState.dart';
import 'Page/MyHomePage.dart';

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