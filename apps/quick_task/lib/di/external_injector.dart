import 'package:local_storage/local_storage.dart';
import 'package:needle/needle.dart';

Future<void> init(GetIt instance) async {
  UnicodeStorage storage = UnicodeStorage();
  await storage.init();

  instance.registerSingleton<UnicodeStorage>(storage);
}
