import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

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

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  FlexScheme _flexScheme = m3Schemes.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(scheme: _flexScheme),
      home: FlexSchemeSelectorScreen(
        flexScheme: _flexScheme,
        onChanged: (scheme) => setState(() => _flexScheme = scheme),
      ),
    );
  }
}

class FlexSchemeSelectorScreen extends StatelessWidget {
  const FlexSchemeSelectorScreen(
      {super.key, required this.flexScheme, required this.onChanged});
  final FlexScheme flexScheme;
  final ValueChanged<FlexScheme> onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Explorer')),
      body: ListView.builder(
        itemCount: m3Schemes.length,
        itemBuilder: (_, index) {
          final scheme = m3Schemes[index];
          return RadioListTile<FlexScheme>(
            title: Text(scheme.name),
            value: scheme,
            groupValue: flexScheme,
            onChanged: (scheme) {
              if (scheme != null) {
                onChanged(scheme);
              }
            },
          );
        },
      ),
    );
  }
}
