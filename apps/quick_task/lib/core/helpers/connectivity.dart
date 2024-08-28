import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityEXT on ConnectivityResult {
  bool isConnected() {
    return this != ConnectivityResult.bluetooth && this != ConnectivityResult.none;
  }
}
