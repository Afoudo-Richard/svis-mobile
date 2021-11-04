part of 'add_user_bloc.dart';

abstract class AddUserEvent extends Equatable {
  const AddUserEvent();

  @override
  List<Object?> get props => [];
}

class ProfileChanged extends AddUserEvent {
  const ProfileChanged(this.value);

  final File? value;

  @override
  List<Object?> get props => [value];
}

class FirstNameChanged extends AddUserEvent {
  const FirstNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class LastNameChanged extends AddUserEvent {
  const LastNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class DateOfBirthChanged extends AddUserEvent {
  const DateOfBirthChanged(this.value);

  final DateTime value;

  @override
  List<Object> get props => [value];
}

class GenderChanged extends AddUserEvent {
  const GenderChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TimeZoneChanged extends AddUserEvent {
  const TimeZoneChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class EmailChanged extends AddUserEvent {
  const EmailChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class PhoneNumberChanged extends AddUserEvent {
  const PhoneNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine1Changed extends AddUserEvent {
  const AddressLine1Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine2Changed extends AddUserEvent {
  const AddressLine2Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class CityChanged extends AddUserEvent {
  const CityChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StateChanged extends AddUserEvent {
  const StateChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class CountryOfRegistrationChanged extends AddUserEvent {
  const CountryOfRegistrationChanged(this.value);

  final String? value;

  @override
  List<Object?> get props => [value];
}

class RegionChanged extends AddUserEvent {
  const RegionChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StatusChanged extends AddUserEvent {
  const StatusChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class EditChanged extends AddUserEvent {
  const EditChanged();
}

class FormSubmitted extends AddUserEvent {
  const FormSubmitted();
}
