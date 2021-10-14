import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
        SizedBox(height: kDeviceSize.height * 0.01),
        _RegionInput(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_emailInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.email'.tr(),
            // errorText: state.firstName.invalid ? 'invalid first Name' : null,
          ),
        ),
      ],
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.phoneNumber',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_phoneNumberInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.phoneNumber'.tr(),
            // errorText: state.firstName.invalid ? 'invalid first Name' : null,
          ),
        ),
      ],
    );
  }
}

class _AddressLine1Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.addressLine1',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_addressLine1Input_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.addressLine1'.tr(),
            // errorText: state.firstName.invalid ? 'invalid first Name' : null,
          ),
        ),
      ],
    );
  }
}

class _AddressLine2Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.addressLine2',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_addressLine2Input_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.addressLine2'.tr(),
            // errorText: state.firstName.invalid ? 'invalid first Name' : null,
          ),
        ),
      ],
    );
  }
}

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.city',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_cityInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.city'.tr(),
            // errorText: state.firstName.invalid ? 'invalid first Name' : null,
          ),
        ),
      ],
    );
  }
}

class _StateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forms.state',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        TextField(
          key: const Key('userProfileForm_stateInput_textField'),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'forms.state'.tr(),
            // errorText: state.state.invalid ? 'invalid state' : null,
          ),
        ),
      ],
    );
  }
}

class _CountryOfRegistrationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('userProfileForm_countryOfRegistrationInput_textField'),
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: 'forms.countryOfRegistration'.tr(),
        labelText: 'forms.countryOfRegistration'.tr(),
        // errorText: state.countryOfRegistration.invalid ? 'invalid country Of Registration' : null,
      ),
    );
  }
}

class _RegionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('userProfileForm_regionInput_textField'),
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: 'forms.region'.tr(),
        labelText: 'forms.region'.tr(),
        // errorText: state.region.invalid ? 'invalid region' : null,
      ),
    );
  }
}
