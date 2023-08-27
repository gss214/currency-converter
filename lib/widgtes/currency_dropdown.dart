import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final List<Map> currencies;
  final Function(String?) onChanged;

  const CurrencyDropdown(
      {super.key,
      required this.selectedCurrency,
      required this.currencies,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: selectedCurrency,
        onChanged: onChanged,
        items: currencies.map<DropdownMenuItem<String>>((value) {
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
    );
  }
}
