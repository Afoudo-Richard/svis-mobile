import 'dart:async';
import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final List<ProfileUserTypes>? profileUserTypes;

  CreateProfileBloc({this.profileUserTypes}) : super(CreateProfileState()) {
    on<ProfileChanged>(_mapProfileChangedToState);
    on<NameChanged>(_mapNameChangedToState);
    on<DescriptionChanged>(_mapDescriptionChangedToState);
    on<PhoneNumberChanged>(_mapPhoneNumberChangedToState);
    on<EmailChanged>(_mapEmailChangedToState);
    on<AddressLine1Changed>(_mapAddressLine1ChangedToState);
    on<AddressLine2Changed>(_mapAddressLine2ChangedToState);
    on<StreetChanged>(_mapStreetChangedToState);
    on<ZipCodeChanged>(_mapZipCodeChangedToState);
    on<CityChanged>(_mapCityChangedToState);
    on<StateChanged>(_mapStateChangedToState);
    on<WebSiteChanged>(_mapWebSiteChangedToState);
    on<TaxIdChanged>(_mapTaxIdChangedToState);
    on<RegistrationIdChanged>(_mapRegistrationIdChangedToState);
    on<FormSubmitted>(_mapFormSubmittedToState);
  }

  Future<void> _mapProfileChangedToState(
    ProfileChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        profile: OptionalFile.dirty(event.value),
      ),
    );
  }

  Future<void> _mapNameChangedToState(
    NameChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        name: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapDescriptionChangedToState(
    DescriptionChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        description: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapPhoneNumberChangedToState(
    PhoneNumberChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        phoneNumber: PhoneNumber.dirty(event.value),
      ),
    );
  }

  Future<void> _mapEmailChangedToState(
    EmailChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        email: Email.dirty(event.value),
      ),
    );
  }

  Future<void> _mapAddressLine1ChangedToState(
    AddressLine1Changed event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        addressLine1: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapAddressLine2ChangedToState(
    AddressLine2Changed event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        addressLine2: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapStreetChangedToState(
    StreetChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        street: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapZipCodeChangedToState(
    ZipCodeChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        zipCode: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapCityChangedToState(
    CityChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        city: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapStateChangedToState(
    StateChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        state: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapWebSiteChangedToState(
    WebSiteChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        website: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapTaxIdChangedToState(
    TaxIdChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        taxId: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapRegistrationIdChangedToState(
    RegistrationIdChanged event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        registrationId: Name.dirty(event.value),
      ),
    );
  }

  Future<void> _mapFormSubmittedToState(
    FormSubmitted event,
    Emitter<CreateProfileState> emit,
  ) async {
    print(state.status.isValidated);
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.inProgress(),
        ),
      );

      try {
        ApiResponse response = getApiResponse<Profile>(await (Profile()
              ..companyName = state.name.value
              ..isCompanyProfile = true
              ..description = state.description.value
              ..phoneNumber = state.phoneNumber.value
              ..email = state.email.value
              ..addressLine1 = state.addressLine1.value
              ..addressLine2 = state.addressLine2.value
              ..street = state.street.value
              ..postalCode = state.zipCode.value
              ..city = state.city.value
              ..state = state.state.value
              ..website = state.website.value
              ..taxId = state.taxId.value
              ..profileImage = (state.profile.value != null)
                  ? ParseFile(state.profile.value)
                  : null
              ..registrationId = state.registrationId.value
              ..owner = await ParseUser.currentUser())
            .save());
        if (response.success) {
          var profileUserResponse = getApiResponse<ProfileUser>(
              await (ProfileUser()
                    ..user = await ParseUser.currentUser()
                    ..profile = response.result
                    ..profileUserType = profileUserTypes
                        ?.where((element) => element.name == 'Owner')
                        .first)
                  .save());
          if (profileUserResponse.success) {
            emit(
              state.copyWith(
                submission: fz.FormzSubmission.success(
                  success: profileUserResponse.result,
                ),
              ),
            );
          } else {
            emit(
              state.copyWith(
                submission: fz.FormzSubmission.failure(
                    response.error?.message ?? 'unable to save'),
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.failure(
                  response.error?.message ?? 'unable to save'),
            ),
          );
        }
      } catch (error) {
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.failure(error.toString()),
          ),
        );
      }
    }
  }
}
