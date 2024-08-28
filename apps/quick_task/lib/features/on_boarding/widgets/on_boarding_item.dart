import 'package:flutter/material.dart';
import 'package:picasso/widgets/common/flux_image.dart';

class OnBoardingItem extends StatelessWidget {
  final String? image;
  final Text title;
  final Text subTitle;
  final double imageWidth;
  final double imageHeight;

  const OnBoardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageWidth = 360,
    this.imageHeight = 360,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: FluxImage(
              image: image,
              height: imageHeight,
              width: imageWidth,
            ),
          ),
        ),
        subTitle,
      ],
    );
  }
}
