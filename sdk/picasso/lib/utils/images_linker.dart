class ImagesLinker {
  ImagesLinker._internal();

  static final ImagesLinker _images = ImagesLinker._internal();

  static ImagesLinker get instance => _images;

  factory ImagesLinker() {
    return _images;
  }

  String? _basePath;

  String get logo => _assetGetter('app_logo.svg');
  String get onBoarding1 => _assetGetter('on_boarding_1.png');
  String get onBoarding2 => _assetGetter('on_boarding_2.png');
  String get onBoarding3 => _assetGetter('on_boarding_3.png');
  String get onBoarding4 => _assetGetter('on_boarding_4.png');

  void init(String path) {
    _basePath = path;
  }

  String _assetGetter(String asset) {
    return '$_basePath$asset';
  }
}
