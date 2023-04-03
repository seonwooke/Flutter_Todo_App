class TodoModel {
  String todo;
  DateTime? createTime;

  TodoModel({
    required this.todo,
    required this.createTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todo': todo,
      'createTime': createTime,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      todo: map['todo'] as String,
      createTime: map['createTime'] as DateTime,
    );
  }

  factory TodoModel.empty() {
    return TodoModel(
      todo: '',
      createTime: null,
    );
  }

  factory TodoModel.create(String todo, DateTime createTime) {
    return TodoModel(
      todo: todo,
      createTime: createTime,
    );
  }
}
