import 'package:monitoring/models/base_event.dart';

abstract class InterfaceMonitoringProvider {
  void sendEvent(BaseEvent event);
  void setUserProperty(Map<String, dynamic> data);
  void setUserId(String identifier);
}
