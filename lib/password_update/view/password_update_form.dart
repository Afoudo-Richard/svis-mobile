import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/password_update/password_update.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/colors.dart';

class PasswordUpdateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordUpdateBloc, PasswordUpdateState>(
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
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _SuccessDialog();
              });
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'passwordUpdate.title',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).tr(),
              SizedBox(height: kDeviceSize.height * 0.01),
              Text('passwordUpdate.tag').tr(),
              SizedBox(height: kDeviceSize.height * 0.05),
              _OldPasswordInput(),
              SizedBox(height: kDeviceSize.height * 0.01),
              _PasswordInput(),
              SizedBox(height: kDeviceSize.height * 0.01),
              _ConfirmPasswordInput(),
              SizedBox(height: kDeviceSize.height * 0.1),
              _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordUpdateBloc, PasswordUpdateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Center(
                child: const CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .read<PasswordUpdateBloc>()
                              .add(const PasswordUpdateSubmitted());
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('update').tr(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class _OldPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordUpdateBloc, PasswordUpdateState>(
      buildWhen: (previous, current) =>
          previous.oldPassword != current.oldPassword,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextField(
              key: const Key('password_updateForm_passwordInput_textField'),
              obscureText: true,
              onChanged: (username) => context
                  .read<PasswordUpdateBloc>()
                  .add(PasswordUpdateOldPasswordChanged(username)),
              decoration: InputDecoration(
                hintText: 'forms.password'.tr(),
                errorText:
                    state.oldPassword.invalid ? 'invalid password' : null,
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
    return BlocBuilder<PasswordUpdateBloc, PasswordUpdateState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.newPassword',
              style: kLabelStyle,
            ).tr(),
            Stack(
              children: [
                TextField(
                  key: const Key('registerForm_newPasswordInput_textField'),
                  onChanged: (password) => context
                      .read<PasswordUpdateBloc>()
                      .add(PasswordUpdatePasswordChanged(password)),
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
    return BlocBuilder<PasswordUpdateBloc, PasswordUpdateState>(
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
                      .read<PasswordUpdateBloc>()
                      .add(PasswordUpdateConfirmPasswordChanged(password)),
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

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              'Password reset successful!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: kAppPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Okay',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
