import 'dart:io';

import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/commons/colors.dart';
import 'package:app/password_update/view/view.dart';
import 'package:app/terminate_account/view/view.dart';
import 'package:app/vehicle/detail/view/vehicle_dashboard_page.dart';
import 'package:app/vehicle_profile/bloc/vehicle_profile_bloc.dart';
import 'package:app/vehicle_profile/view/registration_information_form.dart';
import 'package:app/vehicle_profile/view/vehicle_information_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';

class VehicleProfileForm extends StatelessWidget {
  const VehicleProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: kDeviceSize.height * 0.02),
        BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
          builder: (context, state) {
            if (state.editable) {
              return _ProfileImagePicker();
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: kAppAccent,
                      radius: 38,
                      backgroundImage: NetworkImage(state.vehicle?.photo?.url ??
                          'https://sumelongenterprise.com/sites/default/files/logo_0.png'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.vehicle?.manufacturer ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 4.0, right: 2.0),
                              height: 10.0,
                              width: 10.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: true ? Colors.blue : Colors.red,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  true ? "Active" : "Inactive",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        VehicleDashboardPage.route(
                                            state.vehicle));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "viewDashboard",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<VehicleProfileBloc>().add(EditableChanged());
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              );
            }
          },
        ),
        SizedBox(height: kDeviceSize.height * 0.02),
        VehicleInformation(),
        SizedBox(height: kDeviceSize.height * 0.03),
        RegistrationInformationFormSection(),
        SizedBox(height: kDeviceSize.height * 0.05),
        BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
          builder: (context, state) {
            if (state.editable) {
              return state.status.isSubmissionInProgress
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDeviceSize.width * 0.1),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: state.status.isValidated
                            ? () {
                                context
                                    .read<VehicleProfileBloc>()
                                    .add(FormSubmitted());
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('updateProfile').tr(),
                          ],
                        ),
                      ),
                    );
            } else {
              return Column(children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "assigned",
                  ).tr(),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("registrationDocuments").tr(),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("svisCapabilityService").tr(),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                Divider(),
              ]);
            }
          },
        ),
        SizedBox(height: kDeviceSize.height * 0.03),
      ],
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  const _ProfileImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.image);

                      if (result != null) {
                        File file = File(result.files.single.path ?? '');
                        context.read<VehicleProfileBloc>().add(
                              ProfileChanged(file),
                            );
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: CircleAvatar(
                      radius: 40,
                      child: CircleAvatar(
                        backgroundColor: kAppAccent,
                        backgroundImage: (state.profile.value != null)
                            ? FileImage(state.profile.value as File)
                            : null,
                        radius: 38,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      child: Icon(Icons.cancel_rounded),
                      onTap: () {
                        context.read<VehicleProfileBloc>().add(
                              ProfileChanged(null),
                            );
                      },
                    ),
                  ),
                ],
              ),
              Text('Change image'),
            ],
          ),
        );
      },
    );
  }
}
