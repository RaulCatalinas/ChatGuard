import 'package:chatguard/constants/app_settings.dart' show appName;
import 'package:chatguard/constants/platform.dart' show isDesktop;
import 'package:chatguard/managers/window_manager.dart' show configureWindow;
import 'package:chatguard/router/app_router.dart' show appRouter;
import 'package:flutter/material.dart'
    show
        BuildContext,
        State,
        StatefulWidget,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:flutter_themed/themed_app.dart' show ThemedApp;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;
import 'package:window_close_guard/window_close_guard.dart'
    show WindowCloseGuard;

void main() async {
  try {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: binding);
    LogKeeper.configure(maxLogAgeDays: 7);

    await configureWindow();

    FlutterNativeSplash.remove();
    runApp(const MyApp());
  } catch (e, stackTrace) {
    LogKeeper.critical('Error during app initialization: $e');
    LogKeeper.critical('StackTrace: $stackTrace');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemedApp.router(
      title: appName,
      fontFamily: isDesktop ? 'Inter' : null,
      routerConfig: appRouter,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WindowCloseGuard.initialize(
      context: context,
      onClose: () async {
        await LogKeeper.saveLogs();
      },
    );
  }
}
