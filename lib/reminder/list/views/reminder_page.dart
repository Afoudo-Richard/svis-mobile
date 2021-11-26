import 'package:app/authentication/authentication.dart';
import 'package:app/reminder/list/bloc/reminder_list_bloc.dart';
import 'package:app/reminder/list/views/reminder_list.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class ReminderPage extends StatelessWidget {
  final Vehicle? vehicle;

  const ReminderPage({Key? key, required this.vehicle }) : super(key: key);
  

  static Route route(Vehicle? vehicle) {
    return MaterialPageRoute<void>(builder: (_) => ReminderPage(vehicle: vehicle,));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider(
            create: (context) {
              return ReminderListBloc(vehicle)
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
