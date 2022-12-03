import 'package:flutter/material.dart';
import 'package:flutter_animation_example/circle_waves/circle_wave.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        ElevatedButton(onPressed: () {
          push(CircleWaveExample());
        }, child: Text('Circle Wave')),
      ],
    );
  }

  void push(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}
