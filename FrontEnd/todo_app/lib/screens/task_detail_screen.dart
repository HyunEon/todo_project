import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map task; // 전달받은 Task 데이터

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task['title']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text(
              '${task['description']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              '${task['is_completed'] ? '완료됨: ' + DateFormat("yyyy-MM-dd EEE HH:mm").format(DateTime.parse(task['updateat'])) : '진행중'}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 16),
            Text('기한: ' +
                DateFormat("yyyy-MM-dd EEE HH:mm")
                    .format(DateTime.parse(task['duedate']))),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
