import 'dart:io' show Platform;

import 'package:chatguard/constants/app_settings.dart'
    show appName, centerWindow, maximizeWindow, resizeWindow, windowSize;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;
import 'package:window_manager/window_manager.dart'
    show WindowOptions, windowManager;

Future<void> configureWindow() async {
  try {
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) {
      LogKeeper.info(
        'User is on mobile platform, skipping window configuration.',
      );

      return;
    }

    LogKeeper.info('Configuring window...');

    await windowManager.ensureInitialized();

    const WindowOptions windowOptions = WindowOptions(
      title: appName,
      size: windowSize,
      center: centerWindow,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setResizable(resizeWindow);
      await windowManager.setMaximizable(maximizeWindow);
      await windowManager.show();
      await windowManager.focus();
    });

    LogKeeper.info('Window configured successfully.');
  } catch (e, stackTrace) {
    LogKeeper.error('Error initializing window manager: $e');
    LogKeeper.error('StackTrace: $stackTrace');

    return;
  }
}
