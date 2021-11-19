import 'package:app/app.dart';
import 'package:app/vehicle_profile/bloc/vehicle_profile_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleInformation extends StatelessWidget {
  const VehicleInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'vehicleInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(child: _Make(),),
            SizedBox(height: kDeviceSize.width * 0.01),
            Expanded(child: _Model()),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(child: _BodyType(),),
            Expanded(child: _Year()),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.01),
        Row(
          children: [
            Expanded(child: _Transmission(),),
            Expanded(child: _FuelType()),
          ],
        ),
      ],
    );
  }
}

class _Make extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.make',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_makeInput_textField'),
              initialValue: state.make.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(MakeChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.make'.tr(),
                errorText: state.editable && state.make.invalid
                    ? 'invalid make Name'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Model extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.model',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_modelInput_textField'),
              initialValue: state.model.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(ModelChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.model'.tr(),
                errorText: state.editable && state.model.invalid
                    ? 'invalid model Name'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BodyType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.bodyType',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_bodyTypeInput_textField'),
              initialValue: state.bodyType.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(BodyTypeChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.bodyType'.tr(),
                errorText: state.editable && state.bodyType.invalid
                    ? 'invalid body type'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Year extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.year',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_yearInput_textField'),
              initialValue: state.year.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(YearChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.year'.tr(),
                errorText: state.editable && state.year.invalid
                    ? 'invalid year'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Transmission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.transmission',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_transmissionInput_textField'),
              initialValue: state.transmission.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(TransmissionChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.transmission'.tr(),
                errorText: state.editable && state.transmission.invalid
                    ? 'invalid transmission type'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FuelType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.fuelType',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              key: const Key('vehicleProfileForm_fuelTypeInput_textField'),
              initialValue: state.fuelType.value,
              enabled: state.editable,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) =>
                  context.read<VehicleProfileBloc>().add(FuelTypeChanged(value)),
              decoration: InputDecoration(
                hintText: 'forms.fuelType'.tr(),
                errorText: state.editable && state.fuelType.invalid
                    ? 'invalid fuel type'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

// class _DateOfBirthInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'forms.dob',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ).tr(),
//             DateTimePicker(
//               type: DateTimePickerType.date,
//               initialValue: state.dateOfBirth.value?.toIso8601String(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//               enabled: state.editable,
//               onChanged: (value) {
//                 context.read<VehicleProfileBloc>().add(
//                       DateOfBirthChanged(
//                         DateFormat('yyyy-MM-dd').parse(value),
//                       ),
//                     );
//               },
//               decoration: InputDecoration(
//                 hintText: 'forms.dob'.tr(),
//                 errorText: state.editable && state.dateOfBirth.invalid
//                     ? 'invalid dob'
//                     : null,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _GenderInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'forms.gender',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ).tr(),
//             TextFormField(
//               key: const Key('userProfileForm_genderInput_textField'),
//               initialValue: state.gender.value,
//               enabled: state.editable,
//               textCapitalization: TextCapitalization.words,
//               onChanged: (value) =>
//                   context.read<VehicleProfileBloc>().add(GenderChanged(value)),
//               decoration: InputDecoration(
//                 hintText: 'forms.gender'.tr(),
//                 errorText: state.editable && state.gender.invalid
//                     ? 'invalid gender'
//                     : null,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _TimeZoneInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<VehicleProfileBloc, VehicleProfileState>(
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'forms.timeZone',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ).tr(),
//             TextFormField(
//               key: const Key('userProfileForm_timeZoneInput_textField'),
//               // initialValue: state.timeZone.value,
//               enabled: state.editable,
//               textCapitalization: TextCapitalization.words,
//               onChanged: (value) =>
//                   context.read<VehicleProfileBloc>().add(TimeZoneChanged(value)),
//               decoration: InputDecoration(
//                 hintText: 'forms.timeZone'.tr(),
//                 // errorText: state.editable && state.timeZone.invalid
//                 //     ? 'invalid time Zone'
//                 //     : null,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
