import 'package:admin_dashboard/src/core/share_component/dismiss_keyboard.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  // global key for the form
  final _formKey = GlobalKey<FormState>();
  // controller for the email field
  final TextEditingController emailController = TextEditingController();
  // controller for the password field
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: fluent.FluentTheme.of(context).shadowColor,
        surfaceTintColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        backgroundColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor,
        centerTitle: true,
        title: Text('Sign In', style: fluent.FluentTheme.of(context).typography.title),
      ),
      backgroundColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      body: DismissKeyboard(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: fluent.Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(children: [
                    fluent.InfoLabel(
                      label: 'email:',
                      child: fluent.TextFormBox(
                        prefix: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          child: const Icon(fluent.FluentIcons.mail),
                        ),
                        controller: emailController,
                        placeholder: 'email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    fluent.InfoLabel(
                      label: 'password:',
                      child: fluent.PasswordFormBox(
                        leadingIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          child: const Icon(fluent.FluentIcons.lock),
                        ),
                        controller: passwordController,
                        placeholder: 'password',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                  ]),
                ),
                fluent.Container(
                  height: 50,
                  width: double.infinity,
                  child: fluent.FilledButton(
                    onPressed: () {
                      // Validate and save the form values
                      if (_formKey.currentState!.validate()) {
                        /*debugPrint(_formKey.currentState?.value.toString());*/
                        String email = emailController.text;
                        String password = passwordController.text;

                        context
                            .read<AuthProvider>()
                            .login(
                              email,
                              password,
                            )
                            .then((value) {
                          if (value) {
                            context.go('/');
                          } else {
                            fluent.displayInfoBar(
                              context,
                              builder: (context, close) {
                                return fluent.InfoBar(
                                  title: const Text('Error!'),
                                  content: const Text('Invalid email or password. Please try again.'),

                                  /*'The user has not been added because of an error. ${l.errorMessage}'*/

                                  action: IconButton(
                                    icon: const Icon(fluent.FluentIcons.clear),
                                    onPressed: close,
                                  ),
                                  severity: fluent.InfoBarSeverity.error,
                                );
                              },
                              alignment: Alignment.topRight,
                              duration: const Duration(seconds: 5),
                            );
                          }
                        });
                      }
                    },
                    child: context.watch<AuthProvider>().isLoading
                        ? fluent.ProgressRing()
                        : const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
