part of 'core_bloc.dart';

class CoreStateOK {
  static const String lang = 'lang';
  static const String deviceID = 'device_id';
}

class CoreState extends Equatable {
  final String? lang;
  final String? deviceID;

  const CoreState({
    this.lang,
    this.deviceID,
  });

  factory CoreState.fromJson(Map<String, dynamic> json) => CoreState(
        lang: json[CoreStateOK.lang],
        deviceID: json[CoreStateOK.deviceID],
      );

  Map<String, dynamic> toJson() => {
        CoreStateOK.lang: lang,
        CoreStateOK.deviceID: deviceID,
      };

  CoreState copyWith({
    String? lang,
    String? deviceID,
  }) {
    return CoreState(
      lang: lang ?? this.lang,
      deviceID: deviceID ?? this.deviceID,
    );
  }

  @override
  List<Object?> get props => [
        lang,
        deviceID,
      ];
}
