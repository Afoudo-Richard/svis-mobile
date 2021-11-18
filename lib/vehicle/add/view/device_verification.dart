import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class DeviceVerification extends StatelessWidget {
  const DeviceVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddVehicleBloc, AddVehicleState>(
      listener: deviceVerificationListenner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'deviceVerification',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ).tr(),
          SizedBox(height: kDeviceSize.height * 0.02),
          _VerificationCodeInput(),
          SizedBox(height: kDeviceSize.height * 0.2),
          Align(
            child: Text(
              'resendVerificationCode',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.0,
                  color: kAppPrimaryColor),
              textAlign: TextAlign.center,
            ).tr(),
          ),
          SizedBox(height: kDeviceSize.height * 0.01),
          _SubmitButton(),
        ],
      ),
    );
  }

  void deviceVerificationListenner(
      BuildContext context, AddVehicleState state) {}
}

class _VerificationCodeInput extends StatelessWidget {
  const _VerificationCodeInput({
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
            TextFormField(
              onChanged: (value) {
              /*   return context
                    .read<AddVehicleBloc>()
                    .add(VerificationEmailChanged(value)); */
              },
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
          context.read<AddVehicleBloc>().add(SubmitVerificationCode());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('verify').tr(),
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
