import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lab1_leanbodymass/result.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lean Body Mass Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006D77)),
        scaffoldBackgroundColor: const Color(0xFFF4FBFB),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const LeanBodyMassPage(),
    );
  }
}

enum Gender { male, female }

class LeanBodyMassPage extends StatefulWidget {
  const LeanBodyMassPage({super.key});

  @override
  State<LeanBodyMassPage> createState() => _LeanBodyMassPageState();
}

class _LeanBodyMassPageState extends State<LeanBodyMassPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  Gender _selectedGender = Gender.male;

  String _boerFormula = '-';
  String _jamesFormula = '-';
  String _humeFormula = '-';

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lean Body Mass Calculator'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.teal.shade100),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Metric Unit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<Gender>(
                          segments: const [
                            ButtonSegment<Gender>(
                              value: Gender.male,
                              icon: Icon(Icons.male),
                              label: Text('Male'),
                            ),
                            ButtonSegment<Gender>(
                              value: Gender.female,
                              icon: Icon(Icons.female),
                              label: Text('Female'),
                            ),
                          ],
                          selected: <Gender>{_selectedGender},
                          onSelectionChanged: (Set<Gender> selected) {
                            setState(() => _selectedGender = selected.first);
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _heightController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Height (cm)',
                            hintText: 'e.g. 170',
                          ),
                          validator: (value) => _validatePositiveNumber(
                            value,
                            fieldName: 'Height',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _weightController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Weight (kg)',
                            hintText: 'e.g. 70',
                          ),
                          validator: (value) => _validatePositiveNumber(
                            value,
                            fieldName: 'Weight',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed: _calculate,
                              icon: const Icon(Icons.calculate_outlined),
                              label: const Text('Calculate'),
                            ),
                            OutlinedButton.icon(
                              onPressed: _clear,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Clear'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Result',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ResultTable(
                          boerFormula: _boerFormula,
                          jamesFormula: _jamesFormula,
                          humeFormula: _humeFormula,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _calculate() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final double height = _parseController(_heightController);
    final double weight = _parseController(_weightController);

    if (height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid height and weight values.'),
        ),
      );
      return;
    }

    final bool male = _selectedGender == Gender.male;
    final double boerResult = male
        ? (0.407 * weight) + (0.267 * height) - 19.2
        : (0.252 * weight) + (0.473 * height) - 48.3;
    final double jamesResult = male
        ? (1.1 * weight) - (128 * pow(weight / height, 2))
        : (1.07 * weight) - (148 * pow(weight / height, 2));
    final double humeResult = male
        ? (0.32810 * weight) + (0.33929 * height) - 29.5336
        : (0.29569 * weight) + (0.41813 * height) - 43.2933;

    setState(() {
      _boerFormula = _format(boerResult);
      _jamesFormula = _format(jamesResult);
      _humeFormula = _format(humeResult);
    });
  }

  void _clear() {
    _formKey.currentState?.reset();
    _weightController.clear();
    _heightController.clear();

    setState(() {
      _boerFormula = '-';
      _humeFormula = '-';
      _jamesFormula = '-';
      _selectedGender = Gender.male;
    });
  }

  String? _validatePositiveNumber(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }

    final normalized = value.replaceAll(',', '.');
    final parsedValue = double.tryParse(normalized);
    if (parsedValue == null) {
      return 'Enter a valid number.';
    }
    if (parsedValue <= 0) {
      return '$fieldName must be greater than 0.';
    }
    return null;
  }

  double _parseController(TextEditingController controller) {
    return double.parse(controller.text.trim().replaceAll(',', '.'));
  }

  String _format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
