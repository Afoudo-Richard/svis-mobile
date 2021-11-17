import 'package:app/app.dart';
import 'package:app/vehicle_profile/bloc/vehicle_profile_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationInformationFormSection extends StatelessWidget {
  const RegistrationInformationFormSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'registrationInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _CountryOfRegistration(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _RegionOrCity(),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(
              child: _RegistrationId(),
            ),
            SizedBox(height: kDeviceSize.width * 0.2),
            Expanded(child: _LicencePlateNumber()),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(
              child: _IssuedDate(),
            ),
            Expanded(child: _ExpiryDate()),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.01),
        _BearerName(),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(
              child: _AddressLine1(),
            ),
            Expanded(child: _AddressLine2()),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(
              child: _PhoneNumber(),
            ),
            Expanded(child: _Email()),
          ],
        ),
      ],
    );
  }
}

class _CountryOfRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.countryOfRegistration',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key(
                  'vehicleProfileForm_countryOfRegistration_textField'),
              initialValue: state.countryOfRegistration.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(CountryOfRegistrationChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.countryOfRegistration'.tr(),
                errorText: state.editable && state.countryOfRegistration.invalid
                    ? 'invalid countryOfRegistration'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RegionOrCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.regionOrCity',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_RegionOrCity_textField'),
              initialValue: state.city.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(CityChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.regionOrCity'.tr(),
                errorText: state.editable && state.city.invalid
                    ? 'invalid RegionOrCity'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RegistrationId extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.registrationId',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key:
                  const Key('vehicleProfileForm_registrationIdInput_textField'),
              initialValue: state.registrationId.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(RegistrationIdChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.registrationId'.tr(),
                errorText: state.editable && state.registrationId.invalid
                    ? 'invalid registration Id'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LicencePlateNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.licensePlateNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key(
                  'vehicleProfileForm_licensePlateNumberInput_textField'),
              initialValue: state.licencePlateNumber.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(LicencePlateNumberChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.licensePlateNumber'.tr(),
                errorText: state.editable && state.licencePlateNumber.invalid
                    ? 'invalid license plate number'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}


class _IssuedDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.registrationDate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialValue: state.issuedDate.value?.toIso8601String(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              enabled: state.editable,
              onChanged: (value) {
                context.read<VehicleProfileBloc>().add(
                      IssuedDateChanged(
                        DateFormat('yyyy-MM-dd').parse(value),
                      ),
                    );
              },
              decoration: InputDecoration(
                hintText: 'forms.issuedDate'.tr(),
                errorText: state.editable && state.issuedDate.invalid
                    ? 'invalid issued date'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ExpiryDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
            ),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialValue: state.expiredDate.value?.toIso8601String(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              enabled: state.editable,
              onChanged: (value) {
                context.read<VehicleProfileBloc>().add(
                      ExpiredDateChanged(
                        DateFormat('yyyy-MM-dd').parse(value),
                      ),
                    );
              },
              decoration: InputDecoration(
                hintText: 'forms.expiryDate'.tr(),
                errorText: state.editable && state.expiredDate.invalid
                    ? 'invalid expiry date'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}


class _BearerName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.bearName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_bearNameInput_textField'),
              initialValue: state.bearerName.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(BearerNameChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.bearName'.tr(),
                errorText: state.editable && state.bearerName.invalid
                    ? 'invalid bear name'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AddressLine1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_addressLine1Input_textField'),
              initialValue: state.addressLine1.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(AddressLine1Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine1'.tr(),
                errorText: state.editable && state.addressLine1.invalid
                    ? 'invalid address line 1'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AddressLine2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine2',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_addressLine2Input_textField'),
              initialValue: state.addressLine2.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(AddressLine2Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine2'.tr(),
                errorText: state.editable && state.addressLine2.invalid
                    ? 'invalid address line 2'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}


class _PhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.phoneNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_phoneNumberInput_textField'),
              initialValue: state.phoneNumber.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(AddressLine1Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.phoneNumber'.tr(),
                errorText: state.editable && state.phoneNumber.invalid
                    ? 'invalid phone number'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_emailInput_textField'),
              initialValue: state.email.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<VehicleProfileBloc>()
                  .add(EmailChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.email'.tr(),
                errorText: state.editable && state.email.invalid
                    ? 'invalid email'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}


