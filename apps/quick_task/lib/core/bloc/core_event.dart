part of 'core_bloc.dart';

class CoreEvent extends Equatable {
  const CoreEvent();

  @override
  List<Object?> get props => [];
}

class CoreLanguageInitialized extends CoreEvent {
  const CoreLanguageInitialized();
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

class DeviceIDFetched extends CoreEvent {
  const DeviceIDFetched();
}
