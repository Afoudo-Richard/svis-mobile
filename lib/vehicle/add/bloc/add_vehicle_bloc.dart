import 'dart:async';

import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  ProfileUser? profile;

  AddVehicleBloc({this.profile}) : super(AddVehicleState()) {
    on<ChangeEmailorPhone>(_onChangeEmailorPhone);
    on<ChangeSubmitedEmailOrPhone>(_onChangeSubmitedEmailOrPhone);
    on<AssociateDeviceLater>(_onAssociateDeviceLater);
    on<SubmitDeviceAssociation>(_onSubmitDeviceAssociation);
    on<SkipDeviceAssociation>(_onSkipDeviceAssociation);
    on<SubmitVerificationCode>(_onSubmitVerificationCode);
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
    emit(state.copyWith(pagestatus: SwitchPageStatus.deviceVerification));
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
    emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
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
      state.copyWith(region: Name.dirty(event.value)),
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
      state.copyWith(registrationDate: Name.dirty(event.value)),
    );
  }

  Future<void> _onExpiryDateChanged(
    ExpiryDateChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(expiryDate: Name.dirty(event.value)),
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
      state.copyWith(phoneNumber: Name.dirty(event.value)),
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
      state.copyWith(image: Name.dirty(event.value)),
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
      state.copyWith(vin: Name.dirty(event.value)),
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
      state.copyWith(vehicleGroup: Name.dirty(event.value)),
    );
  }

  Future<void> _onMileageChanged(
    MileageChanged event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(
      state.copyWith(mileage: Name.dirty(event.value)),
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
        await Future.delayed(const Duration(milliseconds: 5000), () {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.success(),
              editable: true,
            ),
          );
        });
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
}
