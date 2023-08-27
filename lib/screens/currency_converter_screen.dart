import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/api_service.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: _fromCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _fromCurrency = newValue!;
                  });
                },
                items: _currencies.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value['name'],
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.network(
                              value['icon'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                        ),
                        Text(value['name']),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: _toCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _toCurrency = newValue!;
                  });
                },
                items: _currencies.map<DropdownMenuItem<String>>((Map value) {
                  return DropdownMenuItem<String>(
                    value: value['name'],
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(15),
                            child: Image.network(
                              value['icon'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                        ),
                        Text(value['name']),
                      ],
                    ),
                  );
                }).toList(),
              ),
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
