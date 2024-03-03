import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../../../theme/presentation/provider/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text('Theme'),
            trailing: ToggleSwitch(
              checked: context.watch<ThemeProvider>().themeMode == 'dark'
                  ? true
                  : false,
              onChanged: (bool value) {
                context
                    .read<ThemeProvider>()
                    .setThemeMode(value ? 'dark' : 'light');
              },
            ),
          ),
          ListTile(
            title: Text('Language'),
          ),
        ],
      ),
    );
  }
}
