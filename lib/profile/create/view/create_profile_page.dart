import 'package:app/authentication/authentication.dart';
import 'package:app/profile/create/view/create_profile_form.dart';
import 'package:app/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateProfilePage());
  }

  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addProfile').tr(),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) =>
                  CreateProfileBloc(profileUserTypes: state.profileUserTypes),
              child: CreateProfileForm(),
            );
          },
        ),
      ),
    );
  }
}
