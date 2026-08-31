import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measures Converter',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      home: const MeasuresConverterPage(),
    );
  }
}

class MeasuresConverterPage extends StatefulWidget {
  const MeasuresConverterPage({super.key});

  @override
  State<MeasuresConverterPage> createState() => _MeasuresConverterPageState();
}

class _MeasuresConverterPageState extends State<MeasuresConverterPage> {
  final TextEditingController valueController = TextEditingController();

  String fromUnit = 'meters';
  String toUnit = 'feet';
  String result = '';

  final List<String> units = [
    'meters',
    'feet',
    'kilometers',
    'miles',
    'kilograms',
    'pounds',
  ];

  void convertValue() {
    double? value = double.tryParse(valueController.text);

    if (value == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    double convertedValue;

    if (fromUnit == 'meters' && toUnit == 'feet') {
      convertedValue = value * 3.28084;
    } else if (fromUnit == 'feet' && toUnit == 'meters') {
      convertedValue = value / 3.28084;
    } else if (fromUnit == 'kilometers' && toUnit == 'miles') {
      convertedValue = value * 0.621371;
    } else if (fromUnit == 'miles' && toUnit == 'kilometers') {
      convertedValue = value / 0.621371;
    } else if (fromUnit == 'kilograms' && toUnit == 'pounds') {
      convertedValue = value * 2.20462;
    } else if (fromUnit == 'pounds' && toUnit == 'kilograms') {
      convertedValue = value / 2.20462;
    } else if (fromUnit == toUnit) {
      convertedValue = value;
    } else {
      setState(() {
        result = 'Please select compatible units';
      });
      return;
    }

    setState(() {
      result =
      '${value.toStringAsFixed(1)} $fromUnit are '
          '${convertedValue.toStringAsFixed(3)} $toUnit';
    });
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Measures Converter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 25,
          ),
          child: Column(
            children: [
              const Text(
                'Value',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: valueController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'From',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: fromUnit,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                items: units.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    fromUnit = newValue!;
                  });
                },
              ),

              const SizedBox(height: 25),

              const Text(
                'To',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: toUnit,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                items: units.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    toUnit = newValue!;
                  });
                },
              ),

              const SizedBox(height: 35),

              ElevatedButton(
                onPressed: convertValue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.blue.shade800,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}