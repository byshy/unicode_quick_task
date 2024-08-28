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
    this.imageWidth = 250,
    this.imageHeight = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ClipOval(
            child: FluxImage(
              image: image,
              height: imageHeight,
              width: imageWidth,
            ),
          ),
        ),
        const Spacer(),
        subTitle,
      ],
    );
  }
}
