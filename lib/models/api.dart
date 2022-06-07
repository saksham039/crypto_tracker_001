import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  // static mark krke we canuse this specefic function without even creating an object
  static Future<List<dynamic>> getMarkets() async {
    try {
      var url = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");
      var response = await http.get(url);
      var decoded = jsonDecode(response.body);
      List<dynamic> market = decoded as List<dynamic>;
      return market;
    } catch (ex) {
      return [];
    }
  }
}
