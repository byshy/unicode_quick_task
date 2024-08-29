import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String? description;

  const Todo({
    required this.title,
    required this.description,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['title'] = title;
    data['description'] = description;

    return data;
  }

  @override
  List<Object?> get props => [];
}
