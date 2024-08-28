import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FluxImage extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;

  const FluxImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image?.isEmpty ?? true) {
      return errorImage();
    }

    bool isSvgImage = image!.split('.').last == 'svg';
    bool isLocalAsset = !image!.contains('http');

    if (isLocalAsset) {
      return FutureBuilder(
        future: rootBundle.load(image!),
        builder: (_, snapshot) {
          String assetPath = image!;

          if (snapshot.hasError) {
            List<String> directories = image!.split('/');
            String file = directories.removeLast();
            assetPath = '${(directories..removeLast()).join('/')}/$file';

            return buildLocalImage(
              isSvgImage: isSvgImage,
              assetPath: assetPath,
            );
          } else if (snapshot.hasData) {
            return buildLocalImage(
              isSvgImage: isSvgImage,
              assetPath: image!,
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    if (isSvgImage) {
      return SvgPicture.network(
        image!,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    }

    return ExtendedImage.network(
      image!,
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadStateChanged: (state) {
        try {
          switch (state.extendedImageLoadState) {
            case LoadState.completed:
              return state.completedWidget;
            case LoadState.loading:
            case LoadState.failed:
              return errorImage();
            default:
              return const SizedBox();
          }
        } catch (e) {
          return errorImage();
        }
      },
    );
  }

  Widget buildLocalImage({required bool isSvgImage, required String assetPath}) {
    if (isSvgImage) {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        package: package,
      );
    }

    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      color: color,
      package: package,
    );
  }

  //TODO: fix path, ImageLinker not work
  Widget errorImage() {
    return buildLocalImage(
      isSvgImage: true,
      assetPath: 'assets/images/empty_data_image.svg',
    );
  }
}
