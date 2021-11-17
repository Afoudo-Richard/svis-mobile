part of 'vehicle_profile_bloc.dart';

class VehicleProfileState extends Equatable with fz.FormzMixin<String, User> {
  Vehicle? vehicle;
  final fz.FormzSubmission<String, User> _submission;
  final OptionalFile profile;
  final Name make;
  final Name model;
  final Name bodyType;
  final Name year;
  final Name transmission;
  final Name fuelType;
  final Name countryOfRegistration;
  final Name city;
  final Name registrationId;
  final Name licencePlateNumber;
  final IDateTime issuedDate;
  final IDateTime expiredDate;
  final Name bearerName;
  final Name addressLine1;
  final Name addressLine2;
  final Name phoneNumber;
  final Name email;
  final bool editable;

  VehicleProfileState({
    this.vehicle,
    this.profile = const OptionalFile.pure(),
    this.make = const Name.pure(),
    this.model = const Name.pure(),
    this.bodyType = const Name.pure(),
    this.year = const Name.pure(),
    this.transmission = const Name.pure(),
    this.fuelType = const Name.pure(),
    this.countryOfRegistration = const Name.pure(),
    this.city = const Name.pure(),
    this.registrationId = const Name.pure(),
    this.licencePlateNumber = const Name.pure(),
    this.issuedDate = const IDateTime.pure(),
    this.expiredDate = const IDateTime.pure(),
    this.bearerName = const Name.pure(),
    this.addressLine1 = const Name.pure(),
    this.addressLine2 = const Name.pure(),
    this.phoneNumber = const Name.pure(),
    this.email = const Name.pure(),
    this.editable = false,
    fz.FormzSubmission<String, User> status = const fz.FormzSubmission.pure(),
  }) : _submission = status;

  VehicleProfileState copyWith({
    Vehicle? vehicle,
    OptionalFile? profile,
    Name? make,
    Name? model,
    Name? bodyType,
    Name? year,
    Name? transmission,
    Name? fuelType,
    Name? countryOfRegistration,
    Name? city,
    Name? registrationId,
    Name? licencePlateNumber,
    IDateTime? issuedDate,
    IDateTime? expiredDate,
    Name? bearerName,
    Name? addressLine1,
    Name? addressLine2,
    Name? phoneNumber,
    Name? email,
    bool? editable,
    fz.FormzSubmission<String, User>? submission,
  }) {
    return VehicleProfileState(
      vehicle: vehicle ?? this.vehicle,
      profile: profile ?? this.profile,
      make: make ?? this.make,
      model: model ?? this.model,
      bodyType: bodyType ?? this.bodyType,
      year: year ?? this.year,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      countryOfRegistration:
          countryOfRegistration ?? this.countryOfRegistration,
      city: city ?? this.city,
      registrationId: registrationId ?? this.registrationId,
      licencePlateNumber: licencePlateNumber ?? this.licencePlateNumber,
      issuedDate: issuedDate ?? this.issuedDate,
      expiredDate: expiredDate ?? this.expiredDate,
      bearerName: bearerName ?? this.bearerName,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      editable: editable ?? this.editable,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object?> get props => [
        vehicle,
        _submission,
        profile,
        make,
        model,
        bodyType,
        year,
        transmission,
        fuelType,
        countryOfRegistration,
        city,
        registrationId,
        licencePlateNumber,
        issuedDate,
        expiredDate,
        bearerName,
        addressLine1,
        addressLine2,
        phoneNumber,
        email,
        editable
      ];

  @override
  List<fz.FormzInput> get inputs => [
        make,
        model,
        bodyType,
        year,
        transmission,
        fuelType,
        countryOfRegistration,
        city,
        registrationId,
        licencePlateNumber,
        issuedDate,
        expiredDate,
        bearerName,
        addressLine1,
        addressLine2,
        phoneNumber,
        email,
      ];

  @override
  fz.FormzSubmission<String, User> get submission => _submission;
}
