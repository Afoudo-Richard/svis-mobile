import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/login/login.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/colors.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                content: Text(
                  state.error,
                  style: TextStyle(
                    color: kDangerColor,
                  ),
                ).tr(),
                backgroundColor: kDangerColor.withOpacity(0.2),
              ),
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
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                                AuthenticationStatusChanged(
                                    AuthenticationStatus.registration),
                              );
                        },
                        child: Row(
                          children: [
                            Text(
                              'register.title',
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

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;
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
            Stack(
              children: [
                TextField(
                  key: const Key('loginForm_passwordInput_textField'),
                  onChanged: (password) => context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(password)),
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: '********',
                    // errorText:  state.password.invalid ? 'invalid password' : null,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: Color(0xff9193AB),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
