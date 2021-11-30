import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/widgets/widgets.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/vehicle/device_association/device_association.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';

part 'change_email_or_phone.dart';
part 'device_association.dart';
part 'device_verification.dart';

class DeviceAssociationPage extends StatelessWidget {
  final Vehicle vehicle;

  const DeviceAssociationPage({Key? key, required this.vehicle})
      : super(key: key);

  static Route route({required Vehicle vehicle}) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return DeviceAssociationPage(
          vehicle: vehicle,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Text('deviceAssociationForVehicle'.tr(args: [vehicle.name ?? ''])),
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
                      return DeviceAssociationBloc(
                        vehicle: vehicle,
                        email: state.user?.email,
                      );
                    },
                    child: BlocListener<DeviceAssociationBloc,
                        DeviceAssociationState>(
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
                      child: BlocBuilder<DeviceAssociationBloc,
                              DeviceAssociationState>(
                          builder: (context, pagestate) {
                        switch (pagestate.pagestatus) {
                          case DeviceAssociationPageStatus.changeEmailOrPhone:
                            return ChangeEmailOrPhone();
                          case DeviceAssociationPageStatus.deviceVerification:
                            return DeviceVerification();
                          case DeviceAssociationPageStatus.initial:
                            return DeviceAssociation();
                          default:
                            return DeviceAssociation();
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
