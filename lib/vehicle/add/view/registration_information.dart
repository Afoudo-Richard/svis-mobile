import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/country/countries.dart';
import 'package:app/commons/country/country.dart';
import 'package:app/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:collection/collection.dart';

class RegistrationInformation extends StatelessWidget {
  RegistrationInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  context.read<AddVehicleBloc>().add(SkipDeviceAssociation());
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('vehicleInformation').tr(),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kAppAccent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('registrationInformation').tr(),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kAppAccent,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.02),
        Text(
          'registrationInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _CountryInput(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _RegionInput(),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _RegistrationIdInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _LicenceNumberInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _RegistrationDateInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _ExpiryDateInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        _BearerNameInput(),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _PhoneNumberInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _EmailAddressInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _AddressLine1Input(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _AddressLine2Input(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.08),
        _SubmitButton(),
        SizedBox(height: kDeviceSize.height * 0.1),
      ],
    );
  }
}

class _CountryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.country != current.country,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.coutry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            DropdownSearch<Country>(
              mode: Mode.BOTTOM_SHEET,
              items: countryList,
              dropdownSearchDecoration: InputDecoration(),
              popupTitle: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                ),
                child: Text(
                  'Select a Country',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              maxHeight: kDeviceSize.height * 0.8,
              compareFn: (i, s) => i?.isoCode == s?.isoCode,
              onChanged: (value) => context
                  .read<AddVehicleBloc>()
                  .add(CountryChanged(value?.name ?? 'n/a')),
              dropdownBuilder: customSelectedItem,
              popupItemBuilder: customPopupItemBuilder,
              clearButtonSplashRadius: 20,
              selectedItem: countryList.firstWhereOrNull(
                (element) => element.name == state.country.value,
              ),
            ),
            /* TextFormField(
              initialValue: state.country.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(CountryChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.coutry'.tr(),
                errorText: state.country.invalid ? 'invalid coutry' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _RegionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.region != current.region,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.region',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.region.value,
              onChanged: (value) {
                return context.read<AddVehicleBloc>().add(RegionChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.region'.tr(),
                errorText: state.region.invalid ? 'invalid region' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RegistrationIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.registrationId != current.registrationId,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.registrationId',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.registrationId.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(RegistrationIdChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.registrationId'.tr(),
                errorText: state.registrationId.invalid
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

class _LicenceNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.licenceNumber != current.licenceNumber,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.licenseNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.licenceNumber.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(LicenceNumberChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.licenseNumber'.tr(),
                errorText: state.licenceNumber.invalid
                    ? 'invalid license Number'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RegistrationDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.registrationDate != current.registrationDate,
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
              initialValue: state.registrationDate.value?.toIso8601String(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              enabled: state.editable,
              onChanged: (value) {
                context.read<AddVehicleBloc>().add(
                      RegistrationDateChanged(
                        DateFormat('yyyy-MM-dd').parse(value),
                      ),
                    );
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.registrationDate'.tr(),
                errorText: state.editable && state.registrationDate.invalid
                    ? 'invalid registration date'
                    : null,
              ),
            ),
            /* TextFormField(
              initialValue: state.registrationDate.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(RegistrationDateChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.registrationDate'.tr(),
                errorText: state.registrationDate.invalid
                    ? 'invalid registration date'
                    : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _ExpiryDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.expiryDate != current.expiryDate,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.expiryDate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialValue: state.expiryDate.value?.toIso8601String(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              enabled: state.editable,
              onChanged: (value) {
                context.read<AddVehicleBloc>().add(
                      ExpiryDateChanged(
                        DateFormat('yyyy-MM-dd').parse(value),
                      ),
                    );
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.expiryDate'.tr(),
                errorText: state.editable && state.expiryDate.invalid
                    ? 'invalid expiry date'
                    : null,
              ),
            ),
            /* TextFormField(
              initialValue: state.expiryDate.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(ExpiryDateChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.expiryDate'.tr(),
                errorText:
                    state.expiryDate.invalid ? 'invalid expiry date' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _BearerNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.bearerName != current.bearerName,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.bearerName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.bearerName.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(BearerNameChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.bearerName'.tr(),
                errorText:
                    state.bearerName.invalid ? 'invalid bearer name' : null,
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
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.phoneNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.phoneNumber.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(PhoneNumberChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.phoneNumber'.tr(),
                errorText:
                    state.phoneNumber.invalid ? 'invalid phone number' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmailAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.email.value,
              onChanged: (value) {
                return context.read<AddVehicleBloc>().add(EmailChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.email'.tr(),
                errorText: state.email.invalid ? 'invalid email' : null,
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
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.addressLine1 != current.addressLine1,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.addressLine1.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(AddressLine1Changed(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.addressLine1'.tr(),
                errorText: state.addressLine1.invalid
                    ? 'invalid address Line 1'
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
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.addressLine2 != current.addressLine2,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine2',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.addressLine2.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(AddressLine2Changed(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.addressLine2'.tr(),
                errorText: state.addressLine2.invalid
                    ? 'invalid address Line 2'
                    : null,
              ),
            ),
          ],
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
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
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
                          context
                              .read<AddVehicleBloc>()
                              .add(SubmitRegistrationInformation());
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('submit').tr(),
                      SizedBox(
                        width: kDeviceSize.width * 0.05,
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              );
      },
    );
  }
}
