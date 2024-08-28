part of 'core_bloc.dart';

class CoreStateOK {
  static const String lang = 'lang';
}

class CoreState extends Equatable {
  final String? lang;

  const CoreState({
    this.lang,
  });

  factory CoreState.fromJson(Map<String, dynamic> json) => CoreState(
        lang: json[CoreStateOK.lang],
      );

  Map<String, dynamic> toJson() => {
        CoreStateOK.lang: lang,
      };

  CoreState copyWith({
    String? lang,
  }) {
    return CoreState(
      lang: lang ?? this.lang,
    );
  }

  @override
  List<Object?> get props => [
        lang,
      ];
}
