part of 'device_association_bloc.dart';

abstract class DeviceAssociationEvent extends Equatable {
  const DeviceAssociationEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailorPhone extends DeviceAssociationEvent {}

class ChangeSubmitedEmailOrPhone extends DeviceAssociationEvent {}

class SubmitDeviceAssociation extends DeviceAssociationEvent {}

class SubmitVerificationCode extends DeviceAssociationEvent {}

class ResendVerificationCode extends DeviceAssociationEvent {}

class VerificationPinChanged extends DeviceAssociationEvent {
  const VerificationPinChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SerialNumberChanged extends DeviceAssociationEvent {
  const SerialNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class VerificationEmailChanged extends DeviceAssociationEvent {
  const VerificationEmailChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
