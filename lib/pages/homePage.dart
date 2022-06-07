import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/pages/markets.dart';
import 'package:crypto_tracker/providers/marke_provider.dart';
import 'package:crypto_tracker/providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detailPage.dart';
import 'liked.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    themeProvider themes = Provider.of<themeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Crypto Today',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      themes.changeTheme();
                    },
                    icon: (themes.type == ThemeMode.dark)
                        ? Icon(Icons.light_mode)
                        : Icon(Icons.dark_mode),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(
                controller: controller,
                tabs: [
                  Tab(
                    child: Text('Markets',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Tab(
                    child: Text('Liked',
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: controller,
                  children: [
                    markets(),
                    liked(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
