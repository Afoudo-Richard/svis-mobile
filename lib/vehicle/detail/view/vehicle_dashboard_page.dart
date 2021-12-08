import 'package:app/repository/models/models.dart';
import 'package:app/vehicle/detail/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleDashboardPage extends StatelessWidget {
  VehicleDashboardPage({Key? key, required this.vehicle}) : super(key: key);
  final Vehicle? vehicle;

  static Route route(Vehicle? vehicle) {
    return MaterialPageRoute<void>(
        builder: (_) => VehicleDashboardPage(vehicle: vehicle));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VehicleDashboardBloc(vehicle: vehicle)..add(FetchLastKnwonLocation()),
      child: VehicleDashboardView(),
    );
  }
}
