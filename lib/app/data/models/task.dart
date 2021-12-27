class Task {
  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;
  int? remind;
  int? color;
  int? isComplete;

  Task(
      {this.id,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.repeat,
      this.remind,
      this.color,
      this.isComplete});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    repeat = json['repeat'];
    remind = json['remind'];
    color = json['color'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
      'remind': remind,
      'color': color,
      'isComplete': isComplete,
    };
  }
}
