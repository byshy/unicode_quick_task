import 'package:monitoring/interface_tracking.dart';
import 'package:monitoring/provider.dart';

class TrackersImplementation with InterfaceTracking {
  @override
  Map<String, dynamic> getConfig() {
    return {};
  }

  @override
  List<MonitoringProvider> getProviders() {
    return [
      MonitoringProvider.firebase,
    ];
  }

  @override
  List<MonitoringProvider> getDefaultProviders() {
    return [
      MonitoringProvider.firebase,
    ];
  }
}
