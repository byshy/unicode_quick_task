part of 'home_bloc.dart';

class HomeStateOK {
  static const String baseStatus = 'base_status';
  static const String syncStatus = 'sync_status';
  static const String todosList = 'todos_list';
}

class HomeState extends Equatable {
  final BaseStatus baseStatus;
  final Sync syncStatus;
  final List<Todo> todosList;

  const HomeState({
    this.baseStatus = BaseStatus.initial,
    this.syncStatus = Sync.outOfSync,
    this.todosList = const [],
  });

  factory HomeState.fromJson(Map<String, dynamic> json) => HomeState(
        baseStatus: (json[HomeStateOK.baseStatus] as String).toBaseStatus(),
        syncStatus: (json[HomeStateOK.syncStatus] as String).toSync(),
        todosList: (json[HomeStateOK.todosList] as List<Map<String, dynamic>>).map((e) => Todo.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        HomeStateOK.baseStatus: baseStatus.name,
        HomeStateOK.syncStatus: syncStatus.name,
        HomeStateOK.todosList: todosList.map((e) => e.toJson()),
      };

  HomeState copyWith({
    BaseStatus? baseStatus,
    Sync? syncStatus,
    List<Todo>? todosList,
  }) {
    return HomeState(
      baseStatus: baseStatus ?? this.baseStatus,
      syncStatus: syncStatus ?? this.syncStatus,
      todosList: todosList ?? this.todosList,
    );
  }

  @override
  List<Object?> get props => [
        baseStatus,
        syncStatus,
        todosList,
      ];
}
