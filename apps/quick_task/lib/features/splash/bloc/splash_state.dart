part of 'splash_bloc.dart';

class SplashStateOK {
  static const String status = 'status';
}

class SplashState extends Equatable {
  final BaseStatus status;

  const SplashState({
    this.status = BaseStatus.initial,
  });

  factory SplashState.fromJson(Map<String, dynamic> json) => SplashState(
        status: (json[SplashStateOK.status] as String).toBaseStatus(),
      );

  Map<String, dynamic> toJson() => {
        SplashStateOK.status: status.name,
      };

  SplashState copyWith({
    BaseStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
