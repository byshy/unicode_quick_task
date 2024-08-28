enum BaseStatus {
  initial,
  loading,
  success,
  failure,
}

extension StringX on String {
  BaseStatus toBaseStatus() {
    switch (this) {
      case 'initial':
        return BaseStatus.initial;
      case 'loading':
        return BaseStatus.loading;
      case 'success':
        return BaseStatus.success;
      case 'failure':
        return BaseStatus.failure;
      default:
        return BaseStatus.initial;
    }
  }
}

extension BaseStatusX on BaseStatus {
  bool get isInitial => this == BaseStatus.initial;

  bool get isLoading => this == BaseStatus.loading;

  bool get isSuccess => this == BaseStatus.success;

  bool get isFailure => this == BaseStatus.failure;
}
