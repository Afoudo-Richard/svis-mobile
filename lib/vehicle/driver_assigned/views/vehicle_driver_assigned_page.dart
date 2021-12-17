import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/driver_assigned/bloc/vehicle_driver_assigned_bloc.dart';
import 'package:app/vehicle/driver_assigned/views/vehicle_driver_assigned_view.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleDriverAssignedPage extends StatelessWidget {
  const VehicleDriverAssignedPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => VehicleDriverAssignedPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider(
            create: (context) {
              return VehicleDriverAssignedBloc(state.profile)
                ..add(VehicleDriverAssigedListFetched());
            },
            child: VehicleDriverAssignList(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
