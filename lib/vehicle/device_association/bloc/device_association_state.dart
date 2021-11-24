part of 'device_association_bloc.dart';

enum DeviceAssociationPageStatus {
  initial,
  changeEmailOrPhone,
  deviceVerification,
}

class DeviceAssociationState extends Equatable
    with fz.FormzMixin<String, Vehicle> {
  final fz.FormzSubmission<String, Vehicle> _submission;

  final DeviceAssociationPageStatus pagestatus;
  final bool editable;
  final Name deviceSerialNumber;
  final fz.FormzStatus serialInputForm;
  final Name verificationPin;
  final fz.FormzStatus verificationPinInputForm;
  final Device? device;
  final Email verificationEmail;
  final String? verificationCode;

  const DeviceAssociationState({
    this.pagestatus = DeviceAssociationPageStatus.initial,
    this.deviceSerialNumber = const Name.pure(),
    this.serialInputForm = fz.FormzStatus.pure,
    this.verificationPin = const Name.pure(),
    this.verificationPinInputForm = fz.FormzStatus.pure,
    this.device,
    this.verificationEmail = const Email.pure(),
    this.verificationCode,
    this.editable = true,
    fz.FormzSubmission<String, Vehicle> status =
        const fz.FormzSubmission.pure(),
  }) : _submission = status;
  DeviceAssociationState copyWith({
    DeviceAssociationPageStatus? pagestatus,
    Name? deviceSerialNumber,
    fz.FormzStatus? serialInputForm,
    Name? verificationPin,
    fz.FormzStatus? verificationPinInputForm,
    Email? verificationEmail,
    String? verificationCode,
    bool? editable,
    fz.FormzSubmission<String, Vehicle>? submission,
  }) {
    return DeviceAssociationState(
      pagestatus: pagestatus ?? this.pagestatus,
      deviceSerialNumber: deviceSerialNumber ?? this.deviceSerialNumber,
      serialInputForm: serialInputForm ?? this.serialInputForm,
      verificationPin: verificationPin ?? this.verificationPin,
      verificationEmail: verificationEmail ?? this.verificationEmail,
      verificationPinInputForm:
          verificationPinInputForm ?? this.verificationPinInputForm,
      device: device ?? this.device,
      verificationCode: verificationCode ?? this.verificationCode,
      editable: editable ?? this.editable,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object?> get props => [
        pagestatus,
        editable,
        _submission,
        deviceSerialNumber,
        serialInputForm,
        verificationPin,
        verificationPinInputForm,
        device,
        verificationEmail,
        verificationCode,
      ];
  @override
  List<fz.FormzInput> get inputs => [
        verificationEmail,
      ];

  @override
  fz.FormzSubmission<String, Vehicle> get submission => _submission;
}
