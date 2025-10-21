import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;
  String _message = 'Please enter your height and weight';

  void _calculateBmi() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Height and weight must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));
      if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'You have a normal weight';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
      } else {
        _message = 'You are obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height in cm',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight in kg',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBmi,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20),
              Text(
                _bmi == null ? 'No result' : 'Your BMI is ${_bmi!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                _message,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}