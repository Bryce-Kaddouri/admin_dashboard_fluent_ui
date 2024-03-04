import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  // global key for the form
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ]),
              ),
              MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  // Validate and save the form values
                  if (_formKey.currentState!.saveAndValidate()) {
                    debugPrint(_formKey.currentState?.value.toString());
                    context
                        .read<AuthProvider>()
                        .login(
                          _formKey.currentState?.value['email'],
                          _formKey.currentState?.value['password'],
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
                              content: const Text(
                                  'Invalid email or password. Please try again.'),


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
                minWidth: double.infinity,
                height: 50,
                child: context.watch<AuthProvider>().isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
