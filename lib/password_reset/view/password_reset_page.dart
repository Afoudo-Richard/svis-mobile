import 'package:app/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/password_reset/password_reset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:app/commons/colors.dart';

class PasswordResetPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PasswordResetPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PasswordResetBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: _PasswordResetPage(),
    );
  }
}

class _PasswordResetPage extends StatefulWidget {
  @override
  __PasswordResetPageState createState() => __PasswordResetPageState();
}

class __PasswordResetPageState extends State<_PasswordResetPage> {
  Future<bool> _willPopCallback() async {
    context.read<AuthenticationBloc>().add(
          AuthenticationStatusChanged(AuthenticationStatus.unauthenticated),
        );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
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
              PasswordResetForm(),
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
            child: _PasswordResetButton(),
          ),
        ),
      ),
    );
  }
}

class _PasswordResetButton extends StatelessWidget {
  const _PasswordResetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
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
                                  .read<PasswordResetBloc>()
                                  .add(const PasswordResetSubmitted());
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'submit',
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
