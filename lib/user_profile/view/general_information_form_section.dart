import 'package:app/app.dart';
import 'package:app/user_profile/bloc/user_profile_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralInformtion extends StatelessWidget {
  const GeneralInformtion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'generalInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _FirstNameInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _LastNameInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _DateOfBirthInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _GenderInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _TimeZoneInput(),
      ],
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.firstName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_firstNameInput_textField'),
              initialValue: state.firstName.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(FirstNameChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.firstName'.tr(),
                errorText: state.editable && state.firstName.invalid
                    ? 'invalid first Name'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.lastName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_lastNameInput_textField'),
              initialValue: state.lastName.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(LastNameChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.lastName'.tr(),
                errorText: state.editable && state.lastName.invalid
                    ? 'invalid last Name'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.dob',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialValue: state.dateOfBirth.value?.toIso8601String(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              enabled: state.editable,
              onChanged: (value) {
                context.read<UserProfileBloc>().add(
                      DateOfBirthChanged(
                        DateFormat('yyyy-MM-dd').parse(value),
                      ),
                    );
              },
              decoration: InputDecoration(
                hintText: 'forms.dob'.tr(),
                errorText: state.editable && state.dateOfBirth.invalid
                    ? 'invalid dob'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GenderInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.gender',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_genderInput_textField'),
              initialValue: state.gender.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(GenderChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.gender'.tr(),
                errorText: state.editable && state.gender.invalid
                    ? 'invalid gender'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TimeZoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.timeZone',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_timeZoneInput_textField'),
              // initialValue: state.timeZone.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(TimeZoneChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.timeZone'.tr(),
                // errorText: state.editable && state.timeZone.invalid
                //     ? 'invalid time Zone'
                //     : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
