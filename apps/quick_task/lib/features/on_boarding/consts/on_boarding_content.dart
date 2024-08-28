import 'package:picasso/models/config.dart';
import 'package:picasso/utils/images_linker.dart';
import 'package:unicode/models/on_boarding_model.dart';

import '../../../di/injection_container.dart';
import '../../../generated/l10n.dart';

final List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    title: QuickTaskL10n.current.on_boarding_1,
    subTitle: QuickTaskL10n.current.on_boarding_1_subtitle,
    // image: ImagesLinker.instance.onBoarding1,
  ),
  OnBoardingModel(
    title: QuickTaskL10n.current.on_boarding_2,
    subTitle: QuickTaskL10n.current.on_boarding_2_subtitle,
    // image: ImagesLinker.instance.onBoarding2,
  ),
  OnBoardingModel(
    title: QuickTaskL10n.current.on_boarding_3,
    subTitle: QuickTaskL10n.current.on_boarding_3_subtitle,
    // image: ImagesLinker.instance.onBoarding3,
  ),
  if (sl<Config>().domain!.isPro) OnBoardingModel(
    title: QuickTaskL10n.current.on_boarding_4,
    subTitle: QuickTaskL10n.current.on_boarding_4_subtitle,
    // image: ImagesLinker.instance.onBoarding4,
  ),
];
