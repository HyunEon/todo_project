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
                  trailing: Text(task['is_completed'] ? '완료됨' : '진행중'),
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
}
