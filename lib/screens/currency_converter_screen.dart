import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgtes/currency_dropdown.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  CurrencyConverterScreenState createState() => CurrencyConverterScreenState();
}

class CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _inputValue = 1.0;
  double _outputValue = 0.0;

  final List<Map> _currencies = [
    {
      'name': 'USD',
      'icon':
          'https://www.countryflags.com/wp-content/uploads/united-states-of-america-flag-png-large.png'
    },
    {
      'name': 'EUR',
      'icon': 'https://cdn.countryflags.com/thumbs/europe/flag-400.png'
    },
    {
      'name': 'BRL',
      'icon':
          'https://www.countryflags.com/wp-content/uploads/brazil-flag-png-large.png'
    }
  ];

  void _convertCurrency() async {
    try {
      final rate = await ApiService.convertCurrency(_fromCurrency, _toCurrency);
      setState(() {
        _outputValue = _inputValue * rate;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Converter'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurrencyDropdown(
              selectedCurrency: _fromCurrency,
              currencies: _currencies,
              onChanged: (String? newValue) {
                setState(() {
                  _fromCurrency = newValue!;
                });
              },
            ),
            CurrencyDropdown(
              selectedCurrency: _toCurrency,
              currencies: _currencies,
              onChanged: (String? newValue) {
                setState(() {
                  _toCurrency = newValue!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Value to convert',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {
                    _inputValue = double.parse(value);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _convertCurrency,
                child: const Text('Convert'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_inputValue $_fromCurrency = $_outputValue $_toCurrency',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
