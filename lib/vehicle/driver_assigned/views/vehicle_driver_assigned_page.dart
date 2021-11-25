import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/bloc/vehicle_listing_bloc.dart';
import 'package:app/vehicle/driver_assigned/bloc/vehicle_driver_assigned_bloc.dart';
import 'package:app/vehicle/driver_assigned/views/vehicle_driver_assigned_view.dart';
import 'package:app/vehicle/view/vehicle_list.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

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
              return VehicleDriverAssignedBloc(state.user as User)
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
