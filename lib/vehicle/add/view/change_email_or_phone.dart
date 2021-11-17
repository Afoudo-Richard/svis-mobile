import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeEmailOrPhone extends StatelessWidget {
  const ChangeEmailOrPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddVehicleBloc, AddVehicleState>(
      listener: changeEmailListenner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change email or phone number",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDeviceSize.height * 0.02),
          _EmailOrPhoneInput(),
          SizedBox(height: kDeviceSize.height * 0.2),
          Text(
            'Submit your email or phone number to recieve a verification code for your device.',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 13.0,
                color: kAppPrimaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kDeviceSize.height * 0.01),
          _SubmitButton(),
        ],
      ),
    );
  }

  void changeEmailListenner(BuildContext context, AddVehicleState state) {}
}

class _EmailOrPhoneInput extends StatelessWidget {
  const _EmailOrPhoneInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVehicleBloc, AddVehicleState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email/Phone number*",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: "Enter email or phone number*",
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: () {
          context.read<AddVehicleBloc>().add(ChangeSubmitedEmailOrPhone());
        },
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
  }
}
