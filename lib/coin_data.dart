import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey='42500E9C-A6A9-4421-97A6-87B081253B91';
const apiUrl='https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<dynamic> getData(String selectedCurrency) async {
      Map<String,String> cryptodata={};

      for(String crypto in cryptoList){
        String url='$apiUrl/$crypto/$selectedCurrency/?apikey=$apiKey';
        http.Response response= await http.get(Uri.parse(url));

        if(response.statusCode==200){
          var decodeData=response.body;
          var rate=jsonDecode(decodeData)['rate'];
          rate=rate.toStringAsFixed(0);
          cryptodata[crypto]=rate;
        }
        else print(response.statusCode);
      }
      return cryptodata;
    }
}
