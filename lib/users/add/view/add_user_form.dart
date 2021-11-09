import 'dart:io';

import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/country/countries.dart';
import 'package:app/commons/country/country.dart';
import 'package:app/users/add/bloc/add_user_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:collection/collection.dart';
import 'package:timezone/timezone.dart' as tz;

part 'user_information_form_section.dart';

class AddUserForm extends StatelessWidget {
  const AddUserForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserBloc, AddUserState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submission Failure')),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Your Submission has been Saved')),
            );
          Navigator.pop(context, state);
        }
      },
      child: Column(
        children: [
          SizedBox(height: kDeviceSize.height * 0.01),
          _ProfileImagePicker(),
          SizedBox(height: kDeviceSize.height * 0.03),
          _UsersInformtion(),
          SizedBox(height: kDeviceSize.height * 0.06),
          _SubmitButton(),
          SizedBox(height: kDeviceSize.height * 0.1),
        ],
      ),
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  const _ProfileImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                        context.read<AddUserBloc>().add(
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
                        context.read<AddUserBloc>().add(
                              ProfileChanged(null),
                            );
                      },
                    ),
                  )
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

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Center(
                child: const CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context.read<AddUserBloc>().add(FormSubmitted());
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('addUser').tr(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
