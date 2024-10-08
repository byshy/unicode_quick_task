import 'package:flutter/material.dart';
import 'package:picasso/utils/images_linker.dart';
import 'package:picasso/widgets/common/flux_image.dart';
import 'package:quick_task/features/splash/bloc/splash_bloc.dart';

import '../../../di/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    sl<SplashBloc>().add(const SplashScreenMounted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FluxImage(
              image: ImagesLinker.instance.logo,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
