import 'package:firebase_cluster/exports.dart';
import 'package:monitoring/models/base_event.dart';

import '../interface_monitoring_provider.dart';

class FirebaseAnalyticsProvider implements InterfaceMonitoringProvider {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get analytics {
    return _analytics;
  }

  @override
  void sendEvent(BaseEvent event) {
    _analytics.logEvent(name: event.eventName, parameters: event.eventParams);
  }

  @override
  void setUserId(String identifier) {
    _analytics.setUserId(id: identifier);
  }

  @override
  void setUserProperty(Map<String, dynamic> data) {
    data.forEach((key, value) {
      _analytics.setUserProperty(name: key, value: value);
    });
  }
}
