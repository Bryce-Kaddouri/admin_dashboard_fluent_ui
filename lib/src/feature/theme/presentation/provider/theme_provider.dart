import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeProvider with ChangeNotifier {
  final _secureStorage = const FlutterSecureStorage();

  String _themeMode = 'system';
  String get themeMode => _themeMode;

  void setThemeMode(String value) {
    _themeMode = value;
    _secureStorage.write(key: 'themeMode', value: value);
    notifyListeners();
  }

  void getThemeMode() async {
    final themeMode = await _secureStorage.read(key: 'themeMode');
    if (themeMode != null) {
      _themeMode = themeMode;
      notifyListeners();
    }
  }
}
