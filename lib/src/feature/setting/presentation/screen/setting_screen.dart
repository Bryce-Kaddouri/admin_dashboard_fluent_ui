import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../../../theme/presentation/provider/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(16),
            tileColor: ButtonState.all(FluentTheme.of(context).scaffoldBackgroundColor),
            title: Text('Theme'),
            trailing: ToggleSwitch(
              checked: context.watch<ThemeProvider>().themeMode == 'dark' ? true : false,
              onChanged: (bool value) {
                context.read<ThemeProvider>().setThemeMode(value ? 'dark' : 'light');
              },
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.all(16),
            tileColor: ButtonState.all(FluentTheme.of(context).scaffoldBackgroundColor),
            title: Text('Language'),
          ),
        ],
      ),
    );
  }
}
