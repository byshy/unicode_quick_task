import 'package:equatable/equatable.dart';
import 'package:quick_task/core/enums/completion.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String? description;
  final Completion completion;

  const Todo({
    required this.id,
    required this.title,
    this.description,
    this.completion = Completion.initial,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    completion: (json['completion'] as String).toCompletion(),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['completion'] = completion.name;

    return data;
  }

  Todo copyWith({
    String? title,
    String? description,
    Completion? completion,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      completion: completion ?? this.completion,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    completion,
  ];

  bool get hasDescription => description?.isNotEmpty ?? false;
}
