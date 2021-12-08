part of 'device_association_page.dart';

class ChangeEmailOrPhone extends StatelessWidget {
  const ChangeEmailOrPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceAssociationBloc, DeviceAssociationState>(
      listener: changeEmailListenner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'changeEmailOrPhone.title',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ).tr(),
          SizedBox(height: kDeviceSize.height * 0.02),
          _EmailOrPhoneInput(),
          SizedBox(height: kDeviceSize.height * 0.2),
          Text(
            'changeEmailOrPhone.prompt',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.0,
                  color: kAppPrimaryColor,
                ),
            textAlign: TextAlign.center,
          ).tr(),
          SizedBox(height: kDeviceSize.height * 0.01),
          _SubmitButtonEmail(),
        ],
      ),
    );
  }

  void changeEmailListenner(
      BuildContext context, DeviceAssociationState state) {}
}

class _EmailOrPhoneInput extends StatelessWidget {
  const _EmailOrPhoneInput({
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
              "Email/Phone number*",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: state.verificationEmail.value,
              onChanged: (value) {
                return context
                    .read<DeviceAssociationBloc>()
                    .add(VerificationEmailChanged(value));
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

class _SubmitButtonEmail extends StatelessWidget {
  const _SubmitButtonEmail({
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
          context
              .read<DeviceAssociationBloc>()
              .add(ChangeSubmitedEmailOrPhone());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('proceed').tr(),
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
