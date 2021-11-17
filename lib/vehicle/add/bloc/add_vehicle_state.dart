part of 'add_vehicle_bloc.dart';

enum SwitchPageStatus {
  initial,
  changeEmailOrPhone,
  deviceVerification,
  vehicleInformation,
  registrationInformation,
}

class AddVehicleState extends Equatable with fz.FormzMixin<String, Vehicle> {
  final fz.FormzSubmission<String, Vehicle> _submission;
  final SwitchPageStatus pagestatus;
  final bool editable;
  final Name deviceSerialNumber;
  final Name name;
  final Name vin;
  final Name make;
  final Name model;
  final Name bodyType;
  final Name year;
  final Name transmission;
  final Name fuelType;
  final Name vehicleGroup;
  final Name mileage;
  final Name image;
  final Name country;
  final Name region;
  final Name registrationId;
  final Name licenceNumber;
  final Name registrationDate;
  final Name expiryDate;
  final Name bearerName;
  final Name phoneNumber;
  final Email email;
  final Name addressLine1;
  final Name addressLine2;

  const AddVehicleState({
    this.pagestatus = SwitchPageStatus.initial,
    this.deviceSerialNumber = const Name.pure(),
    this.name = const Name.pure(),
    this.vin = const Name.pure(),
    this.make = const Name.pure(),
    this.model = const Name.pure(),
    this.bodyType = const Name.pure(),
    this.year = const Name.pure(),
    this.transmission = const Name.pure(),
    this.fuelType = const Name.pure(),
    this.vehicleGroup = const Name.pure(),
    this.mileage = const Name.pure(),
    this.image = const Name.pure(),
    this.country = const Name.pure(),
    this.region = const Name.pure(),
    this.registrationId = const Name.pure(),
    this.licenceNumber = const Name.pure(),
    this.registrationDate = const Name.pure(),
    this.expiryDate = const Name.pure(),
    this.bearerName = const Name.pure(),
    this.phoneNumber = const Name.pure(),
    this.email = const Email.pure(),
    this.addressLine1 = const Name.pure(),
    this.addressLine2 = const Name.pure(),
    this.editable = true,
    fz.FormzSubmission<String, Vehicle> status =
        const fz.FormzSubmission.pure(),
  }) : _submission = status;
  AddVehicleState copyWith({
    SwitchPageStatus? pagestatus,
    Name? deviceSerialNumber,
    Name? name,
    Name? vin,
    Name? make,
    Name? model,
    Name? bodyType,
    Name? year,
    Name? transmission,
    Name? fuelType,
    Name? vehicleGroup,
    Name? mileage,
    Name? image,
    Name? country,
    Name? region,
    Name? registrationId,
    Name? licenceNumber,
    Name? registrationDate,
    Name? expiryDate,
    Name? bearerName,
    Name? phoneNumber,
    Email? email,
    Name? addressLine1,
    Name? addressLine2,
    bool? editable,
    fz.FormzSubmission<String, Vehicle>? submission,
  }) {
    return AddVehicleState(
      pagestatus: pagestatus ?? this.pagestatus,
      deviceSerialNumber: deviceSerialNumber ?? this.deviceSerialNumber,
      name: name ?? this.name,
      vin: vin ?? this.vin,
      make: make ?? this.make,
      model: model ?? this.model,
      bodyType: bodyType ?? this.bodyType,
      year: year ?? this.year,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      vehicleGroup: vehicleGroup ?? this.vehicleGroup,
      mileage: mileage ?? this.mileage,
      image: image ?? this.image,
      country: country ?? this.country,
      region: region ?? this.region,
      registrationId: registrationId ?? this.registrationId,
      licenceNumber: licenceNumber ?? this.licenceNumber,
      registrationDate: registrationDate ?? this.registrationDate,
      expiryDate: expiryDate ?? this.expiryDate,
      bearerName: bearerName ?? this.bearerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      editable: editable ?? this.editable,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object> get props => [
        pagestatus,
        editable,
        _submission,
        name,
        vin,
        make,
        model,
        bodyType,
        year,
        transmission,
        fuelType,
        vehicleGroup,
        mileage,
        image,
        country,
        region,
        registrationId,
        licenceNumber,
        registrationDate,
        expiryDate,
        bearerName,
        phoneNumber,
        email,
        addressLine1,
        addressLine2,
      ];

  @override
  List<fz.FormzInput> get inputs => [
        name,
        vin,
        make,
        model,
        bodyType,
        year,
        transmission,
        fuelType,
        vehicleGroup,
        mileage,
        image,
        country,
        region,
        registrationId,
        licenceNumber,
        registrationDate,
        expiryDate,
        bearerName,
        phoneNumber,
        email,
        addressLine1,
        addressLine2,
      ];

  @override
  fz.FormzSubmission<String, Vehicle> get submission => _submission;
}
