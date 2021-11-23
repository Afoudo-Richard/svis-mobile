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
  final fz.FormzStatus serialInputForm;
  final Name verificationPin;
  final fz.FormzStatus verificationPinInputForm;
  final Device? device;
  final Name name;
  final ValidVin vin;
  final Name make;
  final Name model;
  final Name bodyType;
  final Name year;
  final Name transmission;
  final Name fuelType;
  final ParseObjectItem vehicleGroup;
  final INumber mileage;
  final OptionalFile image;
  final Name country;
  final OptionalName region;
  final Name registrationId;
  final Name licenceNumber;
  final IDateTime registrationDate;
  final IDateTime expiryDate;
  final Name bearerName;
  final PhoneNumber phoneNumber;
  final Email email;
  final Email verificationEmail;
  final String? verificationCode;
  final Name addressLine1;
  final Name addressLine2;

  const AddVehicleState({
    this.pagestatus = SwitchPageStatus.initial,
    this.deviceSerialNumber = const Name.pure(),
    this.serialInputForm = fz.FormzStatus.pure,
    this.verificationPin = const Name.pure(),
    this.verificationPinInputForm = fz.FormzStatus.pure,
    this.device,
    this.name = const Name.pure(),
    this.vin = const ValidVin.pure(),
    this.make = const Name.pure(),
    this.model = const Name.pure(),
    this.bodyType = const Name.pure(),
    this.year = const Name.pure(),
    this.transmission = const Name.pure(),
    this.fuelType = const Name.pure(),
    this.vehicleGroup = const ParseObjectItem.pure(),
    this.mileage = const INumber.pure(),
    this.image = const OptionalFile.pure(),
    this.country = const Name.pure(),
    this.region = const OptionalName.pure(),
    this.registrationId = const Name.pure(),
    this.licenceNumber = const Name.pure(),
    this.registrationDate = const IDateTime.pure(),
    this.expiryDate = const IDateTime.pure(),
    this.bearerName = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.email = const Email.pure(),
    this.verificationEmail = const Email.pure(),
    this.verificationCode,
    this.addressLine1 = const Name.pure(),
    this.addressLine2 = const Name.pure(),
    this.editable = true,
    fz.FormzSubmission<String, Vehicle> status =
        const fz.FormzSubmission.pure(),
  }) : _submission = status;
  AddVehicleState copyWith({
    SwitchPageStatus? pagestatus,
    Name? deviceSerialNumber,
    fz.FormzStatus? serialInputForm,
    Name? verificationPin,
    fz.FormzStatus? verificationPinInputForm,
    Device? device,
    Name? name,
    ValidVin? vin,
    Name? make,
    Name? model,
    Name? bodyType,
    Name? year,
    Name? transmission,
    Name? fuelType,
    ParseObjectItem? vehicleGroup,
    INumber? mileage,
    OptionalFile? image,
    Name? country,
    OptionalName? region,
    Name? registrationId,
    Name? licenceNumber,
    IDateTime? registrationDate,
    IDateTime? expiryDate,
    Name? bearerName,
    PhoneNumber? phoneNumber,
    Email? email,
    Email? verificationEmail,
    String? verificationCode,
    Name? addressLine1,
    Name? addressLine2,
    bool? editable,
    fz.FormzSubmission<String, Vehicle>? submission,
  }) {
    return AddVehicleState(
      pagestatus: pagestatus ?? this.pagestatus,
      deviceSerialNumber: deviceSerialNumber ?? this.deviceSerialNumber,
      serialInputForm: serialInputForm ?? this.serialInputForm,
      verificationPin: verificationPin ?? this.verificationPin,
      verificationPinInputForm:
          verificationPinInputForm ?? this.verificationPinInputForm,
      device: device ?? this.device,
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
      verificationEmail: verificationEmail ?? this.verificationEmail,
      verificationCode: verificationCode ?? this.verificationCode,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      editable: editable ?? this.editable,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object?> get props => [
        pagestatus,
        editable,
        _submission,
        deviceSerialNumber,
        serialInputForm,
        verificationPin,
        verificationPinInputForm,
        device,
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
        verificationEmail,
        verificationCode,
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
        verificationEmail,
        addressLine1,
        addressLine2,
      ];

  @override
  fz.FormzSubmission<String, Vehicle> get submission => _submission;
}
