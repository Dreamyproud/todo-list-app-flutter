class Todo {
  String text;
  bool completed;
  DateTime time;

  Todo({required this.text, required DateTime time, this.completed = false})
      : time = time;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        text: json['text'],
        completed: json['completed'],
        time: DateTime.parse(json['time']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'completed': completed,
        'time': time.toString(),
      };

  @override
  String toString() {
    return 'text: $text, completed: $completed, time: $time';
  }

  void toggleCompleted() {
    completed = !completed;
  }

  void toggleUpdate(String newText) {
    text = newText;
  }

  bool operator ==(o) =>
      o is Todo &&
      o.text == this.text &&
      o.completed == this.completed &&
      o.time == this.time;

  @override
  int get hashCode => text.hashCode ^ time.hashCode ^ time.toString().hashCode;
}
