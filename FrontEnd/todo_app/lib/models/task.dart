class Task {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime duedate;
  final DateTime createdat;
  final DateTime updatedat;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted,
      required this.duedate,
      required this.createdat,
      required this.updatedat});

  // JSON 데이터를 객체로 변환
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
      duedate: json['duedate'],
      createdat: json['created_at'],
      updatedat: json['updated_at'],
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'duedate': duedate,
      'created_at': createdat,
      'updated_at': updatedat,
    };
  }
}
