import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/commons/widgets/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroView(),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        child: BottomAppBar(
          color: kAppPrimaryColor,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<AuthenticationBloc>().add(
                            AuthenticationStatusChanged(
                                AuthenticationStatus.unauthenticated),
                          );
                    },
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
                VerticalDivider(color: Colors.white, thickness: 2),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'register',
                          style: TextStyle(color: Colors.white),
                        ).tr(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
