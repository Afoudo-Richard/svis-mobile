import 'package:app/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/terminate_account/terminate_account.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/colors.dart';

class TerminateAccountPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TerminateAccountPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TerminateAccountBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: _TerminateAccountPage(),
    );
  }
}

class _TerminateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            TerminateAccountForm(),
          ],
        ),
      ),
    );
  }
}