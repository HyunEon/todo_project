import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/services/api_services.dart';
import 'package:todo_app/screens/task_list_screen.dart';

class TaskCreateScreen extends StatefulWidget {
  @override
  _TaskCreateScreenState createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final ApiService _apiService = ApiService();
  DateTime date = DateTime.now();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  @override
  void dispose() {
    titlecontroller.dispose();
    descriptioncontroller.dispose();
    datecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 생성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '제목',
                )),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            SizedBox(
              height: 200,
              child: TextField(
                  controller: descriptioncontroller,
                  textAlignVertical: TextAlignVertical(y: -1),
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '설명',
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            TextField(
              controller: datecontroller,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                );

                if (selectedDate != null) {
                  // 날짜 선택 완료 후 시간 선택
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(date), // 현재 시간 기본값
                  );

                  if (selectedTime != null) {
                    setState(() {
                      // DateTime 객체를 날짜와 시간 조합으로 업데이트
                      date = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      // DateTime 객체를 컨트롤러 텍스트에 저장
                      datecontroller.text =
                          DateFormat("yyyy-MM-dd EEE HH:mm").format(date);
                    });
                  } else {
                    // 시간 선택 취소 시
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('시간 선택이 취소되었습니다.')),
                    );
                  }
                } else {
                  // 날짜 선택 취소 시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('날짜 선택이 취소되었습니다.')),
                  );
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '기간 설정',
                icon: Icon(Icons.calendar_month),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  child: Text("생성"),
                  onPressed: () async {
                    if (titlecontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('제목을 입력해주세요.')),
                      );
                      return;
                    } else if (descriptioncontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('설명을 입력해주세요.')),
                      );
                      return;
                    } else if (datecontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('목표 시간을 입력해주세요.')),
                      );
                      return;
                    }

                    // Task 생성 요청 (await로 결과를 기다림)
                    try {
                      await _apiService.createTask(
                        titlecontroller.text,
                        descriptioncontroller.text,
                        date.toString(),
                      );

                      // 성공 시 화면을 닫고 메시지를 표시

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskListScreen(), // Task 데이터 전달
                          ),
                          (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task가 생성되었습니다!')),
                      );
                    } catch (e) {
                      // 에러 발생 시 처리
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task 생성 중 오류가 발생했습니다: $e')),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
