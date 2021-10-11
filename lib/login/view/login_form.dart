import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/login/login.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0, -2 / 3),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'welcome',
                    style: Theme.of(context).textTheme.headline3,
                  ).tr(),
                  SizedBox(height: kDeviceSize.height * 0.01),
                  Text('login.tag').tr(),
                  SizedBox(height: kDeviceSize.height * 0.05),
                  _UsernameInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  _PasswordInput(),
                  const Padding(padding: EdgeInsets.all(8)),
                  _RememberMe(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'register',
                              style: TextStyle(color: kAppAccent),
                            ).tr(),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            kDangerColor.withOpacity(0.1),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'forgotPassword',
                          style: TextStyle(color: kDangerColor),
                        ).tr(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RememberMe extends StatelessWidget {
  const _RememberMe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: state.rememberMe.value,
              onChanged: (value) {
                context.read<LoginBloc>().add(
                      RememberMeChanged(
                        value ?? false,
                      ),
                    );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text('rememberMe').tr(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'login.email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) =>
                  context.read<LoginBloc>().add(LoginUsernameChanged(username)),
              decoration: InputDecoration(
                hintText: 'username',
                errorText: state.username.invalid ? 'invalid username' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              obscureText: true,
              decoration: InputDecoration(
                hintText: '********',
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
