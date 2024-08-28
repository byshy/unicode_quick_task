enum Lang {
  ar('ar'),
  en('en');

  const Lang(this.value);

  final String value;
}

extension StringX on String {
  Lang toLang() {
    switch (this) {
      case 'ar':
        return Lang.ar;
      case 'en':
        return Lang.en;
      default:
        return Lang.en;
    }
  }
}

extension LangBX on Lang {
  bool get isAr => this == Lang.ar;

  bool get isEn => this == Lang.en;
}
