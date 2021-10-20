import 'package:app/app.dart';
import 'package:app/user_profile/bloc/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactInformationFormSection extends StatelessWidget {
  const ContactInformationFormSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'contactInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _EmailInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _PhoneNumberInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _AddressLine1Input(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _AddressLine2Input(),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(
              child: _CityInput(),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _StateInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.01),
        _CountryOfRegistrationInput(),
        // SizedBox(height: kDeviceSize.height * 0.01),
        // _RegionInput(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_emailInput_textField'),
              initialValue: state.email.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(EmailChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.email'.tr(),
                errorText: state.editable && state.email.invalid
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

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.phoneNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_phoneNumberInput_textField'),
              initialValue: state.phoneNumber.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<UserProfileBloc>()
                  .add(PhoneNumberChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.phoneNumber'.tr(),
                errorText: state.editable && state.phoneNumber.invalid
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

class _AddressLine1Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_addressLine1Input_textField'),
              initialValue: state.addressLine1.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<UserProfileBloc>()
                  .add(AddressLine1Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine1'.tr(),
                errorText: state.editable && state.addressLine1.invalid
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

class _AddressLine2Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine2',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_addressLine2Input_textField'),
              initialValue: state.addressLine2.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<UserProfileBloc>()
                  .add(AddressLine2Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine2'.tr(),
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

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.city',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_cityInput_textField'),
              initialValue: state.city.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(CityChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.city'.tr(),
                errorText: state.editable && state.city.invalid
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

class _StateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.state',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_stateInput_textField'),
              initialValue: state.state.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(StateChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.state'.tr(),
                errorText: state.editable && state.state.invalid
                    ? 'invalid state'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CountryOfRegistrationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return TextFormField(
          key:
              const Key('userProfileForm_countryOfRegistrationInput_textField'),
          initialValue: state.countryOfRegistration.value,
          enabled: state.editable,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) => context
              .read<UserProfileBloc>()
              .add(CountryOfRegistrationChanged(value)),
          decoration: InputDecoration(
            hintText: 'forms.countryOfRegistration'.tr(),
            labelText: 'forms.countryOfRegistration'.tr(),
            errorText: state.editable && state.countryOfRegistration.invalid
                ? 'invalid country Of Registration'
                : null,
          ),
        );
      },
    );
  }
}
/* 
class _RegionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('userProfileForm_regionInput_textField'),
          initialValue: state.region.value,
          enabled: state.editable,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) =>
              context.read<UserProfileBloc>().add(RegionChanged(value)),
          decoration: InputDecoration(
            hintText: 'forms.region'.tr(),
            labelText: 'forms.region'.tr(),
            errorText: state.editable && state.region.invalid
                ? 'invalid region'
                : null,
          ),
        );
      },
    );
  }
}
 */