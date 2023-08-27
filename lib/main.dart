import 'package:flutter/material.dart';
import 'screens/currency_converter_screen.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Currency Converter',
      home: CurrencyConverterScreen(),
    );
  }
}
