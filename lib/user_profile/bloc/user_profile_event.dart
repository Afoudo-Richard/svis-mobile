part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends UserProfileEvent {
  const FirstNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class LastNameChanged extends UserProfileEvent {
  const LastNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class DateOfBirthChanged extends UserProfileEvent {
  const DateOfBirthChanged(this.value);

  final DateTime value;

  @override
  List<Object> get props => [value];
}

class GenderChanged extends UserProfileEvent {
  const GenderChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TimeZoneChanged extends UserProfileEvent {
  const TimeZoneChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class EmailChanged extends UserProfileEvent {
  const EmailChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class PhoneNumberChanged extends UserProfileEvent {
  const PhoneNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine1Changed extends UserProfileEvent {
  const AddressLine1Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine2Changed extends UserProfileEvent {
  const AddressLine2Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class CityChanged extends UserProfileEvent {
  const CityChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StateChanged extends UserProfileEvent {
  const StateChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class CountryOfRegistrationChanged extends UserProfileEvent {
  const CountryOfRegistrationChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class RegionChanged extends UserProfileEvent {
  const RegionChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StatusChanged extends UserProfileEvent {
  const StatusChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class EditChanged extends UserProfileEvent {
  const EditChanged();
}
class FormSubmitted extends UserProfileEvent {
  const FormSubmitted();
}
