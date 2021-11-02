part of 'create_profile_bloc.dart';

class CreateProfileState extends Equatable with fz.FormzMixin<String, Profile> {
  final fz.FormzSubmission<String, Profile> _submission;
  // general info
  final Name name;
  final Name description;
  final PhoneNumber phoneNumber;
  final Email email;
  // address info
  final Name addressLine1;
  final Name addressLine2;
  final Name street;
  final Name zipCode;
  final Name city;
  final Name state;
  final Name website;
  final Name taxId;
  final Name registrationId;

  const CreateProfileState({
    // general info
    this.name = const Name.pure(),
    this.description = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.email = const Email.pure(),
    // address info

    this.addressLine1 = const Name.pure(),
    this.addressLine2 = const Name.pure(),
    this.street = const Name.pure(),
    this.zipCode = const Name.pure(),
    this.city = const Name.pure(),
    this.state = const Name.pure(),
    this.website = const Name.pure(),
    this.taxId = const Name.pure(),
    this.registrationId = const Name.pure(),
    fz.FormzSubmission<String, Profile> status =
        const fz.FormzSubmission.pure(),
  }) : _submission = status;

  CreateProfileState copyWith({
    // general info
    Name? name,
    Name? description,
    PhoneNumber? phoneNumber,
    Email? email,
    // address info

    Name? addressLine1,
    Name? addressLine2,
    Name? street,
    Name? zipCode,
    Name? city,
    Name? state,
    Name? website,
    Name? taxId,
    Name? registrationId,
    fz.FormzSubmission<String, Profile>? submission,
  }) {
    return CreateProfileState(
      // general info
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      // address info

      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      state: state ?? this.state,
      website: website ?? this.website,
      taxId: taxId ?? this.taxId,
      registrationId: registrationId ?? this.registrationId,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object> get props => [
        _submission,
        // general info
        name,
        description,
        phoneNumber,
        email,
        // address info
        addressLine1,
        addressLine2,
        street,
        zipCode,
        city,
        state,
        website,
        taxId,
        registrationId,
      ];

  @override
  List<fz.FormzInput> get inputs => [
        // general info
        name,
        description,
        phoneNumber,
        email,
        // address info
        addressLine1,
        addressLine2,
        street,
        zipCode,
        city,
        state,
        website,
        taxId,
        registrationId,
      ];

  @override
  fz.FormzSubmission<String, Profile> get submission => _submission;
}
