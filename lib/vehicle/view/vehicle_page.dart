import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/bloc/vehicle_listing_bloc.dart';
import 'package:app/vehicle/view/vehicle_list.dart';
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
        if(state.user != null){
        return BlocProvider(
          create: (context) => VehicleListingBloc(state.user as User)..add(VehicleListFetched()),
          child: VehicleList(),
        );
        }else{
          return Container();
        }
      },
    );
  }
}
