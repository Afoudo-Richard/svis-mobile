import 'package:app/authentication/bloc/authentication_bloc.dart';
import 'package:app/commons/widgets/app_bottom_app_bar.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:app/vehicle_profile/bloc/vehicle_profile_bloc.dart';
import 'package:app/vehicle_profile/view/vehicle_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  Vehicle? vehicle;
  static Route route(Vehicle vehicle) {
    return MaterialPageRoute<void>(builder: (_) => UserProfilePage(vehicle: vehicle,));
  }

  UserProfilePage({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('vehicleProfile').tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => VehicleProfileBloc(vehicle : vehicle),
                child: VehicleProfileForm(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: AppBottomAppBar(),
    );
  }
}
