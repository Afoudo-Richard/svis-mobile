import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:app/commons/formz.dart' as fz;

part 'vehicle_profile_event.dart';
part 'vehicle_profile_state.dart';

class VehicleProfileBloc
    extends Bloc<VehicleProfileEvent, VehicleProfileState> {
  Vehicle? vehicle;
  VehicleProfileBloc({Vehicle? vehicle})
      : super(VehicleProfileState(
          vehicle: vehicle ?? Vehicle(),
          make: Name.dirty(vehicle?.make ?? ""),
          model: Name.dirty(vehicle?.model ?? ""),
          bodyType: Name.dirty(vehicle?.model ?? ""),
          year: Name.dirty(vehicle?.modelYear ?? ""),
          transmission: Name.dirty(vehicle?.transmission ?? ""),
          fuelType: Name.dirty(vehicle?.fuelType ?? ""),
          countryOfRegistration: Name.dirty(vehicle?.registrationCountry ?? ""),
          city: Name.dirty(vehicle?.registrationCity ?? ""),
          registrationId: Name.dirty(vehicle?.registrationId ?? ""),
          licencePlateNumber: Name.dirty(vehicle?.licensePlate ?? ""),
          issuedDate: IDateTime.dirty(vehicle?.licensePlateDateOfRegistration),
          expiredDate: IDateTime.dirty(vehicle?.licensePlateDateOfRegistration),
          bearerName: Name.dirty(vehicle?.bearerName ?? ""),
          addressLine1: Name.dirty(vehicle?.bearerAddress ?? ""),
          addressLine2: Name.dirty(vehicle?.bearerAddress2 ?? ""),
          phoneNumber: Name.dirty(vehicle?.bearerPhoneNumber.toString() ?? ""),
          email: Name.dirty(vehicle?.bearerEmailAddress ?? ""),
        )) {
    on<ProfileChanged>(_mapProfileChangedToState);
    on<MakeChanged>((event, emit) {
      emit(_mapMakeChangedToState(event, state));
    });

    on<ModelChanged>((event, emit) {
      emit(_mapModelChangedToState(event, state));
    });

    on<BodyTypeChanged>((event, emit) {
      emit(_mapBodyTypeChangedToState(event, state));
    });

    on<YearChanged>((event, emit) {
      emit(_mapYearChangedToState(event, state));
    });

    on<TransmissionChanged>((event, emit) {
      emit(_mapTransmissionChangedToState(event, state));
    });

    on<FuelTypeChanged>((event, emit) {
      emit(_mapFuelTypeChangedToState(event, state));
    });



    on<CountryOfRegistrationChanged>((event, emit) {
      emit(_mapCountryOfRegistrationChangedToState(event, state));
    });

    on<CityChanged>((event, emit) {
      emit(_mapCityChangedToState(event, state));
    });

    on<RegistrationIdChanged>((event, emit) {
      emit(_mapRegistrationIdChangedToState(event, state));
    });

    on<LicencePlateNumberChanged>((event, emit) {
      emit(_mapLicencePlateNumberChangedToState(event, state));
    });

    on<IssuedDateChanged>((event, emit) {
      emit(_mapIssuedDateChangedToState(event, state));
    });

    on<ExpiredDateChanged>((event, emit) {
      emit(_mapExpiredDateChangedToState(event, state));
    });

    on<AddressLine1Changed>((event, emit) {
      emit(_mapAddressLine1ChangedToState(event, state));
    });

    on<AddressLine2Changed>((event, emit) {
      emit(_mapAddressLine2ChangedToState(event, state));
    });

    on<EmailChanged>((event, emit) {
      emit(_mapEmailChangedToState(event, state));
    });

    on<EditableChanged>((event, emit) {
      emit(_mapEditableChangedToState(event, state));
    });

    on<FormSubmitted>(_mapFormSubmittedToState);
  }

  VehicleProfileState _mapMakeChangedToState(
      MakeChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(make: value);
  }

  VehicleProfileState _mapModelChangedToState(
      ModelChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(model: value);
  }

  VehicleProfileState _mapBodyTypeChangedToState(
      BodyTypeChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(bodyType: value);
  }

  VehicleProfileState _mapYearChangedToState(
      YearChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(year: value);
  }

  VehicleProfileState _mapTransmissionChangedToState(
      TransmissionChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(transmission: value);
  }

  VehicleProfileState _mapFuelTypeChangedToState(
      FuelTypeChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(fuelType: value);
  }

  VehicleProfileState _mapCountryOfRegistrationChangedToState(
      CountryOfRegistrationChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(countryOfRegistration: value);
  }

  VehicleProfileState _mapCityChangedToState(
      CityChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(city: value);
  }

  VehicleProfileState _mapRegistrationIdChangedToState(
      RegistrationIdChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(registrationId: value);
  }

  VehicleProfileState _mapLicencePlateNumberChangedToState(
      LicencePlateNumberChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(registrationId: value);
  }

  VehicleProfileState _mapIssuedDateChangedToState(
      IssuedDateChanged event, VehicleProfileState state) {
    final value = IDateTime.dirty(event.value);
    return state.copyWith(issuedDate: value);
  }

  VehicleProfileState _mapExpiredDateChangedToState(
      ExpiredDateChanged event, VehicleProfileState state) {
    final value = IDateTime.dirty(event.value);
    return state.copyWith(expiredDate: value);
  }

  VehicleProfileState _mapBearerNameChangedToState(
      BearerNameChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(bearerName: value);
  }

  VehicleProfileState _mapAddressLine1ChangedToState(
      AddressLine1Changed event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(addressLine1: value);
  }

  VehicleProfileState _mapAddressLine2ChangedToState(
      AddressLine2Changed event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(addressLine2: value);
  }

  VehicleProfileState _mapEmailChangedToState(
      EmailChanged event, VehicleProfileState state) {
    final value = Name.dirty(event.value);
    return state.copyWith(addressLine2: value);
  }

  VehicleProfileState _mapEditableChangedToState(
      EditableChanged event, VehicleProfileState state) {
    return state.copyWith(
      editable: !state.editable,
    );
  }

  _mapFormSubmittedToState(
    FormSubmitted event,
    Emitter<VehicleProfileState> emit,
  ) async {}

  Future<void> _mapProfileChangedToState(
    ProfileChanged event,
    Emitter<VehicleProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        profile: OptionalFile.dirty(event.value),
      ),
    );
  }
}
