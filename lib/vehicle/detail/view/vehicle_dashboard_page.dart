import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/users/details/view/user_dashboard_view.dart';
import 'package:app/users/users.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';
import 'package:app/vehicle/detail/view/vehicle_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleDashboardPage extends StatelessWidget {
  VehicleDashboardPage({Key? key, required this.vehicle}) : super(key: key);
  final Vehicle? vehicle;

  late DriverDashboardBloc driverDashboardBloc;

  static Route route(Vehicle? vehicle) {
    return MaterialPageRoute<void>(
        builder: (_) => VehicleDashboardPage(vehicle: vehicle));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VehicleDashboardBloc(vehicle: vehicle),
      child: VehicleDashboardView(),
    );
  }
}
