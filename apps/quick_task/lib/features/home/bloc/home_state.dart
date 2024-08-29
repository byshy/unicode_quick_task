part of 'home_bloc.dart';

class HomeStateOK {
  static const String baseStatus = 'base_status';
  static const String syncStatus = 'sync_status';
}

class HomeState extends Equatable {
  final BaseStatus baseStatus;
  final Sync syncStatus;

  const HomeState({
    this.baseStatus = BaseStatus.initial,
    this.syncStatus = Sync.outOfSync,
  });

  factory HomeState.fromJson(Map<String, dynamic> json) => HomeState(
        baseStatus: (json[HomeStateOK.baseStatus] as String).toBaseStatus(),
        syncStatus: (json[HomeStateOK.syncStatus] as String).toSync(),
      );

  Map<String, dynamic> toJson() => {
        HomeStateOK.baseStatus: baseStatus.name,
        HomeStateOK.syncStatus: syncStatus.name,
      };

  HomeState copyWith({
    BaseStatus? baseStatus,
    Sync? syncStatus,
  }) {
    return HomeState(
      baseStatus: baseStatus ?? this.baseStatus,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  List<Object?> get props => [
        baseStatus,
        syncStatus,
      ];
}
