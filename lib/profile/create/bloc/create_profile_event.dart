part of 'create_profile_bloc.dart';

abstract class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileChanged extends CreateProfileEvent {
  const ProfileChanged(this.value);

  final File? value;

  @override
  List<Object?> get props => [value];
}

class NameChanged extends CreateProfileEvent {
  const NameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class DescriptionChanged extends CreateProfileEvent {
  const DescriptionChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class PhoneNumberChanged extends CreateProfileEvent {
  const PhoneNumberChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class EmailChanged extends CreateProfileEvent {
  const EmailChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine1Changed extends CreateProfileEvent {
  const AddressLine1Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class AddressLine2Changed extends CreateProfileEvent {
  const AddressLine2Changed(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StreetChanged extends CreateProfileEvent {
  const StreetChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ZipCodeChanged extends CreateProfileEvent {
  const ZipCodeChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class CityChanged extends CreateProfileEvent {
  const CityChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class StateChanged extends CreateProfileEvent {
  const StateChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class WebSiteChanged extends CreateProfileEvent {
  const WebSiteChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TaxIdChanged extends CreateProfileEvent {
  const TaxIdChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class RegistrationIdChanged extends CreateProfileEvent {
  const RegistrationIdChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class FormSubmitted extends CreateProfileEvent {
  const FormSubmitted();
}
