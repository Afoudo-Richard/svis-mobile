import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/commons/colors.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/register/register.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                content: Text(
                  'register.submissionSusscess',
                  style: TextStyle(
                    color: kAppAccent,
                  ),
                ).tr(),
                backgroundColor: kAppAccent.withOpacity(0.2),
              ),
            );
          Future.delayed(Duration(seconds: 1), () {
            context.read<AuthenticationBloc>().add(
                  AuthenticationStatusChanged(
                    AuthenticationStatus.unauthenticated,
                  ),
                );
          });
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
                    'register.title',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ).tr(),
                  SizedBox(height: kDeviceSize.height * 0.01),
                  Text('register.tag').tr(),
                  SizedBox(height: kDeviceSize.height * 0.05),
                  _FirstNameInput(),
                  const Padding(padding: EdgeInsets.all(8)),
                  _LastNameInput(),
                  const Padding(padding: EdgeInsets.all(8)),
                  _UsernameInput(),
                  const Padding(padding: EdgeInsets.all(8)),
                  _PasswordInput(),
                  const Padding(padding: EdgeInsets.all(8)),
                  _ConfirmPasswordInput(),
                  SizedBox(height: kDeviceSize.height * 0.07),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            context.read<AuthenticationBloc>().add(
                                  AuthenticationStatusChanged(
                                      AuthenticationStatus.unauthenticated),
                                );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('alreadyHaveAnAccount').tr(),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: kDeviceSize.height * 0.02),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                'By Signing Up, you acknowledge that you have read and accepted our',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          TextSpan(
                            text: ' Terms of Service & Privacy Policy.',
                            style: TextStyle(color: kAppAccent),
                          )
                        ]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.firstName',
              style: kLabelStyle,
            ).tr(),
            TextFormField(
              key: const Key('registerForm_firstNameInput_textField'),
              initialValue: state.firstName.value,
              onChanged: (value) => context
                  .read<RegisterBloc>()
                  .add(RegisterFirstNameChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.firstName'.tr(),
                errorText: state.firstName.invalid ? 'invalid name' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.lastName',
              style: kLabelStyle,
            ).tr(),
            TextFormField(
              key: const Key('registerForm_lastNameInput_textField'),
              initialValue: state.lastName.value,
              onChanged: (username) => context
                  .read<RegisterBloc>()
                  .add(RegisterLastNameChanged(username)),
              decoration: InputDecoration(
                hintText: 'forms.lastName'.tr(),
                errorText: state.lastName.invalid ? 'invalid name' : null,
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.email',
              style: kLabelStyle,
            ).tr(),
            TextField(
              key: const Key('registerForm_usernameInput_textField'),
              onChanged: (username) => context
                  .read<RegisterBloc>()
                  .add(RegisterUsernameChanged(username)),
              decoration: InputDecoration(
                hintText: 'forms.email'.tr(),
                errorText: state.username.invalid ? 'invalid email' : null,
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.password',
              style: kLabelStyle,
            ).tr(),
            Stack(
              children: [
                TextField(
                  key: const Key('registerForm_passwordInput_textField'),
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(RegisterPasswordChanged(password)),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '********',
                    // errorText: state.password.invalid ? 'invalid password' : null,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Builder(
                    builder: (context) {
                      if (state.password.valid) {
                        return Icon(
                          Icons.check_circle,
                          color: const Color(0xff9193AB),
                        );
                      } else if (state.password.invalid) {
                        return Icon(
                          Icons.cancel,
                          color: const Color(0xff9193AB),
                        );
                      } else {
                        return Container();
                      }
                    },
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.confirmPassword',
              style: kLabelStyle,
            ).tr(),
            Stack(
              children: [
                TextFormField(
                  key: const Key('registrationForm_passwordInput_textField'),
                  initialValue: state.confirmPassword.value,
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(RegisterConfirmPasswordChanged(password)),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '********',
                    // errorText: state.confirmPassword.invalid ? 'invalid password' : null,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Builder(
                    builder: (context) {
                      if (state.confirmPassword.valid) {
                        return Icon(
                          Icons.check_circle,
                          color: const Color(0xff9193AB),
                        );
                      } else if (state.confirmPassword.invalid) {
                        return Icon(
                          Icons.cancel,
                          color: const Color(0xff9193AB),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              ],
            ),
            (state.password.invalid || state.confirmPassword.invalid)
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'forms.passwordError',
                      style: TextStyle(color: kDangerColor),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
