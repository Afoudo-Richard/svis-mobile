import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/list/list.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => VehiclePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider(
            create: (context) {
              return VehicleListingBloc(state.user as User)
                ..add(VehicleListFetched());
            },
            child: VehicleList(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
