import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/services/api_services.dart';
import 'package:todo_app/screens/task_detail_screen.dart';
import 'package:todo_app/screens/task_create_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _apiService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskCreateScreen(),
            ),
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.edit),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List>(
        // 비동기 작업 리스트
        future: _tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('목록 없음'));
          } else {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(DateFormat("yyyy-MM-dd EEE HH:mm")
                      .format(DateTime.parse(task['duedate']))),
                  trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _showRadioPopup(context, task).then((updated) {
                          if (updated == true) {
                            setState(() {
                              _tasks = _apiService.fetchTasks(); // 본문 새로고침
                            });
                          }
                        });
                      }),
                  //trailing: Text(task['is_completed'] ? '완료됨' : '진행중'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TaskDetailScreen(task: task), // Task 데이터 전달
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  // 완료 여부 수정 팝업
  _showRadioPopup(BuildContext context, task) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        String _selectedValue = task['is_completed'] ? '완료됨' : '진행중'; // 초기 선택 값

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('상태 변경'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    value: '진행중',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                    title: const Text('진행중'),
                  ),
                  RadioListTile<String>(
                    value: '완료됨',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                    title: const Text('완료됨'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // 팝업 닫기
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    final isCompleted = (_selectedValue == '완료됨');
                    final updateat = DateTime.now()
                        .toIso8601String(); // Django에서 Iso860 형식으로만 받아서 변환해줘야 함..
                    try {
                      await _apiService.updateTask(
                        task['id'],
                        task['title'],
                        task['description'],
                        isCompleted,
                        task['duedate'],
                        updateat,
                      );
                      Navigator.pop(context, true); // 팝업 닫기
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
