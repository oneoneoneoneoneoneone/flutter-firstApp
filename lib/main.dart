import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyAppState.dart';
import 'Page/MyHomePage.dart';

// MyApp ����
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ���ε�

  await Firebase.initializeApp();
  FirebaseMessaging fbMsg = FirebaseMessaging.instance;
  String? fcmToken = await fbMsg.getToken();
  print(fcmToken);

  runApp(const MyApp());

  // �÷��� Ȯ���� ���ѿ�û �� Flutter Local Notification Plugin ����
  if (Platform.isIOS) {
    await reqIOSPermission(fbMsg);
  }
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

Future reqIOSPermission(FirebaseMessaging fbMsg) async {
  NotificationSettings settings = await fbMsg.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}