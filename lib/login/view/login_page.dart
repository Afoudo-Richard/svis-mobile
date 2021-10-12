import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/login/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:app/commons/colors.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'appName',
          style:
              TextStyle(color: kAppPrimaryColor, fontWeight: FontWeight.bold),
        ).tr(),
        elevation: 0,
        backgroundColor: kScaffoldBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginForm(),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        child: BottomAppBar(
          color: kAppPrimaryColor,
          child: _LoginButton(),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IntrinsicHeight(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: state.status.isValidated
                          ? () {
                              context
                                  .read<LoginBloc>()
                                  .add(const LoginSubmitted());
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'login',
                            style: TextStyle(color: Colors.white),
                          ).tr(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Builder(
                  builder: (context) {
                    if (state.status.isSubmissionInProgress) {
                      return CircularProgressIndicator(
                        color: Colors.white,
                      );
                    } else if (state.status.isSubmissionSuccess) {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                      );
                    } else if (state.status.isSubmissionFailure) {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
