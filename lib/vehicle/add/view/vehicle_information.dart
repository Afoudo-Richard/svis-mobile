import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/repository/models/make.dart';
import 'package:app/repository/models/model_year.dart';
import 'package:app/vehicle/add/add.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class VehicleInformation extends StatelessWidget {
  VehicleInformation({Key? key}) : super(key: key);

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
            Expanded(
              child: InkWell(
                onTap: () {
                  context
                      .read<AddVehicleBloc>()
                      .add(SubmitVehicleInformation());
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('registrationInformation').tr(),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.02),
        Text(
          'vehicleInformation',
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _VehicleNameInput(),
        SizedBox(height: kDeviceSize.height * 0.015),
        _IdentificationInput(),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _MakeInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _ModelInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _BodyTypeInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _YearInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _TransmissionInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _FuelTypeInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _VehicleGroupInput(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MileageInput(),
            ),
          ],
        ),
        SizedBox(height: kDeviceSize.height * 0.015),
        _ImageUploadInput(),
        SizedBox(height: kDeviceSize.height * 0.1),
        _SubmitButton(),
        SizedBox(height: kDeviceSize.height * 0.1),
      ],
    );
  }
}

class _VehicleNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.vehicleName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.name.value,
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(VehicleNameChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.vehicleName'.tr(),
                errorText: state.name.invalid ? 'invalid name' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _IdentificationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.vin != current.vin,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.vin',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.vin.value,
              onChanged: (value) {
                return context.read<AddVehicleBloc>().add(VinChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.vin'.tr(),
                errorText: state.vin.invalid ? 'invalid name' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MakeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.make != current.make,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.make',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            Autocomplete<Manufacturer>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return manufacturers.where((Manufacturer option) {
                  return option.manufacturer
                          ?.toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()) ??
                      false;
                });
              },
              initialValue: TextEditingValue(text: state.bodyType.value),
              onSelected: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(MakeChanged(value.manufacturer ?? ''));
              },
              fieldViewBuilder: (
                BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return TextFormField(
                  onChanged: (value) {
                    return context
                        .read<AddVehicleBloc>()
                        .add(MakeChanged(value));
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    enabled: state.editable,
                    hintText: 'forms.make'.tr(),
                    errorText: state.bodyType.invalid ? 'invalid make' : null,
                  ),
                );
              },
            ),

            /* TextFormField(
              initialValue: state.make.value,
              onChanged: (value) {
                return context.read<AddVehicleBloc>().add(MakeChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.make'.tr(),
                errorText: state.make.invalid ? 'invalid name' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _ModelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      // buildWhen: (previous, current) => previous.model != current.model,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.model',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                var make = manufacturers.firstWhereOrNull(
                    (element) => element.manufacturer == state.make.value);
                return make?.model?.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    }) ??
                    [];
              },
              initialValue: TextEditingValue(text: state.bodyType.value),
              onSelected: (value) {
                return context.read<AddVehicleBloc>().add(ModelChanged(value));
              },
              fieldViewBuilder: (
                BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return TextFormField(
                  onChanged: (value) {
                    return context
                        .read<AddVehicleBloc>()
                        .add(ModelChanged(value));
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    enabled: state.editable,
                    hintText: 'forms.model'.tr(),
                    errorText: state.model.invalid ? 'invalid model' : null,
                  ),
                );
              },
            ),

            /* TextFormField(
              initialValue: state.model.value,
              onChanged: (value) {
                return context.read<AddVehicleBloc>().add(ModelChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.model'.tr(),
                errorText: state.model.invalid ? 'invalid model' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _BodyTypeInput extends StatelessWidget {
  static const List<String> _kOptions = <String>[
    'Hatchback',
    'Sedan',
    'MUV/SUV',
    'Coupe',
    'Convertible',
    'Wagon',
    'Van',
    'Jeep'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.bodyType != current.bodyType,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.bodyType',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return _kOptions.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              initialValue: TextEditingValue(text: state.bodyType.value),
              onSelected: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(BodyTypeChanged(value));
              },
              fieldViewBuilder: (
                BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return TextFormField(
                  onChanged: (value) {
                    return context
                        .read<AddVehicleBloc>()
                        .add(BodyTypeChanged(value));
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    enabled: state.editable,
                    hintText: 'forms.bodyType'.tr(),
                    errorText:
                        state.bodyType.invalid ? 'invalid body type' : null,
                  ),
                );
              },
            ),

            /* TextFormField(
              initialValue: state.bodyType.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(BodyTypeChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.bodyType'.tr(),
                errorText: state.bodyType.invalid ? 'invalid body type' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _YearInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      // buildWhen: (previous, current) => previous.year != current.year,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.year',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            Autocomplete<ModelYear>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return modelYear
                    .where((element) => element.model == state.model.value)
                    .where((ModelYear option) {
                  return option.year
                          ?.contains(textEditingValue.text.toLowerCase()) ??
                      false;
                });
              },
              initialValue: TextEditingValue(text: state.transmission.value),
              onSelected: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(YearChanged(value.year ?? ''));
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  onChanged: (value) {
                    return context
                        .read<AddVehicleBloc>()
                        .add(YearChanged(value));
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    enabled: state.editable,
                    hintText: 'forms.year'.tr(),
                    errorText: state.year.invalid ? 'invalid year' : null,
                  ),
                );
              },
            ),
            /* TextFormField(
              initialValue: state.year.value,
              onChanged: (value) {
                return context.read<AddVehicleBloc>().add(YearChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.year'.tr(),
                errorText: state.year.invalid ? 'invalid year' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _TransmissionInput extends StatelessWidget {
  static const List<String> _kOptions = <String>[
    'Traditional Automatic Transmission',
    'Automated-Manual Transmission',
    'Continuously Variable Transmission (CVT)',
    'Dual-Clutch Transmission (DCT)',
    'DSG (Direct Shift Gearbox)',
    'Tiptronic Transmission'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.transmission != current.transmission,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.transmission',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return _kOptions.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              initialValue: TextEditingValue(text: state.transmission.value),
              onSelected: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(TransmissionChanged(value));
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  onChanged: (value) {
                    return context
                        .read<AddVehicleBloc>()
                        .add(TransmissionChanged(value));
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    enabled: state.editable,
                    hintText: 'forms.transmission'.tr(),
                    errorText: state.transmission.invalid
                        ? 'invalid transmission'
                        : null,
                  ),
                );
              },
            ),
            /*  TextFormField(
              initialValue: state.transmission.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(TransmissionChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.transmission'.tr(),
                errorText:
                    state.transmission.invalid ? 'invalid transmission' : null,
              ),
            ), */
          ],
        );
      },
    );
  }
}

class _FuelTypeInput extends StatelessWidget {
  static const List<String> _kOptions = <String>[
    'Electric',
    'Hybrid',
    'Petrol',
    'Gas',
    'Diesel'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.fuelType != current.fuelType,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.fuelType',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return _kOptions.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              initialValue: TextEditingValue(text: state.fuelType.value),
              onSelected: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(FuelTypeChanged(value));
              },
              fieldViewBuilder: (
                BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return TextFormField(
                  onChanged: (value) {
                    return context
                        .read<AddVehicleBloc>()
                        .add(FuelTypeChanged(value));
                  },
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _VehicleGroupInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) =>
          previous.vehicleGroup != current.vehicleGroup,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.vehicleGroup',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.vehicleGroup.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(VehicleGroupChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.vehicleGroup'.tr(),
                errorText:
                    state.vehicleGroup.invalid ? 'invalid vehicle Group' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MileageInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.mileage != current.mileage,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.mileage',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.mileage.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(MileageChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.mileage'.tr(),
                errorText: state.mileage.invalid ? 'invalid mileage' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ImageUploadInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.imageUpload',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.image.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(ImageUploadChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.imageUpload'.tr(),
                errorText: state.image.invalid ? 'invalid imageUpload' : null,
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
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () {
              context.read<AddVehicleBloc>().add(SubmitVehicleInformation());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('registrationInformation').tr(),
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
