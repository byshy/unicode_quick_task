import '../provider.dart';

class BaseEvent {
  late String _name;
  late Map<String, dynamic>? _params;

  List<MonitoringProvider>? monitoringProvider;

  BaseEvent({
    required String name,
    Map<String, dynamic>? params,
    this.monitoringProvider,
  }) {
    _name = name;
    _params = {
      'timestamp': DateTime.now().toString(),
    };

    params?.forEach((key, value) {
      if (value != null) {
        _params?[key] = value;
      }
    });
  }

  String get eventName => _name;

  Map<String, dynamic>? get eventParams => _params;

  @override
  String toString() {
    return 'name: $_name, params: ${_params.toString()}';
  }
}
