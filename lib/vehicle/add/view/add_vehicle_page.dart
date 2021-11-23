import 'package:app/authentication/authentication.dart';
import 'package:app/vehicle/add/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';

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
                create: (context) => AddVehicleBloc(
                  profile: state.profile,
                  email: state.user?.email,
                ),
                child: BlocListener<AddVehicleBloc, AddVehicleState>(
                  listener: (context, state) {
                    if (state.status.isSubmissionFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                state.submission.error ?? 'Submission Failure'),
                          ),
                        );
                    } else if (state.status.isSubmissionSuccess) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                              content: Text('Your Submission has been Saved')),
                        );
                      Navigator.pop(context, state);
                    }
                  },
                  child: BlocBuilder<AddVehicleBloc, AddVehicleState>(
                      builder: (context, pagestate) {
                    switch (pagestate.pagestatus) {
                      case SwitchPageStatus.changeEmailOrPhone:
                        return ChangeEmailOrPhone();
                      case SwitchPageStatus.deviceVerification:
                        return DeviceVerification();
                      case SwitchPageStatus.vehicleInformation:
                        return VehicleInformation();
                      case SwitchPageStatus.registrationInformation:
                        return RegistrationInformation();
                      case SwitchPageStatus.initial:
                        return DeviceAssociation();
                      default:
                        return DeviceAssociation();
                    }
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
