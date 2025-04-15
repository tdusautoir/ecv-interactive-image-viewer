import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Interactive Image Viewer'),
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
  final int _minZoom = 50;
  final int _maxZoom = 250;
  final int _zoomStep = 10;
  int _zoom = 100;
  double luminosity = 100;

  void handleLuminosityChange(double value) {
    setState(() {
      luminosity = value;
    });
  }

  void _incrementZoom() {
    setState(() {
      int newValue = _zoom + _zoomStep;
      if (!(newValue > _maxZoom)) _zoom = newValue;
    });
  }

  void _decrementZoom() {
    setState(() {
      int newValue = _zoom - _zoomStep;
      if (!(newValue < _minZoom)) _zoom = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        const Image(
          image: AssetImage('assets/image.jpg'),
          width: 320,
        ),
        SliderExample(
          value: luminosity,
          onChanged: handleLuminosityChange,
        ),
        Wrap(
          spacing: 50,
          children: [
            ElevatedButton(
                onPressed: _decrementZoom, child: const Icon(Icons.remove)),
            Text(
              '$_zoom %',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: _incrementZoom, child: const Icon(Icons.add))
          ],
        ),
      ]),
    );
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample(
      {super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(widget.value.toStringAsFixed(0)),
      Slider(
        value: widget.value,
        max: 100,
        onChanged: widget.onChanged,
      ),
    ]);
  }
}
