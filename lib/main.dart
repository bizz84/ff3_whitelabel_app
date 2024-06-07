import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

final m3Schemes = [
  FlexScheme.redM3,
  FlexScheme.pinkM3,
  FlexScheme.purpleM3,
  FlexScheme.indigoM3,
  FlexScheme.blueM3,
  FlexScheme.cyanM3,
  FlexScheme.tealM3,
  FlexScheme.greenM3,
  FlexScheme.limeM3,
  FlexScheme.yellowM3,
  FlexScheme.orangeM3,
  FlexScheme.deepOrangeM3,
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // preload the package info
  final packageInfo = await PackageInfo.fromPlatform();
  runApp(MainApp(packageInfo: packageInfo));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.packageInfo});
  final PackageInfo packageInfo;

  FlexScheme getScheme() => switch (appFlavor) {
        'blue' => FlexScheme.blueM3,
        'cyan' => FlexScheme.cyanM3,
        'deeporange' => FlexScheme.deepOrangeM3,
        'green' => FlexScheme.greenM3,
        // TODO: Add all the remaining flavors
        // * Fallback options
        null => FlexScheme.material,
        _ => throw UnsupportedError('$appFlavor is not recognized as a flavor'),
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(scheme: getScheme()),
      home: appFlavor == null
          ? const InvalidFlavorScreen()
          : HomeScreen(packageInfo: packageInfo),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.packageInfo});
  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    const flavoredAppIcon = 'assets/$appFlavor/icon.png';
    final flavoredAppName = packageInfo.appName;
    return Scaffold(
      appBar: AppBar(title: Text('$flavoredAppName App')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Text(
            'Flavored app icon:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(flavoredAppIcon, height: 120),
            ),
          ),
        ],
      ),
    );
  }
}

class InvalidFlavorScreen extends StatelessWidget {
  const InvalidFlavorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Whitelabel App')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'The app flavor is missing. Please run the app with:',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                'flutter run --flavor',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
