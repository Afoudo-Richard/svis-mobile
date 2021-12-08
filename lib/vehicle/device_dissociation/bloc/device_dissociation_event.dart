part of 'device_dissociation_bloc.dart';

abstract class DeviceDissociationEvent extends Equatable {
  const DeviceDissociationEvent();

  @override
  List<Object> get props => [];
}

class FetchDeviceProperties extends DeviceDissociationEvent {}

class ChangeEmailorPhone extends DeviceDissociationEvent {}

class ChangeSubmitedEmailOrPhone extends DeviceDissociationEvent {}

class SubmitDeviceDissociation extends DeviceDissociationEvent {}

class SubmitVerificationCode extends DeviceDissociationEvent {}

class ResendVerificationCode extends DeviceDissociationEvent {}

class VerificationPinChanged extends DeviceDissociationEvent {
  const VerificationPinChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SerialNumberChanged extends DeviceDissociationEvent {
  const SerialNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class VerificationEmailChanged extends DeviceDissociationEvent {
  const VerificationEmailChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
