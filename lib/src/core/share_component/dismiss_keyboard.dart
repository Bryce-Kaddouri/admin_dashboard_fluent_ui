import 'package:fluent_ui/fluent_ui.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: PopScope(
          onPopInvoked: (val) async {
            print('onPopInvoked');
            print(val);
            FocusScope.of(context).unfocus();
            /*return false;*/
          },
          child: SafeArea(
            child: child,
          ),
        ));
  }
}
