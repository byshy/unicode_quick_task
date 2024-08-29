enum Completion {
  initial,
  done;
}

extension SyncX on Completion {
  bool get isNotStarted => this == Completion.initial;

  bool get isDone => this == Completion.done;
}

extension StringX on String {
  Completion toCompletion() {
    switch (this) {
      case 'done':
        return Completion.done;
      case 'initial':
        return Completion.initial;
      default:
        return Completion.done;
    }
  }
}
