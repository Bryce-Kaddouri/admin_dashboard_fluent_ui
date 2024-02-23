import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                        context.go('/home');
                      } else {
                        Get.snackbar(
                          'Error',
                          context.read<AuthProvider>().loginErrorMessage!,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                          ),
                          isDismissible: true,
                          forwardAnimationCurve: Curves.easeOutBack,
                          reverseAnimationCurve: Curves.easeInBack,
                          onTap: (value) => Get.back(),
                          mainButton: TextButton(
                            onPressed: () => Get.back(),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
