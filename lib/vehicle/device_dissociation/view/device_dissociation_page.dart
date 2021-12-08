import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/widgets/widgets.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/vehicle/device_dissociation/device_dissociation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';

part 'change_email_or_phone.dart';
part 'device_dissociation.dart';
part 'device_verification.dart';

class DeviceDissociationPage extends StatelessWidget {
  final Vehicle vehicle;

  const DeviceDissociationPage({Key? key, required this.vehicle})
      : super(key: key);

  static Route route({required Vehicle vehicle}) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return DeviceDissociationPage(
          vehicle: vehicle,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title:
          Text('deviceDissociationForVehicle'.tr(args: [vehicle.name ?? ''])),
      actions: [],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Column(
                children: [
                  BlocProvider(
                    create: (context) {
                      return DeviceDissociationBloc(
                        vehicle: vehicle,
                        email: state.user?.email,
                      )..add(FetchDeviceProperties());
                    },
                    child: BlocListener<DeviceDissociationBloc,
                        DeviceDissociationState>(
                      listener: (context, state) {
                        if (state.status.isSubmissionFailure) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.submission.error ??
                                      'Submission Failure',
                                ),
                              ),
                            );
                        } else if (state.status.isSubmissionSuccess) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Your Submission has been Saved')),
                            );
                          Navigator.of(context).pop(state.submission.success);
                        }
                      },
                      child: BlocBuilder<DeviceDissociationBloc,
                              DeviceDissociationState>(
                          builder: (context, pagestate) {
                        switch (pagestate.pagestatus) {
                          case DeviceDissociationPageStatus.changeEmailOrPhone:
                            return ChangeEmailOrPhone();
                          case DeviceDissociationPageStatus.deviceVerification:
                            return DeviceVerification();
                          case DeviceDissociationPageStatus.initial:
                            return DeviceDissociation();
                          default:
                            return DeviceDissociation();
                        }
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
