import 'dart:async';
import 'dart:io';

import 'package:app/commons/commons.dart';
import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/device.dart';
import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:collection/collection.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  ProfileUser? profile;
  Vehicle? vehicle;

  AddVehicleBloc({this.profile, String? email, Vehicle? item})
      : this.vehicle = item,
        super(
          item != null
              ? AddVehicleState(
                  pagestatus: SwitchPageStatus.vehicleInformation,
                  verificationEmail:
                      Email.dirty(email ?? 'info@sumelongenterprise.com'),
                  name: Name.dirty(item.name ?? ''),
                  vin: ValidVin.dirty(item.vin ?? ''),
                  make: Name.dirty(item.make ?? ''),
                  model: Name.dirty(item.model ?? ''),
                  bodyType: Name.dirty(item.bodyType ?? ''),
                  year: Name.dirty(item.modelYear ?? ''),
                  transmission: Name.dirty(item.transmission ?? ''),
                  fuelType: Name.dirty(item.fuelType ?? ''),
                  vehicleGroup: ParseObjectItem.dirty(item.vehicleGroup),
                  mileage: INumber.dirty(item.mileage.toString()),
                  country: Name.dirty(item.registrationCountry ?? ''),
                  region: OptionalName.dirty(item.region ?? ''),
                  registrationId: Name.dirty(item.registrationId ?? ''),
                  licenceNumber: Name.dirty(item.licensePlate ?? ''),
                  registrationDate:
                      IDateTime.dirty(item.licensePlateDateOfRegistration),
                  expiryDate: IDateTime.dirty(item.licensePlateDateValidUntil),
                  bearerName: Name.dirty(item.bearerName ?? ''),
                  phoneNumber:
                      PhoneNumber.dirty(item.bearerPhoneNumber.toString()),
                  email: Email.dirty(item.bearerEmailAddress ?? ''),
                  addressLine1: Name.dirty(item.bearerAddress ?? ''),
                  addressLine2: Name.dirty(item.bearerAddress2 ?? ''),
                )
              : AddVehicleState(
                  verificationEmail:
                      Email.dirty(email ?? 'info@sumelongenterprise.com'),
                ),
        ) {
    on<VerificationPinChanged>(_onVerificationPinChanged);
    on<SerialNumberChanged>(_onSerialNumberChanged);
    on<ChangeEmailorPhone>(_onChangeEmailorPhone);
    on<ChangeSubmitedEmailOrPhone>(_onChangeSubmitedEmailOrPhone);
    on<AssociateDeviceLater>(_onAssociateDeviceLater);
    on<SubmitDeviceAssociation>(_onSubmitDeviceAssociation);
    on<SkipDeviceAssociation>(_onSkipDeviceAssociation);
    on<SubmitVerificationCode>(_onSubmitVerificationCode);
    on<ResendVerificationCode>(_onResendVerificationCode);
    on<SubmitVehicleInformation>(_onSubmitVehicleInformation);
    on<SubmitRegistrationInformation>(_onSubmitRegistrationInformation);
    on<CountryChanged>(_onCountryChanged);
    on<RegionChanged>(_onRegionChanged);
    on<RegistrationIdChanged>(_onRegistrationIdChanged);
    on<LicenceNumberChanged>(_onLicenceNumberChanged);
    on<RegistrationDateChanged>(_onRegistrationDateChanged);
    on<ExpiryDateChanged>(_onExpiryDateChanged);
    on<BearerNameChanged>(_onBearerNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<EmailChanged>(_onEmailChanged);
    on<VerificationEmailChanged>(_onVerificationEmailChanged);
    on<AddressLine1Changed>(_onAddressLine1Changed);
    on<AddressLine2Changed>(_onAddressLine2Changed);
    on<ImageUploadChanged>(_onImageUploadChanged);
    on<VehicleNameChanged>(_onVehicleNameChanged);
    on<VinChanged>(_onVinChanged);
    on<MakeChanged>(_onMakeChanged);
    on<ModelChanged>(_onModelChanged);
    on<BodyTypeChanged>(_onBodyTypeChanged);
    on<YearChanged>(_onYearChanged);
    on<TransmissionChanged>(_onTransmissionChanged);
    on<FuelTypeChanged>(_onFuelTypeChanged);
    on<VehicleGroupChanged>(_onVehicleGroupChanged);
    on<MileageChanged>(_onMileageChanged);
  }

  void _onChangeEmailorPhone(ChangeEmailorPhone event, Emitter emit) {
    emit(state.copyWith(pagestatus: SwitchPageStatus.changeEmailOrPhone));
  }

  Future<void> _onAssociateDeviceLater(
    AssociateDeviceLater event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onChangeSubmitedEmailOrPhone(
    ChangeSubmitedEmailOrPhone event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.initial));
  }

  Future<void> _onSubmitDeviceAssociation(
    SubmitDeviceAssociation event,
    Emitter<AddVehicleState> emit,
  ) async {
    if (state.deviceSerialNumber.valid) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        var _iDevice = await _fetchDevice(state.deviceSerialNumber.value);
        var _device = _iDevice?.firstOrNull;
        if (_device != null) {
          var _vehicle =
              await _fetchVehicleIfExists(state.deviceSerialNumber.value);
          if (_vehicle?.isEmpty ?? false) {
            /// process device here
            _device.bearerEmailAddress = state.verificationEmail.value;
            _device.updating = true;
            var _verificationCode = generateRandomString(5);
            _device.devicePin = _verificationCode;
            await _device.update();
            emit(
              state.copyWith(
                submission: fz.FormzSubmission.pure(),
                pagestatus: SwitchPageStatus.deviceVerification,
                verificationCode: _verificationCode,
                editable: true,
              ),
            );
          } else {
            throw 'device is mapped';
          }
        } else {
          throw 'device not found';
        }
      } catch (e) {
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.failure(
              e.toString(),
            ),
            editable: true,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            'unable to process device',
          ),
          editable: true,
        ),
      );
    }
  }

  Future<void> _onSkipDeviceAssociation(
    SkipDeviceAssociation event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onSubmitVerificationCode(
    SubmitVerificationCode event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(
      submission: fz.FormzSubmission.inProgress(),
      editable: false,
    ));
    try {
      if (state.verificationPin.value == state.verificationCode) {
        /// successful verification
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.pure(),
            pagestatus: SwitchPageStatus.vehicleInformation,
            device: (await _fetchDevice(state.deviceSerialNumber.value))
                ?.firstOrNull,
            editable: true,
          ),
        );
      } else {
        throw 'code verification failed';
      }
    } catch (e) {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            e.toString(),
          ),
          editable: true,
        ),
      );
    }
    // emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onResendVerificationCode(
    ResendVerificationCode event,
    Emitter<AddVehicleState> emit,
  ) async {
    if (state.deviceSerialNumber.valid) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        var _iDevice = await _fetchDevice(state.deviceSerialNumber.value);
        var _device = _iDevice?.firstOrNull;
        if (_device != null) {
          var _vehicle =
              await _fetchVehicleIfExists(state.deviceSerialNumber.value);
          if (_vehicle?.isEmpty ?? false) {
            /// process device here
            _device.bearerEmailAddress = state.verificationEmail.value;
            _device.updating = true;
            var _verificationCode = state.verificationCode;
            _device.devicePin = _verificationCode;
            await _device.update();
            emit(
              state.copyWith(
                submission: fz.FormzSubmission.pure(),
                verificationCode: _verificationCode,
                editable: true,
              ),
            );
          } else {
            throw 'device is mapped';
          }
        } else {
          throw 'device not found';
        }
      } catch (e) {
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.failure(
              e.toString(),
            ),
            editable: true,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            'unable to process device',
          ),
          editable: true,
        ),
      );
    }
  }

  Future<void> _onSubmitVehicleInformation(
    SubmitVehicleInformation event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(pagestatus: SwitchPageStatus.registrationInformation),
    );
  }

  Future<void> _onCountryChanged(
    CountryChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(country: Name.dirty(event.value)),
    );
  }

  Future<void> _onRegionChanged(
    RegionChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(region: OptionalName.dirty(event.value)),
    );
  }

  Future<void> _onRegistrationIdChanged(
    RegistrationIdChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(registrationId: Name.dirty(event.value)),
    );
  }

  FutureOr<void> _onLicenceNumberChanged(
    LicenceNumberChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(licenceNumber: Name.dirty(event.value)),
    );
  }

  Future<void> _onRegistrationDateChanged(
    RegistrationDateChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(registrationDate: IDateTime.dirty(event.value)),
    );
  }

  Future<void> _onExpiryDateChanged(
    ExpiryDateChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(expiryDate: IDateTime.dirty(event.value)),
    );
  }

  Future<void> _onBearerNameChanged(
    BearerNameChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(bearerName: Name.dirty(event.value)),
    );
  }

  Future<void> _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(phoneNumber: PhoneNumber.dirty(event.value)),
    );
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(email: Email.dirty(event.value)),
    );
  }

  Future<void> _onVerificationEmailChanged(
    VerificationEmailChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(verificationEmail: Email.dirty(event.value)),
    );
  }

  Future<void> _onAddressLine1Changed(
    AddressLine1Changed event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(addressLine1: Name.dirty(event.value)),
    );
  }

  Future<void> _onAddressLine2Changed(
    AddressLine2Changed event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(addressLine2: Name.dirty(event.value)),
    );
  }

  Future<void> _onImageUploadChanged(
    ImageUploadChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(image: OptionalFile.dirty(event.value)),
    );
  }

  Future<void> _onVehicleNameChanged(
    VehicleNameChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(name: Name.dirty(event.value)),
    );
  }

  Future<void> _onVinChanged(
    VinChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(vin: ValidVin.dirty(event.value)),
    );
  }

  Future<void> _onMakeChanged(
    MakeChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(make: Name.dirty(event.value)),
    );
  }

  Future<void> _onModelChanged(
    ModelChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(model: Name.dirty(event.value)),
    );
  }

  Future<void> _onBodyTypeChanged(
    BodyTypeChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(bodyType: Name.dirty(event.value)),
    );
  }

  Future<void> _onYearChanged(
    YearChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(year: Name.dirty(event.value)),
    );
  }

  Future<void> _onTransmissionChanged(
    TransmissionChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(transmission: Name.dirty(event.value)),
    );
  }

  Future<void> _onFuelTypeChanged(
    FuelTypeChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(fuelType: Name.dirty(event.value)),
    );
  }

  Future<void> _onVehicleGroupChanged(
    VehicleGroupChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(vehicleGroup: ParseObjectItem.dirty(event.value)),
    );
  }

  Future<void> _onMileageChanged(
    MileageChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(mileage: INumber.dirty(event.value)),
    );
  }

  Future<void> _onSerialNumberChanged(
    SerialNumberChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    var serialNumber = Name.dirty(event.value);
    emit(
      state.copyWith(
        deviceSerialNumber: serialNumber,
        serialInputForm: fz.Formz.validate([serialNumber]),
        submission: fz.FormzSubmission.pure(),
      ),
    );
  }

  Future<void> _onSubmitRegistrationInformation(
    SubmitRegistrationInformation event,
    Emitter<AddVehicleState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        ApiResponse response = vehicle != null
            ? getApiResponse<Vehicle>(await ((vehicle as Vehicle)
                  ..name = state.name.value
                  ..vin = state.vin.value
                  ..make = state.make.value
                  ..set('manufacturer', state.make.value)
                  ..model = state.model.value
                  ..driver = await ParseUser.currentUser()
                  ..user = await ParseUser.currentUser()
                  ..bodyType = state.bodyType.value
                  ..modelYear = state.year.value
                  ..transmission = state.transmission.value
                  ..fuelType = state.fuelType.value
                  ..vehicleGroup = state.vehicleGroup.value != null
                      ? state.vehicleGroup.value as VehicleGroup?
                      : null
                  ..mileage = int.parse(state.mileage.value)
                  ..photo = state.image.value?.path != null
                      ? ParseFile(state.image.value)
                      : null
                  ..profile = profile?.profile
                  ..countryCode = state.country.value
                  ..registrationCountry = state.country.value
                  ..region = state.region.value
                  ..registrationId = state.registrationId.value
                  ..licensePlate = state.licenceNumber.value
                  ..licensePlateDateOfRegistration =
                      state.registrationDate.value
                  ..licensePlateDateValidUntil = state.expiryDate.value
                  ..bearerName = state.bearerName.value
                  ..bearerPhoneNumber = int.parse(state.phoneNumber.value)
                  ..bearerEmailAddress = state.email.value
                  ..device = state.device
                  ..bearerAddress = state.addressLine1.value
                  ..bearerAddress2 = state.addressLine2.value)
                .update())
            : getApiResponse<Vehicle>(await (Vehicle()
                  ..name = state.name.value
                  ..vin = state.vin.value
                  ..make = state.make.value
                  ..set('manufacturer', state.make.value)
                  ..model = state.model.value
                  ..driver = await ParseUser.currentUser()
                  ..user = await ParseUser.currentUser()
                  ..bodyType = state.bodyType.value
                  ..modelYear = state.year.value
                  ..transmission = state.transmission.value
                  ..fuelType = state.fuelType.value
                  ..vehicleGroup = state.vehicleGroup.value != null
                      ? state.vehicleGroup.value as VehicleGroup?
                      : null
                  ..mileage = int.parse(state.mileage.value)
                  ..photo = state.image.value?.path != null
                      ? ParseFile(state.image.value)
                      : null
                  ..profile = profile?.profile
                  ..countryCode = state.country.value
                  ..registrationCountry = state.country.value
                  ..region = state.region.value
                  ..registrationId = state.registrationId.value
                  ..licensePlate = state.licenceNumber.value
                  ..licensePlateDateOfRegistration =
                      state.registrationDate.value
                  ..licensePlateDateValidUntil = state.expiryDate.value
                  ..bearerName = state.bearerName.value
                  ..bearerPhoneNumber = int.parse(state.phoneNumber.value)
                  ..bearerEmailAddress = state.email.value
                  ..device = state.device
                  ..bearerAddress = state.addressLine1.value
                  ..bearerAddress2 = state.addressLine2.value)
                  
                .save());
        if (response.success) {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.success(success: response.result),
              editable: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.failure(
                response.error?.message ?? 'unable to save',
              ),
              editable: true,
            ),
          );
        }
      } catch (error) {
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.failure(
              error.toString(),
            ),
            editable: true,
          ),
        );
      }
    }
  }

  Future<List<Device?>>? _fetchDevice(String serialNumber) async {
    QueryBuilder<Device> query = QueryBuilder<Device>(Device());
    query.whereEqualTo('serialNumber', serialNumber);
    return query.find();
  }

  Future<List<Vehicle?>>? _fetchVehicleIfExists(String serialNumber) async {
    QueryBuilder<Device> vQuery = QueryBuilder<Device>(Device());
    vQuery.whereEqualTo('serialNumber', serialNumber);
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.whereMatchesQuery('device', vQuery);
    return query.find();
  }

  Future<void> _onVerificationPinChanged(
    VerificationPinChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    var value = Name.dirty(event.value);
    emit(
      state.copyWith(
        verificationPin: value,
        verificationPinInputForm: fz.Formz.validate([value]),
      ),
    );
  }
}
