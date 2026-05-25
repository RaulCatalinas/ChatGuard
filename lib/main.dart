import 'package:chatguard/constants/app_settings.dart' show appName;
import 'package:chatguard/managers/window_manager.dart' show configureWindow;
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Center,
        Column,
        FloatingActionButton,
        Icon,
        Icons,
        Scaffold,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        Theme,
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThemedApp(title: appName, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
