import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/control_panel/main/bloc/vehicle_control_panel_bloc.dart';
import 'package:app/vehicle/control_panel/main/view/vehicle_control_panel_view.dart';
import 'package:app/vehicle/driver_assigned/views/vehicle_driver_assigned_view.dart';
import 'package:app/vehicle/vehicle.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleControlPanelPage extends StatelessWidget {
  const VehicleControlPanelPage({Key? key, required this.vehicleDashboardBloc})
      : super(key: key);
  final VehicleDashboardBloc vehicleDashboardBloc;
  static Route route(VehicleDashboardBloc vehicleDashboardBloc) {
    return MaterialPageRoute<void>(
        builder: (_) => VehicleControlPanelPage(
              vehicleDashboardBloc: vehicleDashboardBloc,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return VehicleControlPanelBloc();
                },
              ),
              BlocProvider(
                create: (context) => vehicleDashboardBloc,
              ),
            ],
            child: VehicleControlPanelView(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
