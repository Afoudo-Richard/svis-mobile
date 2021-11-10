part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable with fz.FormzMixin<String, User> {
  final fz.FormzSubmission<String, User> _submission;
  final OptionalFile profile;
  final Name firstName;
  final Name lastName;
  final IDateTime dateOfBirth;
  final Name gender;
  // final Name timeZone;
  final Name email;
  final Name phoneNumber;
  final Name addressLine1;
  final Name addressLine2;
  final Name city;
  final Name state;
  final Name countryOfRegistration;
  // final Name region;
  final bool editable;

  const UserProfileState({
    this.profile = const OptionalFile.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.dateOfBirth = const IDateTime.pure(),
    this.gender = const Name.pure(),
    // this.timeZone = const Name.pure(),
    this.email = const Name.pure(),
    this.phoneNumber = const Name.pure(),
    this.addressLine1 = const Name.pure(),
    this.addressLine2 = const Name.pure(),
    this.city = const Name.pure(),
    this.state = const Name.pure(),
    this.countryOfRegistration = const Name.pure(),
    // this.region = const Name.pure(),
    this.editable = false,
    fz.FormzSubmission<String, User> status = const fz.FormzSubmission.pure(),
  }) : _submission = status;

  UserProfileState copyWith({
    OptionalFile? profile,
    Name? firstName,
    Name? lastName,
    IDateTime? dateOfBirth,
    Name? gender,
    // Name? timeZone,
    Name? email,
    Name? phoneNumber,
    Name? addressLine1,
    Name? addressLine2,
    Name? city,
    Name? state,
    Name? countryOfRegistration,
    // Name? region,
    bool? editable,
    fz.FormzSubmission<String, User>? submission,
  }) {
    return UserProfileState(
      profile: profile ?? this.profile,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      // timeZone: timeZone ?? this.timeZone,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      countryOfRegistration:
          countryOfRegistration ?? this.countryOfRegistration,
      // region: region ?? this.region,
      editable: editable ?? this.editable,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object> get props => [
        _submission,
        profile,
        firstName,
        lastName,
        dateOfBirth,
        gender,
        // timeZone,
        email,
        phoneNumber,
        addressLine1,
        addressLine2,
        city,
        state,
        countryOfRegistration,
        // region,
        editable,
      ];

  @override
  List<fz.FormzInput> get inputs => [
        firstName,
        lastName,
        dateOfBirth,
        gender,
        // timeZone,
        email,
        phoneNumber,
        addressLine1,
        addressLine2,
        city,
        state,
        countryOfRegistration,
        // region,
      ];

  @override
  fz.FormzSubmission<String, User> get submission => _submission;
}
