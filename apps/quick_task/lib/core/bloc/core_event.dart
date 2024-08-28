part of 'core_bloc.dart';

class CoreEvent extends Equatable {
  const CoreEvent();

  @override
  List<Object?> get props => [];
}

class CoreLanguageChanged extends CoreEvent {
  final String language;

  const CoreLanguageChanged({
    required this.language,
  });

  @override
  List<Object?> get props => [
        language,
      ];
}
