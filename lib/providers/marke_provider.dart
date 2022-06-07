import 'dart:async';

import 'package:crypto_tracker/constants/localStorage.dart';
import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:crypto_tracker/models/api.dart';

class marketProvider with ChangeNotifier {
  bool isLoading = true;
  List<cryptoCurreny> market = [];
  marketProvider() {
    fetchData();
  }
  void fetchData() async {
    List<dynamic> markets = await API.getMarkets();
    List<String> like = await localStorage.fetchLike();
    List<cryptoCurreny> temp = [];
    for (var mar in markets) {
      cryptoCurreny newcurency = cryptoCurreny.fromJSON(mar);
      if (like.contains(newcurency.id)) {
        newcurency.like = true;
      }
      temp.add(newcurency);
    }
    market = temp;
    isLoading = false;
    notifyListeners();

    Timer(Duration(seconds: 3), () {
      fetchData();
    });
  }

  cryptoCurreny fetchById(String idcheck) {
    cryptoCurreny returner =
        market.where((element) => element.id == idcheck).toList()[0];
    return returner;
  }

  void addLike(cryptoCurreny crypto) async {
    int index = market.indexOf(crypto);
    market[index].like = true;
    await localStorage.addlike(market[index].id);
    notifyListeners();
  }

  void removeLike(cryptoCurreny crypto) async {
    int index = market.indexOf(crypto);
    market[index].like = false;
    await localStorage.removelike(market[index].id);
    notifyListeners();
  }
}
