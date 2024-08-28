import 'provider.dart';

abstract class InterfaceTracking {
  List<MonitoringProvider> getProviders();
  List<MonitoringProvider> getDefaultProviders();
  Map<String, dynamic> getConfig();
}
