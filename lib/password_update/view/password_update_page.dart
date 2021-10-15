import 'package:app/authentication/authentication.dart';
import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/password_update/password_update.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:app/commons/colors.dart';

class PasswordUpdatePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PasswordUpdatePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PasswordUpdateBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'userProfile',
            style:
                TextStyle(color: kAppPrimaryColor, fontWeight: FontWeight.bold),
          ).tr(),
          elevation: 0,
          backgroundColor: kScaffoldBackground,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PasswordUpdateForm(),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomAppBar(),
      ),
    );
  }
}
