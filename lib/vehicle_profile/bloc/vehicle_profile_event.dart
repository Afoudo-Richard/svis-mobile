part of 'vehicle_profile_bloc.dart';

abstract class VehicleProfileEvent extends Equatable {
  const VehicleProfileEvent();

  @override
  List<Object?> get props => [];
}

class MakeChanged extends VehicleProfileEvent {
  const MakeChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class ModelChanged extends VehicleProfileEvent {
  const ModelChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class BodyTypeChanged extends VehicleProfileEvent {
  const BodyTypeChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class YearChanged extends VehicleProfileEvent {
  const YearChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class TransmissionChanged extends VehicleProfileEvent {
  const TransmissionChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class FuelTypeChanged extends VehicleProfileEvent {
  const FuelTypeChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}


class CountryOfRegistrationChanged extends VehicleProfileEvent {
  const CountryOfRegistrationChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class CityChanged extends VehicleProfileEvent {
  const CityChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class RegistrationIdChanged extends VehicleProfileEvent {
  const RegistrationIdChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class LicencePlateNumberChanged extends VehicleProfileEvent {
  const LicencePlateNumberChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class IssuedDateChanged extends VehicleProfileEvent {
  const IssuedDateChanged(this.value);
  final DateTime value;

  @override
  List<Object> get props => [value];
}

class ExpiredDateChanged extends VehicleProfileEvent {
  const ExpiredDateChanged(this.value);
  final DateTime value;

  @override
  List<Object> get props => [value];
}

class BearerNameChanged extends VehicleProfileEvent {
  const BearerNameChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine1Changed extends VehicleProfileEvent {
  const AddressLine1Changed(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine2Changed extends VehicleProfileEvent {
  const AddressLine2Changed(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class PhoneNumberChanged extends VehicleProfileEvent {
  const PhoneNumberChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class EmailChanged extends VehicleProfileEvent {
  const EmailChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class EditableChanged extends VehicleProfileEvent {
  const EditableChanged();
}

class ProfileChanged extends VehicleProfileEvent {
  const ProfileChanged(this.value);

  final File? value;

  @override
  List<Object?> get props => [value];
}

class FormSubmitted extends VehicleProfileEvent {
  const FormSubmitted();
}
