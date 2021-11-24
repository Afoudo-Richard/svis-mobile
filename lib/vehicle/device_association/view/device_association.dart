part of 'device_association_page.dart';

class DeviceAssociation extends StatelessWidget {
  const DeviceAssociation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceAssociationBloc, DeviceAssociationState>(
      listener: deviceAssociationListenner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'deviceAssociation.title',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ).tr(),
          _SerialNumberInput(),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'deviceAssociation.prompt',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.normal, fontSize: 13.0),
          ).tr(),
          Row(
            children: [
              BlocBuilder<DeviceAssociationBloc, DeviceAssociationState>(
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
                  context
                      .read<DeviceAssociationBloc>()
                      .add(ChangeEmailorPhone());
                },
                child: Text(
                  'change',
                  style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 13.0),
                ).tr(),
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
        ],
      ),
    );
  }

  void deviceAssociationListenner(
    BuildContext context,
    DeviceAssociationState state,
  ) {}
}

class _SerialNumberInput extends StatelessWidget {
  const _SerialNumberInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceAssociationBloc, DeviceAssociationState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forms.deviceSerial',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ).tr(),
            TextFormField(
              initialValue: state.deviceSerialNumber.value,
              onChanged: (value) {
                return context
                    .read<DeviceAssociationBloc>()
                    .add(SerialNumberChanged(value));
              },
              decoration: InputDecoration(
                enabled: state.editable,
                hintText: 'forms.deviceSerialPrompt',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SubmitDeviceAssociation extends StatelessWidget {
  const _SubmitDeviceAssociation({
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
                  onPressed: state.serialInputForm.isValid
                      ? () {
                          context
                              .read<DeviceAssociationBloc>()
                              .add(SubmitDeviceAssociation());
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
