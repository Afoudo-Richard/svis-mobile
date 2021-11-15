import 'package:app/authentication/authentication.dart';
import 'package:app/users/add/view/add_user_form.dart';
import 'package:app/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:app/vehicle/add/view/pages/change_email_or_phone.dart';
import 'package:app/vehicle/add/view/pages/device_association.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class AddVehiclePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddVehiclePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addVehicle').tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => AddVehicleBloc(profile: state.profile),
                child: BlocBuilder<AddVehicleBloc, AddVehicleState>(
                    builder: (context, pagestate) {
                  switch (pagestate.pagestatus) {
                    case SwitchPageStatus.changeEmailOrPhone:
                      return ChangeEmailOrPhone();
                    default:
                      return DeviceAssociation();
                  }
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
