import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HiveWrapper {
  static const defaultBoxName = 'unicode_default_box';

  /// Opens a box. Convenience pass through to [Hive.openBox].
  ///
  /// If the box is already open, the instance is returned and all provided parameters are being ignored.
  static Future<Box<Map<dynamic, dynamic>?>> openBox(String boxName, {String? path}) async {
    return await Hive.openBox<Map<dynamic, dynamic>?>(boxName, path: path);
  }

  /// Convenience factory for `UnicodeHiveStorage(await openBox(boxName ?? 'Name of Box', path: path))`
  ///
  /// [boxName]  defaults to [defaultBoxName], [path] is optional.
  /// For full configuration of a [Box] use [UnicodeHiveStorage()] in tandem with [openBox] / [Hive.openBox]
  static Future<HiveWrapper> open({
    String boxName = defaultBoxName,
    String? path,
  }) async =>
      HiveWrapper(await openBox(boxName, path: path));

  /// Init Hive on specific Path
  static void init({required String onPath}) => Hive.init(onPath);

  /// Direct access to the underlying [Box].
  ///
  /// **WARNING**: Directly editing the contents of the store will not automatically
  /// rebroadcast operations.
  final Box<Map<dynamic, dynamic>?> box;

  /// Creates a UnicodeHiveStorage initialized with the given [box], defaulting to `Hive.box(defaultBoxName)`
  ///
  /// **N.B.**: [box] must already be [opened] with either [openBox], [open], or `initHiveUnicode``.
  ///
  /// [opened]: https://docs.hivedb.dev/#/README?id=open-a-box
  HiveWrapper([Box<Map<dynamic, dynamic>?>? box]) : box = box ?? Hive.box<Map<dynamic, dynamic>?>(defaultBoxName);
  Map<String, dynamic>? get(String dataId) {
    final result = box.get(dataId);
    if (result == null) return null;
    return _transformMap(result);
  }

  void put(String dataId, Map<String, dynamic>? value) {
    box.put(dataId, value);
  }

  void putAll(Map<String, Map<String, dynamic>?> data) {
    box.putAll(data);
  }

  void delete(String dataId) {
    box.delete(dataId);
  }

  Map<String, Map<String, dynamic>?> toMap() => Map.unmodifiable(box.toMap());
  Future<void> reset() => box.clear();
}

Map<String, dynamic> _transformMap(Map<dynamic, dynamic> map) => Map<String, dynamic>.from(
      {
        for (var entry in map.entries) entry.key: _transformAny(entry.value),
      },
    );

dynamic _transformAny(dynamic object) {
  if (object is Map) {
    return _transformMap(object);
  }
  if (object is List) {
    return _transformList(object);
  }
  return object;
}

List<dynamic> _transformList(List<dynamic> list) => List<dynamic>.from(
      [
        for (var element in list) _transformAny(element),
      ],
    );

Future<void> initHiveUnicode({String? subDir, Iterable<String> boxes = const [HiveWrapper.defaultBoxName]}) async {
  WidgetsFlutterBinding.ensureInitialized();

  var appDir = await getApplicationDocumentsDirectory();
  var path = appDir.path;
  if (subDir != null) {
    path = join(path, subDir);
  }
  HiveWrapper.init(onPath: path);

  final futures = boxes.map((String name) => HiveWrapper.open(boxName: name));
  await Future.wait(futures);
}
