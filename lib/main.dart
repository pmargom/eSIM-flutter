import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'One Click eSIM demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/esim');

  static const eSIMCodes = "LPA:1\$xxxxx.com\$activation_code";

  Future<void> _installESIM() async {
    try {
      await platform.invokeMethod('launchESimSetup', {
        "activationCode": eSIMCodes,
      });
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("One Tap eSIM demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (Platform.isIOS)
              ElevatedButton(
                onPressed: _installESIM,
                child: const Text('Install eSIM iOS'),
              ),
            if (Platform.isAndroid)
              ElevatedButton(
                onPressed: _installESIM,
                child: const Text('Install eSIM Android'),
              ),
          ],
        ),
      ),
    );
  }
}
