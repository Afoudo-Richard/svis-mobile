part of 'device_association_page.dart';

class DeviceVerification extends StatelessWidget {
  const DeviceVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceAssociationBloc, DeviceAssociationState>(
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
          _ResendVerificationCode(),
          SizedBox(height: kDeviceSize.height * 0.01),
          _SubmitButtonDeviceVerification(),
        ],
      ),
    );
  }

  void deviceVerificationListenner(
      BuildContext context, DeviceAssociationState state) {}
}

class _ResendVerificationCode extends StatelessWidget {
  const _ResendVerificationCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceAssociationBloc, DeviceAssociationState>(
      builder: (context, state) {
        return Align(
          child: TextButton(
            onPressed: state.status.isSubmissionInProgress
                ? null
                : () {
                    context
                        .read<DeviceAssociationBloc>()
                        .add(ResendVerificationCode());
                  },
            child: Text(
              'resendVerificationCode',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.0,
                  color: kAppPrimaryColor),
              textAlign: TextAlign.center,
            ).tr(),
          ),
        );
      },
    );
  }
}

class _VerificationCodeInput extends StatelessWidget {
  const _VerificationCodeInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceAssociationBloc, DeviceAssociationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "verificationPinCode",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              onChanged: (value) {
                return context
                    .read<DeviceAssociationBloc>()
                    .add(VerificationPinChanged(value));
              },
              decoration: InputDecoration(
                // enabled: state.editable,
                hintText: "enterPinCode",
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SubmitButtonDeviceVerification extends StatelessWidget {
  const _SubmitButtonDeviceVerification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceAssociationBloc, DeviceAssociationState>(
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
                  onPressed: state.verificationPinInputForm.isValid
                      ? () {
                          context
                              .read<DeviceAssociationBloc>()
                              .add(SubmitVerificationCode());
                        }
                      : null,
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
      },
    );
  }
}
