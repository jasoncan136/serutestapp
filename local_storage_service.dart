import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String firstNameKey = 'first_name';
  static const String lastNameKey = 'last_name';
  static const String provinsiKey = 'provinsi';
  static const String kelurahanKey = 'kelurahan';
  static const String kecamatanKey = 'kecamatan';

  static Future<void> saveInput(String key, String input) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, input);
    print('Data saved in SharedPreferences: $input');
  }

  static Future<String?> getInput(String key) async {
     final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    print('Data loaded from SharedPreferences: $data');
    return data;
  }
}