import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/configuration/view/vehicle_configutation_view.dart';
import 'package:app/vehicle/detail/bloc/vehicle_dashboard_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleConfigurationPage extends StatelessWidget {
  const VehicleConfigurationPage({Key? key, required this.vehicleDashboardBloc})
      : super(key: key);

  final VehicleDashboardBloc vehicleDashboardBloc;

  static Route route(VehicleDashboardBloc vehicleDashboardBloc) {
    return MaterialPageRoute<void>(
        builder: (_) => VehicleConfigurationPage(
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
                create: (context) => vehicleDashboardBloc,
              ),
            ],
            child: VehicleConfigurationVeiw(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
