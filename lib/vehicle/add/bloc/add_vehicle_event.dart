part of 'add_vehicle_bloc.dart';

abstract class AddVehicleEvent extends Equatable {
  const AddVehicleEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailorPhone extends AddVehicleEvent {}

class AssociateDeviceLater extends AddVehicleEvent {}

class ChangeSubmitedEmailOrPhone extends AddVehicleEvent {}

class SubmitDeviceAssociation extends AddVehicleEvent {}

class SkipDeviceAssociation extends AddVehicleEvent {}

class SubmitVerificationCode extends AddVehicleEvent {}

class SubmitVehicleInformation extends AddVehicleEvent {}

class SubmitRegistrationInformation extends AddVehicleEvent {}

class CountryChanged extends AddVehicleEvent {
  const CountryChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class RegionChanged extends AddVehicleEvent {
  const RegionChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class RegistrationIdChanged extends AddVehicleEvent {
  const RegistrationIdChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class LicenceNumberChanged extends AddVehicleEvent {
  const LicenceNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class RegistrationDateChanged extends AddVehicleEvent {
  const RegistrationDateChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ExpiryDateChanged extends AddVehicleEvent {
  const ExpiryDateChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class BearerNameChanged extends AddVehicleEvent {
  const BearerNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class PhoneNumberChanged extends AddVehicleEvent {
  const PhoneNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class EmailChanged extends AddVehicleEvent {
  const EmailChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine1Changed extends AddVehicleEvent {
  const AddressLine1Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine2Changed extends AddVehicleEvent {
  const AddressLine2Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ImageUploadChanged extends AddVehicleEvent {
  const ImageUploadChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class VehicleNameChanged extends AddVehicleEvent {
  const VehicleNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class VinChanged extends AddVehicleEvent {
  const VinChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class MakeChanged extends AddVehicleEvent {
  const MakeChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ModelChanged extends AddVehicleEvent {
  const ModelChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class BodyTypeChanged extends AddVehicleEvent {
  const BodyTypeChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class YearChanged extends AddVehicleEvent {
  const YearChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TransmissionChanged extends AddVehicleEvent {
  const TransmissionChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class FuelTypeChanged extends AddVehicleEvent {
  const FuelTypeChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class VehicleGroupChanged extends AddVehicleEvent {
  const VehicleGroupChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class MileageChanged extends AddVehicleEvent {
  const MileageChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
