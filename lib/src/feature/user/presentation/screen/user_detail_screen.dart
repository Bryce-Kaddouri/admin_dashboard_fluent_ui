import 'package:admin_dashboard/src/feature/user/data/model/user_model.dart';
import 'package:admin_dashboard/src/feature/user/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDetailScreen extends StatelessWidget {
  final String uid;
  const UserDetailScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){context.go(
            '/user-list',
          );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('User Detail'),
      ),
      body: Container(
        child: FutureBuilder<User?>(
          future: context.read<UserProvider>().getUserById(uid),
          builder: (context, userSnapshot){
            if(userSnapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else{
              if(userSnapshot.hasError){
                return const Center(child: Text('Error'));
              }else{
                if(userSnapshot.hasData) {
                  User user = userSnapshot.data!;
                  print('user: $user');
                  UserModel userModel = UserModel.fromUser(user);
                  return Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text('Name: ${userModel.firstName} ${userModel.lastName}'),
                        Text('Email: ${userModel.email}'),
                        Text('Role: ${userModel.role}'),
                        Text('Created At: ${userModel.createdAt}'),
                        Text('Updated At: ${userModel.updatedAt}'),
                      ],
                    ),
                  );
                }else{
                  return const Center(child: Text('No data'));
                }
              }
            }
          },
        ),
      ),
    );
  }
}
