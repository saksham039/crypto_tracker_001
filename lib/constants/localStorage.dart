import 'package:shared_preferences/shared_preferences.dart';

class localStorage {
  static Future<bool> saveTheme(String type) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool result = await shared.setString('theme', type);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? result = await shared.getString('theme') ?? 'light';
    return result;
  }

  static Future<bool> addlike(String id) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    List<String> fav = shared.getStringList('liked') ?? [];
    fav.add(id);
    return await shared.setStringList('liked', fav);
  }

  static Future<bool> removelike(String id) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    List<String> fav = shared.getStringList('liked') ?? [];
    fav.remove(id);
    return await shared.setStringList('liked', fav);
  }

  static Future<List<String>> fetchLike() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    List<String> r =  await shared.getStringList('liked') ?? [];
    return r;
  }
}
