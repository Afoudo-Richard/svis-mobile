import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/details/view/user_dashboard_view.dart';
import 'package:app/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverDashboardPage extends StatelessWidget {
  const DriverDashboardPage({Key? key, required this.user}) : super(key: key);
  final ProfileUser? user;

  static Route route(ProfileUser? user) {
    return MaterialPageRoute<void>(
        builder: (_) => DriverDashboardPage(user: user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDashboardBloc(user: user as ProfileUser),
      child: UserDashboardView(),
    );
  }
}
