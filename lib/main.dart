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
       debugShowCheckedModeBanner: false,
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

  void _showInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Informations sur l'image",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12.0),
              Text("Titre:"),
              const SizedBox(height: 8.0),
              Text("Description:"),
              const SizedBox(height: 8.0),
              Text("Source:"),
              const Divider(),
              const Text(
                "Instructions d'utilisation:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                  "• Utilisez les boutons + et - pour zoomer et dézoomer"),
              const Text("• Ajustez la luminosité avec le curseur"),
              const Text("• Activez le mode noir et blanc avec l'interrupteur"),
              const Text(
                  "• Appuyez sur 'Réinitialiser' pour restaurer les paramètres par défaut"),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fermer"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Visionneuse d'Image"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoBottomSheet,
          ),
        ],
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
