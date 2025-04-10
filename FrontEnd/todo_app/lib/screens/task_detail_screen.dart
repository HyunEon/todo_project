import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map task; // 전달받은 Task 데이터
  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details'), actions: [
        IconButton(
          icon: Icon(Icons.more_vert), // 자세히 보기 느낌
          onPressed: () {
            // 눌렀을 때 동작 (예: 팝업 띄우기)
          },
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // 카드 형태로 업데이트
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                        Icons.description, '설명', task['description']),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      task['is_completed']
                          ? Icons.check_circle
                          : Icons.access_time,
                      '상태',
                      task['is_completed']
                          ? '완료됨 (${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(task['updated_at']))})'
                          : '진행중',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                        Icons.calendar_today,
                        '기한',
                        DateFormat("yyyy-MM-dd HH:mm")
                            .format(DateTime.parse(task['duedate']))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
