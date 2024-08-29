import 'package:quick_task/generated/l10n.dart';

enum Sync {
  synced,
  outOfSync;
}

extension SyncX on Sync {
  String title () {
    switch (this) {
      case Sync.synced:
        return QuickTaskL10n.current.synced;
      case Sync.outOfSync:
        return QuickTaskL10n.current.sync;
      default:
        return QuickTaskL10n.current.synced;
    }
  }

  bool get isSynced => this == Sync.synced;

  bool get isOutOfSync => this == Sync.outOfSync;
}

extension StringX on String {
  Sync toSync() {
    switch (this) {
      case 'sync':
        return Sync.outOfSync;
      case 'synced':
        return Sync.synced;
      default:
        return Sync.outOfSync;
    }
  }
}
