part of 'device_dissociation_page.dart';

class DeviceDissociation extends StatelessWidget {
  const DeviceDissociation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'deviceDissociation.title',
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
          'deviceDissociation.prompt',
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(fontWeight: FontWeight.normal, fontSize: 13.0),
        ).tr(),
        Row(
          children: [
            BlocBuilder<DeviceDissociationBloc, DeviceDissociationState>(
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
                    .read<DeviceDissociationBloc>()
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
        _SubmitDeviceDissociation(),
      ],
    );
  }
}

class _SerialNumberInput extends StatelessWidget {
  const _SerialNumberInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceDissociationBloc, DeviceDissociationState>(
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
                    .read<DeviceDissociationBloc>()
                    .add(SerialNumberChanged(value));
              },
              decoration: InputDecoration(
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Builder(builder: (context) {
                    var prefix = state.device?.serialNumber;
                    if (prefix != null && prefix.length >= 5) {
                      prefix = prefix.substring(0, prefix.length - 5);
                    }
                    return Text(prefix ?? 'error');
                  }),
                ),
                enabled: state.editable,
                hintText: 'forms.deviceDissociationPrompt',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SubmitDeviceDissociation extends StatelessWidget {
  const _SubmitDeviceDissociation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceDissociationBloc, DeviceDissociationState>(
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
                              .read<DeviceDissociationBloc>()
                              .add(SubmitDeviceDissociation());
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
