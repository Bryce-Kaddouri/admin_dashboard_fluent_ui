import 'package:admin_dashboard/src/feature/user/data/model/user_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

// add catgeory screen
// name, description, image

class UserUpdateScreen extends StatelessWidget {
  final String uid;
  const UserUpdateScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
        padding: EdgeInsets.zero,
        header: Container(
          color:
          FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor,
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              SizedBox(width: 10),
              IconButton(
                icon: Icon(FluentIcons.back, size: 20),
                onPressed: () {
                  context.go('/user');
                },
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Update User', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
        children: [
    Container(
    constraints: BoxConstraints(
    maxWidth: MediaQuery.of(context).size.width,
    minHeight: MediaQuery.of(context).size.height - 60,
    ),
    color: FluentTheme.of(context)
        .navigationPaneTheme
        .overlayBackgroundColor,
    child: Card(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: UserUpdateForm(uid: uid,),
    ),
    ),
    ],
    );
  }
}


class UserUpdateForm extends StatefulWidget {
  final String uid;
  const UserUpdateForm({super.key, required this.uid});

  @override
  State<UserUpdateForm> createState() => _UserUpdateFormState();
}

class _UserUpdateFormState extends State<UserUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  String _password = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    context.read<UserProvider>().getUserById(widget.uid).then((value) {
      if (value != null) {
        _firstNameController.text = value.userMetadata!['fName'];
        _lastNameController.text = value.userMetadata!['lName'];
        _emailController.text = value.email!;
        _roleController.text = value.appMetadata!['role'];

      }
    });
    // _initData();
  }
  @override
  Widget build(BuildContext context) {
/*
    print(context.watch<ProductProvider>().productModel);
*/

    return
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InfoLabel(
                    label: 'Enter First Name:',
                    child:
                    Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500, minHeight: 50),
                      child:
                      TextFormBox(
                        controller: _firstNameController,
                        placeholder: 'First Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  InfoLabel(
                    label: 'Enter Last Name:',
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500, minHeight: 50),
                      child:TextFormBox(
                        controller: _lastNameController,
                        placeholder: 'Last Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),),
                  SizedBox(height: 30),

                  InfoLabel(
                    label: 'Enter Email:',
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500, minHeight: 50),
                      child:TextFormBox(
                        controller: _emailController,
                        placeholder: 'Email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  InfoLabel(
                    label: 'Enter New Password:',
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500, minHeight: 50),
                      child:PasswordFormBox(

                        revealMode: PasswordRevealMode.peekAlways,
                        controller: _passwordController,
                        placeholder: 'Password',

                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  InfoLabel(
                    label: 'Enter New Confirm Password:',
                    child:
                    Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500, minHeight: 50),
                      child:
                      PasswordFormBox(
                        revealMode: PasswordRevealMode.peekAlways,
                        controller: _confirmPasswordController,
                        placeholder: 'Confirm Password',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      /*  validator: FormBuilderValidators.compose([
                          FormBuilderValidators.equal(_password,
                              errorText: 'Passwords do not match'),
                        ]),*/
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  InfoLabel(
                    label: 'Select Role:',
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 500, minHeight: 50),
                      child:ComboboxFormField<String>(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        isExpanded: true,
                        value: _roleController.text,
                        placeholder: Text('Select Role'),
                        items: [
                          ComboBoxItem(
                            child: Text('ADMIN'),
                            value: 'ADMIN',
                          ),
                          ComboBoxItem(
                            child: Text('COOKER'),
                            value: 'COOKER',
                          ),
                          ComboBoxItem(
                            child: Text('SELLER'),
                            value: 'SELLER',
                          ),
                          ComboBoxItem(
                            child: Text('BOOK'),
                            value: 'BOOK',
                          ),
                        ],
                        onChanged: (String? value) {
                          _roleController.text = value!;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 60),

                  FilledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('Form is valid');
                        String fName = _firstNameController.text;
                        String lName = _lastNameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String role = _roleController.text;
                        var userData = await context.read<UserProvider>().getUserById(widget.uid);

                       UserModel oldUser = UserModel.fromUser(userData!);
                        UserModel newUser = UserModel(
                          id: oldUser.id,
                          email: oldUser.email != email ? email : oldUser.email,
                          firstName: oldUser.firstName != fName ? fName : oldUser.firstName,
                          lastName: oldUser.lastName != lName ? lName : oldUser.lastName,
                          role: oldUser.role != role ? role : oldUser.role,
                          createdAt: oldUser.createdAt,
                          updatedAt: DateTime.now(),
                          isActive: oldUser.isActive,
                        );

                        bool res = await context
                            .read<UserProvider>()
                            .updateUser(
                          fName: newUser.firstName,
                          lName: newUser.lastName,
                          email: newUser.email,
                          password: password,
                          role: newUser.role,
                          isAvailable: newUser.isActive,
                          uid: newUser.id,
                          context: context,

                        );
                        if (res == true) {
                          // reset form
                          _firstNameController.clear();
                          _lastNameController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _confirmPasswordController.clear();
                          _roleController.clear();

                          setState(() {
                            _password = '';
                          });
                        }
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: context.watch<UserProvider>().isLoading
                        ? const ProgressRing()
                        :
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 30,
                      child:Text('Save'),),
                  ),
                ],
              ),

    );
  }
}
