import 'package:crypto_tracker/constants/localStorage.dart';
import 'package:crypto_tracker/providers/marke_provider.dart';
import 'package:crypto_tracker/providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homePage.dart';
import 'constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  String currentTheme = await localStorage.getTheme()??'light';
  runApp(MyApp(currentTheme: currentTheme,));
}

class MyApp extends StatelessWidget {
  final String currentTheme;
  MyApp({required this.currentTheme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => marketProvider(),
        ),
        // baki providers yeh daal duga
        ChangeNotifierProvider(
          create: (context) => themeProvider(currentTheme),
        ),
      ],
      child: Consumer<themeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.type,
          theme: lightTheme,
          darkTheme: darktheme,
          home: homePage(),
        );
      }),
    );
  }
}
