import 'package:app/authentication/bloc/authentication_bloc.dart';
import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UserProfilePage());
  }

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userProfile').tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => UserProfileBloc(user:state.user),
                child: UserProfileForm(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: AppBottomAppBar(),
    );
  }
}
