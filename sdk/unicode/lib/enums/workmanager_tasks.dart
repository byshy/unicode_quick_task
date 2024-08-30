enum BGTask {
  syncTODOs(
    'com.unicode.bg_sync_todos',
    'BGSyncTODOs',
  );

  const BGTask(this.uniqueName, this.taskName);

  final String taskName;
  final String uniqueName;
}
