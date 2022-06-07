import 'dart:async';

import 'package:crypto_tracker/constants/localStorage.dart';
import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/models/api.dart';
import 'package:crypto_tracker/constants/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class themeProvider with ChangeNotifier {
  late ThemeMode type;

  themeProvider(String mode)  {
    if (mode == 'light') {
      type = ThemeMode.light;
    } else {
      type = ThemeMode.dark;
    }
  }

  void changeTheme() async {
    if (type == ThemeMode.light) {
      type = ThemeMode.dark;
      await localStorage.saveTheme('dark');
    } else {
      type = ThemeMode.light;
      await localStorage.saveTheme('light');
    }
    notifyListeners();
  }
}
