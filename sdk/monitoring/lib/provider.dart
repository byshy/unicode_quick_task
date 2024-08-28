import 'package:firebase_cluster/exports.dart';
import 'package:flutter/material.dart';

import 'interface_monitoring_provider.dart';
import 'providers/firebase_analytics_provider.dart';

enum MonitoringProvider {
  firebase,
}

extension MonitoringProviderInit on MonitoringProvider {
  Future<InterfaceMonitoringProvider?> init({required Map<String, dynamic> config}) async {
    switch (this) {
      case MonitoringProvider.firebase:
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        return FirebaseAnalyticsProvider();
    }
  }
}
