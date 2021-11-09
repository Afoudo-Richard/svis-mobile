import 'package:app/authentication/authentication.dart';
import 'package:app/users/add/bloc/add_user_bloc.dart';
import 'package:app/users/add/view/add_user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddUserPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addUser'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => AddUserBloc(profile: state.profile),
                child: AddUserForm(),
              );
            },
          ),
        ),
      ),
    );
  }
}
