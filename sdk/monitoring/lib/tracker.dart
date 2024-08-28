library monitoring;

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:monitoring/interface_tracking.dart';

import 'interface_monitoring_provider.dart';
import 'provider.dart';
import 'models/base_event.dart';

class Tracker {
  static final Tracker _tracker = Tracker._internal();

  Tracker._internal();

  static final Map<MonitoringProvider, InterfaceMonitoringProvider> _providers = {};

  factory Tracker(InterfaceTracking tracking) {
    for (MonitoringProvider provider in tracking.getProviders()) {
      provider.init(config: tracking.getConfig()).then((value) {
        if (value != null) {
          _providers[provider] = value;
        }
      });
    }

    return _tracker;
  }

  void track(BaseEvent event) {
    final List<MonitoringProvider> providers = (event.monitoringProvider ?? _providers.keys).toList();
    if (providers.isNotEmpty) {
      for (var value in _providers.values) {
        if (kReleaseMode) {
          value.sendEvent(event);
        } else {
          log(
            event.eventParams.toString(),
            name: event.eventName,
          );
        }
      }
    }
  }

  void setUserId(String identifier) {
    for (var provider in _providers.values) {
      provider.setUserId(identifier);
    }
  }

  void setUserProperty(Map<String, dynamic> data) {
    for (var provider in _providers.values) {
      provider.setUserProperty(data);
    }
  }
}
