import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.firstName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_firstNameInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.firstName'.tr(),
            // errorText: state.firstName.invalid ? 'invalid first Name' : null,
          ),
        ),
      ],
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.lastName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_lastNameInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.lastName'.tr(),
            // errorText: state.lastName.invalid ? 'invalid last Name' : null,
          ),
        ),
      ],
    );
  }
}

class _DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.dob',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_dobInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.dob'.tr(),
            // errorText: state.dob.invalid ? 'invalid username' : null,
          ),
        ),
      ],
    );
  }
}

class _GenderInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.gender',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_genderInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.gender'.tr(),
            // errorText: state.gender.invalid ? 'invalid gender' : null,
          ),
        ),
      ],
    );
  }
}

class _TimeZoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.timeZone',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_timeZoneInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.timeZone'.tr(),
            // errorText: state.timeZone.invalid ? 'invalid time Zone' : null,
          ),
        ),
      ],
    );
  }
}
