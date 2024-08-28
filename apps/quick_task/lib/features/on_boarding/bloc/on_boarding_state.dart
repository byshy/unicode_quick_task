part of 'on_boarding_bloc.dart';

class OnBoardingStateOK {
  static const String status = 'status';
}

class OnBoardingState extends Equatable {
  final BaseStatus status;

  const OnBoardingState({
    this.status = BaseStatus.initial,
  });

  factory OnBoardingState.fromJson(Map<String, dynamic> json) => OnBoardingState(
        status: (json[OnBoardingStateOK.status] as String).toBaseStatus(),
      );

  Map<String, dynamic> toJson() => {
        OnBoardingStateOK.status: status.name,
      };

  OnBoardingState copyWith({
    BaseStatus? status,
  }) {
    return OnBoardingState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
