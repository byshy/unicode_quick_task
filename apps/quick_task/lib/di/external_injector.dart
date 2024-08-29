import 'package:firebase_cluster/firestore_service.dart';
import 'package:local_storage/local_storage.dart';
import 'package:needle/needle.dart';

Future<void> init(GetIt instance) async {
  UnicodeStorage storage = UnicodeStorage();
  await storage.init();

  instance.registerSingleton<UnicodeStorage>(storage);

  instance.registerSingleton<FireStoreService>(FireStoreService());
}
