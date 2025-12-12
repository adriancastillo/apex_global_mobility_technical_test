class Todo {
  const Todo({required this.id, required this.title, required this.completed});

  final int id;
  final String title;
  final bool completed;

  Todo copyWith({int? id, String? title, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
