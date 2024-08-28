part of 'on_boarding_bloc.dart';

class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object?> get props => [];
}

class GoToNextPage extends OnBoardingEvent {
  final int pagesLength;

  const GoToNextPage({required this.pagesLength});

  @override
  List<Object?> get props => [
        pagesLength,
      ];
}
