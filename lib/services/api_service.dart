import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<double> convertCurrency(
      String fromCurrency, String toCurrency) async {
    final response = await http.get(Uri.parse(
        'http://economia.awesomeapi.com.br/json/last/$fromCurrency-$toCurrency'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final rate =
          double.parse(jsonResponse['$fromCurrency$toCurrency']['high']);
      return rate;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
