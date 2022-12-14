import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/details/view/user_dashboard_view.dart';
import 'package:app/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../details.dart';

class DriverDashboardPage extends StatelessWidget {
  DriverDashboardPage({Key? key, required this.user}) : super(key: key);
  final ProfileUser? user;

  late DriverDashboardBloc driverDashboardBloc;

  static Route route(ProfileUser? user) {
    return MaterialPageRoute<void>(
        builder: (_) => DriverDashboardPage(user: user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverDashboardBloc(user: user)..add(DriverDashboardInit(user: user)),
      child: UserDashboardView(),
    );
  }
}
