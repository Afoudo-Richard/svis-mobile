import 'dart:io';

import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/profile/profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateProfileForm extends StatelessWidget {
  const CreateProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProfileBloc, CreateProfileState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                content: Text(
                  state.submission.error ?? 'error',
                  style: TextStyle(
                    color: kDangerColor,
                  ),
                ).tr(),
                backgroundColor: kDangerColor.withOpacity(0.2),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                content: Text(
                  'success',
                  style: TextStyle(
                    color: kAppAccent,
                  ),
                ).tr(),
                backgroundColor: kAppAccent.withOpacity(0.2),
              ),
            );
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kDeviceSize.height * 0.01),
            _ProfileImagePicker(),
            SizedBox(height: kDeviceSize.height * 0.03),
            Text(
              'contactInformation',
              style: Theme.of(context).textTheme.headline6,
            ).tr(),
            SizedBox(height: kDeviceSize.height * 0.015),
            _NameInput(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _DescriptionInput(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _PhoneNumberInput(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _EmailInput(),
            SizedBox(height: kDeviceSize.height * 0.03),
            Text(
              'contactInformation',
              style: Theme.of(context).textTheme.headline6,
            ).tr(),
            _AddressLine1Input(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _AddressLine2Input(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _StreetInput(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _ZipCodeInput(),
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
            _Website(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _TaxId(),
            SizedBox(height: kDeviceSize.height * 0.01),
            _RegistrationId(),
            SizedBox(height: kDeviceSize.height * 0.06),
            _SubmitButton(),
            SizedBox(height: kDeviceSize.height * 0.1),
          ],
        ),
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
                        context.read<CreateProfileBloc>().add(
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
                        context.read<CreateProfileBloc>().add(
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
                              .read<CreateProfileBloc>()
                              .add(FormSubmitted());
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('addCompany').tr(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.companyName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.name.value,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(NameChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.companyName'.tr(),
                errorText: state.name.invalid ? 'invalid company name' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.description.value,
              textCapitalization: TextCapitalization.sentences,
              minLines: 2,
              maxLines: 10,
              onChanged: (value) => context
                  .read<CreateProfileBloc>()
                  .add(DescriptionChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.description'.tr(),
                errorText:
                    state.description.invalid ? 'invalid description' : null,
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<CreateProfileBloc>()
                  .add(PhoneNumberChanged(value)),
              decoration: InputDecoration(
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(EmailChanged(value)),
              decoration: InputDecoration(
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<CreateProfileBloc>()
                  .add(AddressLine1Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine1'.tr(),
                errorText:
                    state.addressLine1.invalid ? 'invalid address' : null,
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<CreateProfileBloc>()
                  .add(AddressLine2Changed(value)),
              decoration: InputDecoration(
                hintText: 'forms.addressLine2'.tr(),
                errorText:
                    state.addressLine2.invalid ? 'invalid address' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StreetInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.street',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.street.value,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(StreetChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.street'.tr(),
                errorText: state.street.invalid ? 'invalid street' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ZipCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.zipCode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.zipCode.value,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(ZipCodeChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.zipCode'.tr(),
                errorText: state.zipCode.invalid ? 'invalid zip Code' : null,
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(CityChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.city'.tr(),
                errorText: state.city.invalid ? 'invalid first Name' : null,
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(StateChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.state'.tr(),
                errorText: state.state.invalid ? 'invalid state' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Website extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.website',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.website.value,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(WebSiteChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.website'.tr(),
                errorText: state.website.invalid ? 'invalid website' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TaxId extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.taxId',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.taxId.value,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<CreateProfileBloc>().add(TaxIdChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.taxId'.tr(),
                errorText: state.taxId.invalid ? 'invalid website' : null,
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
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
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
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => context
                  .read<CreateProfileBloc>()
                  .add(RegistrationIdChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.registrationId'.tr(),
                errorText:
                    state.registrationId.invalid ? 'invalid website' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
