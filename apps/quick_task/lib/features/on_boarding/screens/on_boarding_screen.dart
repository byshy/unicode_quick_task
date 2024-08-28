import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picasso/models/config.dart';
import 'package:picasso/models/text_styles.dart';
import 'package:picasso/utils/gradients.dart';
import 'package:picasso/widgets/common/loading_indicator.dart';
import 'package:unicode/models/on_boarding_model.dart';

import '../../../di/injection_container.dart';
import '../bloc/on_boarding_bloc.dart';
import '../consts/on_boarding_content.dart';
import '../widgets/on_boarding_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {
  static const double nextButtonSize = 50.0;
  static const double nextRingSize = nextButtonSize + 10.0;

  @override
  void initState() {
    super.initState();

    sl<OnBoardingBloc>().onBoardingTabsController = TabController(
      length: onBoardingData.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            minimum: const EdgeInsets.only(bottom: 78, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TabBarView(
                    controller: sl<OnBoardingBloc>().onBoardingTabsController,
                    children: List.generate(
                      onBoardingData.length,
                      (index) {
                        OnBoardingModel model = onBoardingData[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                          child: OnBoardingItem(
                            image: model.image,
                            title: Text(
                              model.title,
                              style: HeadingStyle.largeTitleBold,
                            ),
                            subTitle: Text(
                              model.subTitle,
                              textAlign: TextAlign.center,
                              style: HeadingStyle.titleNormal.copyWith(color: sl<Config>().theme!.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: nextRingSize,
                      height: nextRingSize,
                      child: AnimatedBuilder(
                        animation: sl<OnBoardingBloc>().onBoardingTabsController.animation!,
                        builder: (BuildContext context, Widget? child) {
                          return LoadingIndicator(
                            color: sl<Config>().theme!.accentColor,
                            stroke: 3,
                            value: (sl<OnBoardingBloc>().onBoardingTabsController.animation!.value + 1) / onBoardingData.length,
                          );
                        },
                      ),
                    ),
                    Container(
                      height: nextButtonSize,
                      width: nextButtonSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: Gradients.customer,
                        ),
                      ),
                      child: IconButton(
                        key: const ValueKey('on_boarding_next_button'),
                        onPressed: () => sl<OnBoardingBloc>().add(GoToNextPage(
                          pagesLength: onBoardingData.length,
                        )),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: sl<Config>().theme!.white,
                        ),
                        iconSize: 17,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
