import 'dart:io';
import 'dart:ui';

import 'package:firebase_cluster/exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picasso/models/config.dart';
import 'package:picasso/models/text_styles.dart';
import 'package:picasso/utils/fonts.dart';
import 'package:picasso/utils/material_color.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/generated/l10n.dart';
import 'package:quick_task/utils/routing/screens.dart';
import 'package:route_navigator/navigation_observer.dart';
import 'package:route_navigator/route_navigator.dart';
import 'package:unicode/enums/workmanager_tasks.dart';
import 'package:unicode/helpers/wm_task_register.dart';
import 'package:unicode/unicode.dart';
import 'core/bloc/core_bloc.dart';
import 'di/injection_container.dart';
import 'package:localization/exports.dart' as l10n;
import 'utils/routing/router.dart' as router;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );

      return true;
    };
  } catch (_) {}

  await initSL();
}

@pragma('vm:entry-point')
void callbackDispatcher() async {
  await setup();

  Workmanager().executeTask((task, inputData) async {
    bool runResult = false;

    if (task == BGTask.syncTODOs.taskName) {
      sl<HomeBloc>().add(const SyncTODOsWithRemote());

      if (Platform.isIOS) {
        Workmanager().registerTask(
          BGTask.syncTODOs.uniqueName,
          BGTask.syncTODOs.taskName,
        );
      }

      runResult = true;
    }

    return Future.value(runResult);
  });
}

Future<void> main() async {
  await setup();

  // TODO: remember to remove all tasks here since they will all be reassigned again
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const QuickTaskApp());
}

final UnicodeNavigatorObserver routeObserver = UnicodeNavigatorObserver();

class QuickTaskApp extends StatelessWidget {
  const QuickTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<CoreBloc>()),
      ],
      child: BlocBuilder<CoreBloc, CoreState>(
        buildWhen: (previous, current) {
          return previous.lang != current.lang;
        },
        builder: (context, state) {
          return MaterialApp(
            title: 'QT',
            debugShowCheckedModeBanner: false,
            navigatorObservers: [routeObserver],
            locale: Locale(state.lang ?? 'en'),
            supportedLocales: QuickTaskL10n.delegate.supportedLocales,
            localizationsDelegates: const [
              QuickTaskL10n.delegate,
              l10n.GlobalMaterialLocalizations.delegate,
              l10n.GlobalWidgetsLocalizations.delegate,
              l10n.GlobalCupertinoLocalizations.delegate,
            ],
            builder: (_, child) {
              Widget processedChild = child!;

              return GestureDetector(
                onTap: () {
                  if (Platform.isIOS) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  }
                },
                child: processedChild,
              );
            },
            theme: ThemeData(
              scaffoldBackgroundColor: sl<Config>().theme!.white,
              primarySwatch: createMaterialColor(sl<Config>().theme!.customerColor),
              primaryColor: sl<Config>().theme!.customerColor,
              colorScheme: ColorScheme.fromSeed(seedColor: sl<Config>().theme!.customerColor),
              fontFamily: Fonts.cairo,
              appBarTheme: AppBarTheme(
                elevation: 0,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                ),
                iconTheme: IconThemeData(
                  color: sl<Config>().theme!.black,
                ),
                titleTextStyle: HeadingStyle.largeTitleNormal,
              ),
            ),
            navigatorKey: sl<RouteNavigator>().navigatorKey,
            initialRoute: Screens.splash,
            onGenerateRoute: router.Router.generateRoute,
          );
        },
      ),
    );
  }
}
