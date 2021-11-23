import 'package:app/authentication/authentication.dart';
import 'package:app/reminder/list/bloc/reminder_list_bloc.dart';
import 'package:app/reminder/list/views/reminder_list.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReminderPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider(
            create: (context) {
              return ReminderListBloc(state.user as User)
                ..add(ReminderListFetched());
            },
            child: ReminderList(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
