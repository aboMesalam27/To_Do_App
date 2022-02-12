import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;




  Task(
      {this.id,
        this.title,
        this.note,
        this.isCompleted,
        this.date,
        this.startTime,
        this.endTime,
        this.color,
        this.remind,
        this.repeat});


  Task.name(this.id, this.title, this.note, this.isCompleted, this.date,
      this.startTime, this.endTime, this.color, this.remind, this.repeat);

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'note': this.note,
      'isCompleted': this.isCompleted,
      'date': this.date,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'color': this.color,
      'remind': this.remind,
      'repeat': this.repeat,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    title= json['title'] ;
    note=json['note'] ;
    isCompleted= json['isCompleted'];
    date= json['date'] ;
    startTime= json['startTime'] ;
    endTime= json['endTime'] ;
    color= json['color'] ;
    remind= json['remind'];
    repeat= json['repeat'] ;
  }


}
