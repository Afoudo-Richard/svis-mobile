import 'package:app/commons/colors.dart';
import 'package:app/commons/time_item.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/users/users.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';
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
      create: (context) => DriverDashboardBloc(user: user)..add(DriverDashboardInit(user: user)),
      child: UserDashboardView(),
    );
  }
}

