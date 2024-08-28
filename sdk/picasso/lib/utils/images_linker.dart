class ImagesLinker {
  ImagesLinker._internal();

  static final ImagesLinker _images = ImagesLinker._internal();

  static ImagesLinker get instance => _images;

  factory ImagesLinker() {
    return _images;
  }

  String? _basePath;

  String get logo => _assetGetter('app_logo.svg');

  void init(String path) {
    _basePath = path;
  }

  String _assetGetter(String asset) {
    return '$_basePath$asset';
  }
}
