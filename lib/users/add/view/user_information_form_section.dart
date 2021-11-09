part of 'add_user_form.dart';

class _UsersInformtion extends StatelessWidget {
  const _UsersInformtion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'usersInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _FirstNameInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
        _LastNameInput(),
        SizedBox(height: kDeviceSize.height * 0.01),
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
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                  context.read<AddUserBloc>().add(FirstNameChanged(value)),
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
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                  context.read<AddUserBloc>().add(LastNameChanged(value)),
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
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                context.read<AddUserBloc>().add(
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
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                  context.read<AddUserBloc>().add(GenderChanged(value)),
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
    return BlocBuilder<AddUserBloc, AddUserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.timeZone',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            DropdownSearch<tz.Location>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItems: true,
              items: tz.timeZoneDatabase.locations.values.toList(),
              compareFn: (item, selectedItem) {
                return item?.name == selectedItem?.name;
              },
              dropdownSearchDecoration: InputDecoration(
                labelText: "Select a timezone",
              ),
              popupTitle: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                ),
                child: Text(
                  'Select a timezone',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              maxHeight: kDeviceSize.height * 0.8,
              onChanged: print,
              selectedItem: tz.getLocation(state.timeZone.value),
            )
            /* TextFormField(
              key: const Key('userProfileForm_timeZoneInput_textField'),
              initialValue: state.timeZone.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<AddUserBloc>().add(TimeZoneChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.timeZone'.tr(),
                errorText: state.editable && state.timeZone.invalid
                    ? 'invalid time Zone'
                    : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
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
              onChanged: (value) =>
                  context.read<AddUserBloc>().add(EmailChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.email'.tr(),
                errorText: state.editable && state.email.invalid
                    ? 'invalid e mail'
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
    return BlocBuilder<AddUserBloc, AddUserState>(
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
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  context.read<AddUserBloc>().add(PhoneNumberChanged(value)),
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

class _AddressLine1Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.addressLine1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('userProfileForm_addressLine1Input_textField'),
              initialValue: state.addressLine1.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<AddUserBloc>().add(AddressLine1Changed(value)),
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

class _AddressLine2Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
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
              onChanged: (value) =>
                  context.read<AddUserBloc>().add(AddressLine2Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine2'.tr(),
                errorText: state.editable && state.firstName.invalid
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

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                  context.read<AddUserBloc>().add(CityChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.city'.tr(),
                errorText: state.editable && state.city.invalid
                    ? 'invalid city'
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
    return BlocBuilder<AddUserBloc, AddUserState>(
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
                  context.read<AddUserBloc>().add(StateChanged(value)),
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
  Widget _customSelectedItem(BuildContext context, Country? item) {
    return Container(
      child: (item == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("No item selected"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Image.asset(
                'assets/countries/flags/${item.isoCode.toLowerCase()}.png',
                width: 40,
                height: 40,
              ),
              title: Text(item.name),
              subtitle: Text(item.phoneCode),
            ),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, Country? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.phoneCode ?? ''),
        leading: Image.asset(
          'assets/countries/flags/${item?.isoCode.toLowerCase()}.png',
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  Future<List<Country>> filterData(String? filter) async {
    return filter != null
        ? countryList.where((element) {
            return element.name.toLowerCase().contains(filter.toLowerCase());
          }).toList()
        : countryList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(
      builder: (context, state) {
        return DropdownSearch<Country>(
          mode: Mode.BOTTOM_SHEET,
          items: countryList,
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select a country",
          ),
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
              .read<AddUserBloc>()
              .add(CountryOfRegistrationChanged(value?.name)),
          dropdownBuilder: _customSelectedItem,
          popupItemBuilder: _customPopupItemBuilder,
          clearButtonSplashRadius: 20,
          selectedItem: countryList.firstWhereOrNull(
            (element) => element.name == state.countryOfRegistration.value,
          ),
        );
      },
    );
  }
}
