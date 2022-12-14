import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/commons/formz.dart';
import 'package:app/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceAssociation extends StatelessWidget {
  const DeviceAssociation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddVehicleBloc, AddVehicleState>(
      listener: deviceAssociationListenner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Device Association",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          _SerialNumberInput(),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'In order to proceed, please enter the last 5 digits of the device serial number and click "Submit". A verification code will be sent to',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.normal, fontSize: 13.0),
          ),
          Row(
            children: [
              BlocBuilder<AddVehicleBloc, AddVehicleState>(
                builder: (context, state) {
                  return Text(
                    state.verificationEmail.value,
                    style: TextStyle(color: Colors.blue, fontSize: 13.0),
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {
                  context.read<AddVehicleBloc>().add(ChangeEmailorPhone());
                },
                child: Text(
                  "Change",
                  style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 13.0),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(1.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDeviceSize.height * 0.2,
          ),
          _SubmitDeviceAssociation(),
          SizedBox(
            height: kDeviceSize.height * 0.02,
          ),
          _SkipDeviceAssociation()
        ],
      ),
    );
  }

  void deviceAssociationListenner(
    BuildContext context,
    AddVehicleState state,
  ) {}
}

class _SerialNumberInput extends StatelessWidget {
  const _SerialNumberInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Device SerialNumber",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: state.deviceSerialNumber.value,
              onChanged: (value) {
                return context
                    .read<AddVehicleBloc>()
                    .add(SerialNumberChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: "Enter device serial number",
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SkipDeviceAssociation extends StatelessWidget {
  const _SkipDeviceAssociation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          side: MaterialStateProperty.all(
              BorderSide(color: kAppPrimaryColor, width: 2.0)),
        ),
        onPressed: () {
          context.read<AddVehicleBloc>().add(SkipDeviceAssociation());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Associate device later',
              style: TextStyle(color: kAppPrimaryColor),
            ),
            SizedBox(
              width: kDeviceSize.width * 0.05,
            ),
            Icon(
              Icons.arrow_forward,
              color: kAppPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class _SubmitDeviceAssociation extends StatelessWidget {
  const _SubmitDeviceAssociation({
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
                  onPressed: state.serialInputForm.isValid
                      ? () {
                          context
                              .read<AddVehicleBloc>()
                              .add(SubmitDeviceAssociation());
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Submit'),
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
