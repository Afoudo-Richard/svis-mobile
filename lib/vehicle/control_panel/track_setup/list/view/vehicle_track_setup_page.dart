import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/control_panel/track_setup/list/bloc/vehicle_track_setup_bloc.dart';
import 'package:app/vehicle/control_panel/track_setup/list/view/vehicle_track_setup_view.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleTrackSetupPage extends StatelessWidget {
  const VehicleTrackSetupPage({Key? key, required this.vehicleDashboardBloc}) : super(key: key);

  final VehicleDashboardBloc vehicleDashboardBloc;

  static Route route(VehicleDashboardBloc vehicleDashboardBloc) {
    return MaterialPageRoute<void>(builder: (_) => VehicleTrackSetupPage(vehicleDashboardBloc: vehicleDashboardBloc,));
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
                  return VehicleTrackSetupBloc(vehicleDashboardBloc.vehicle)
                    ..add(VehicleTrackSetupFetch());
                },
              ),
              BlocProvider(
                create: (context) => vehicleDashboardBloc,
              ),
            ],
            child: VehicleTrackSetUpView(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
