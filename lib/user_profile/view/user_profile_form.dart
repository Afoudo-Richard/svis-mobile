import 'dart:io';

import 'package:app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/commons/colors.dart';
import 'package:app/password_update/view/view.dart';
import 'package:app/terminate_account/view/view.dart';
import 'package:app/user_profile/user_profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';

class UserProfileForm extends StatelessWidget {
  const UserProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: kDeviceSize.height * 0.02),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, upState) {
                if (upState.editable) {
                  return _ProfileImagePicker();
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: kAppAccent,
                          radius: 38,
                          backgroundImage:
                              NetworkImage(state.user?.profile?.url ?? ''),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user?.fullName ?? '',
                              style: Theme.of(context).textTheme.headline5,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<UserProfileBloc>()
                                    .add(EditChanged());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('update profile'),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.edit,
                                    color: kAppAccent,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            );
          },
        ),
        SizedBox(height: kDeviceSize.height * 0.02),
        GeneralInformtion(),
        SizedBox(height: kDeviceSize.height * 0.03),
        ContactInformationFormSection(),
        SizedBox(height: kDeviceSize.height * 0.05),
        BlocBuilder<UserProfileBloc, UserProfileState>(
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
                                    .read<UserProfileBloc>()
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
              return Column(
                children: [
                  SizedBox(height: kDeviceSize.height * 0.06),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDeviceSize.width * 0.1),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PasswordUpdatePage.route());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('resetPassword').tr(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: kDeviceSize.height * 0.02),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        kDangerColor.withOpacity(0.1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(TerminateAccountPage.route());
                    },
                    child: Text(
                      'terminateAccount',
                      style: TextStyle(color: kDangerColor),
                    ).tr(),
                  ),
                ],
              );
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
    return BlocBuilder<UserProfileBloc, UserProfileState>(
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
                        context.read<UserProfileBloc>().add(
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
                        context.read<UserProfileBloc>().add(
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
