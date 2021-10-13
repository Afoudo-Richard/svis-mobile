import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/password_reset/password_reset.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/commons/colors.dart';

class PasswordResetForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordResetBloc, PasswordResetState>(
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
                'passwordReset.title',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).tr(),
              SizedBox(height: kDeviceSize.height * 0.01),
              Text('passwordReset.tag').tr(),
              SizedBox(height: kDeviceSize.height * 0.05),
              _UsernameInput(),
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
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
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
              key: const Key('password_resetForm_usernameInput_textField'),
              onChanged: (username) => context
                  .read<PasswordResetBloc>()
                  .add(PasswordResetUsernameChanged(username)),
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
              'Password Reset Email Sent',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              'An email has been sent to your email address. Follow directions in the email to reset your password.',
              textAlign: TextAlign.center,
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
