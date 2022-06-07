import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/providers/marke_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailPage.dart';

class markets extends StatefulWidget {
  const markets({Key? key}) : super(key: key);

  @override
  State<markets> createState() => _marketsState();
}

class _marketsState extends State<markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<marketProvider>(builder: (context, marketProvider, child) {
      if (marketProvider.isLoading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (marketProvider.market.length > 0) {
          return ListView.builder(
              itemCount: marketProvider.market.length,
              itemBuilder: (context, index) {
                cryptoCurreny current = marketProvider.market[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => detailPage(
                          id: current.id!,
                        ),
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(current.image),
                  ),
                  title: Text(
                      current.market_cap_rank.toString() + '. ' + current.name),
                  subtitle: Text(current.symbol.toUpperCase()),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹ ' + current.current_price.toStringAsFixed(5),
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Builder(builder: (context) {
                        double priceChange = current.price_change_24h;
                        double princePercent =
                            current.price_change_percentage_24h;
                        if (priceChange < 0) {
                          return Text(
                            current.price_change_percentage_24h
                                    .toStringAsFixed(2) +
                                '% ' +
                                '₹ ' +
                                current.price_change_24h.toStringAsFixed(5),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.red,
                            ),
                          );
                        } else {
                          return Text(
                            '+' +
                                current.price_change_percentage_24h
                                    .toStringAsFixed(2) +
                                '% ' +
                                '₹ ' +
                                '+' +
                                current.price_change_24h.toStringAsFixed(5),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.green,
                            ),
                          );
                        }
                      })
                    ],
                  ),
                );
              });
        } else {
          return Text('no');
        }
      }
    });
  }
}
