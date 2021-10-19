import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/terminate_account/terminate_account.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/colors.dart';

class TerminateAccountForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TerminateAccountBloc, TerminateAccountState>(
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
                'terminateAccount.title',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).tr(),
              SizedBox(height: kDeviceSize.height * 0.01),
              Text('terminateAccount.tag').tr(),
              SizedBox(height: kDeviceSize.height * 0.05),
              _UsernameInput(),
              SizedBox(height: kDeviceSize.height * 0.05),
              _PasswordInput(),
              SizedBox(height: kDeviceSize.height * 0.05),
              BlocBuilder<TerminateAccountBloc, TerminateAccountState>(
                builder: (context, state) {
                  return state.status.isSubmissionInProgress
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDeviceSize.width * 0.1),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: state.status.isValidated
                                ? () {
                                    context
                                        .read<TerminateAccountBloc>()
                                        .add(TerminateAccountSubmitted());
                                  }
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('terminate').tr(),
                              ],
                            ),
                          ),
                        );
                },
              ),
              SizedBox(height: kDeviceSize.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TerminateAccountBloc, TerminateAccountState>(
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
              key: const Key('terminate_accountForm_usernameInput_textField'),
              onChanged: (username) => context
                  .read<TerminateAccountBloc>()
                  .add(TerminateAccountUsernameChanged(username)),
              decoration: InputDecoration(
                hintText: 'login.email'.tr(),
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
    return BlocBuilder<TerminateAccountBloc, TerminateAccountState>(
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
                      .read<TerminateAccountBloc>()
                      .add(TerminateAccountPasswordChanged(password)),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '********',
                    errorText:
                        state.password.invalid ? 'invalid password' : null,
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Text(
              'Account terminated!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            onTap: () {
              context.read<AuthenticationBloc>().add(
                    AuthenticationStatusChanged(
                      AuthenticationStatus.unauthenticated,
                    ),
                  );
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
