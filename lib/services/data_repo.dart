import 'package:crypto_bloc_api/model/currency.dart';
import 'package:crypto_bloc_api/model/data_error.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoRepo {
  static const String _baseUrl = 'https://min-api.cryptocompare.com/';

  final http.Client _httpClient;

  CryptoRepo({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client(); //no idea what this does

  Future<List<CryptoCurrency>> getCurrencies() async {
    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=25&tsym=USD&page=0';
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final coinList = List.from(data['Data']);
        return coinList.map((e) => CryptoCurrency.fromMap(e)).toList();
      }
      return [];
    } catch (error) {
      throw DataError(message: error.toString());
    }
  }
}
