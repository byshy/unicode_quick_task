part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TODOAdded extends HomeEvent {
  final Todo todo;

  const TODOAdded({
    required this.todo,
  });

  @override
  List<Object> get props => [
        todo,
      ];
}

class TODOUpdated extends HomeEvent {
  final Todo todo;

  const TODOUpdated({
    required this.todo,
  });

  @override
  List<Object> get props => [
        todo,
      ];
}
