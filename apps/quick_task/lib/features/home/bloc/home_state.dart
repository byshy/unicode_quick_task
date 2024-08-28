part of 'home_bloc.dart';

class HomeStateOK {
  static const String baseStatus = 'base_status';
}

class HomeState extends Equatable {
  final BaseStatus baseStatus;

  const HomeState({
    this.baseStatus = BaseStatus.initial,
  });

  factory HomeState.fromJson(Map<String, dynamic> json) => HomeState(
        baseStatus: (json[HomeStateOK.baseStatus] as String).toBaseStatus(),
      );

  Map<String, dynamic> toJson() => {
        HomeStateOK.baseStatus: baseStatus.name,
      };

  HomeState copyWith({
    BaseStatus? baseStatus,
  }) {
    return HomeState(
      baseStatus: baseStatus ?? this.baseStatus,
    );
  }

  @override
  List<Object?> get props => [
        baseStatus,
      ];
}
