part of 'home_bloc.dart';

class HomeStateOK {
  static const String baseStatus = 'base_status';
  static const String syncStatus = 'sync_status';
  static const String todosList = 'todos_list';
  static const String firstRenderDone = 'first_render_done';
}

class HomeState extends Equatable {
  final BaseStatus baseStatus;
  final Sync syncStatus;
  final List<Todo> todosList;
  final bool firstRenderDone;

  const HomeState({
    this.baseStatus = BaseStatus.initial,
    this.syncStatus = Sync.outOfSync,
    this.todosList = const [],
    this.firstRenderDone = false,
  });

  factory HomeState.fromJson(Map<String, dynamic> json) => HomeState(
        baseStatus: (json[HomeStateOK.baseStatus] as String).toBaseStatus(),
        syncStatus: (json[HomeStateOK.syncStatus] as String).toSync(),
        todosList: (json[HomeStateOK.todosList] as List<Map<String, dynamic>>).map((e) => Todo.fromJson(e)).toList(),
        firstRenderDone: json[HomeStateOK.firstRenderDone],
      );

  Map<String, dynamic> toJson() => {
        HomeStateOK.baseStatus: baseStatus.name,
        HomeStateOK.syncStatus: syncStatus.name,
        HomeStateOK.todosList: todosList.map((e) => e.toJson()),
        HomeStateOK.firstRenderDone: firstRenderDone,
      };

  HomeState copyWith({
    BaseStatus? baseStatus,
    Sync? syncStatus,
    List<Todo>? todosList,
    bool? firstRenderDone,
  }) {
    return HomeState(
      baseStatus: baseStatus ?? this.baseStatus,
      syncStatus: syncStatus ?? this.syncStatus,
      todosList: todosList ?? this.todosList,
      firstRenderDone: firstRenderDone ?? this.firstRenderDone,
    );
  }

  @override
  List<Object?> get props => [
        baseStatus,
        syncStatus,
        todosList,
        firstRenderDone,
      ];
}
