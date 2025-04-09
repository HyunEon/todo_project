import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart'; // Task 목록 화면

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // 기본 테마 색상 설정
      ),
      home: TaskListScreen(), // Task 목록 화면을 초기 화면으로 설정
      debugShowCheckedModeBanner: false, // 디버그 모드 배너 숨김
    );
  }
}
