import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyAppState.dart';
import 'Page/MyHomePage.dart';

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