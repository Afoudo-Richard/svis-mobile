import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  ProfileUser? profile;

  AddUserBloc({this.profile}) : super(AddUserState()) {
    on<ProfileChanged>(_mapProfileChangedToState);
    on<FirstNameChanged>((event, emit) {
      emit(_mapFirstNameChangedToState(event, state));
    });
    on<EditChanged>((event, emit) {
      emit(_mapEditChangedToState(event, state));
    });
    on<LastNameChanged>((event, emit) {
      emit(_mapLastNameChangedToState(event, state));
    });
    on<DateOfBirthChanged>((event, emit) {
      emit(_mapDateOfBirthChangedToState(event, state));
    });
    on<GenderChanged>((event, emit) {
      emit(_mapGenderChangedToState(event, state));
    });
    on<TimeZoneChanged>((event, emit) {
      emit(_mapTimeZoneChangedToState(event, state));
    });
    on<EmailChanged>((event, emit) {
      emit(_mapEmailChangedToState(event, state));
    });
    on<PhoneNumberChanged>((event, emit) {
      emit(_mapPhoneNumberChangedToState(event, state));
    });
    on<AddressLine1Changed>((event, emit) {
      emit(_mapAddressLine1ChangedToState(event, state));
    });
    on<AddressLine2Changed>((event, emit) {
      emit(_mapAddressLine2ChangedToState(event, state));
    });
    on<CityChanged>((event, emit) {
      emit(_mapCityChangedToState(event, state));
    });
    on<StateChanged>((event, emit) {
      emit(_mapStateChangedToState(event, state));
    });
    on<CountryOfRegistrationChanged>((event, emit) {
      emit(_mapCountryOfRegistrationChangedToState(event, state));
    });
    on<RegionChanged>((event, emit) {
      emit(_mapRegionChangedToState(event, state));
    });
    on<FormSubmitted>(_mapFormSubmittedToState);
  }

  Future<void> _mapProfileChangedToState(
    ProfileChanged event,
    Emitter<AddUserState> emit,
  ) async {
    emit(
      state.copyWith(
        profile: OptionalFile.dirty(event.value),
      ),
    );
  }

  AddUserState _mapEditChangedToState(
    EditChanged event,
    AddUserState state,
  ) {
    return state.copyWith(
      editable: !state.editable,
    );
  }

  AddUserState _mapFirstNameChangedToState(
    FirstNameChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      firstName: value,
    );
  }

  AddUserState _mapLastNameChangedToState(
    LastNameChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      lastName: value,
    );
  }

  AddUserState _mapDateOfBirthChangedToState(
    DateOfBirthChanged event,
    AddUserState state,
  ) {
    final value = IDateTime.dirty(event.value);
    return state.copyWith(
      dateOfBirth: value,
    );
  }

  AddUserState _mapGenderChangedToState(
    GenderChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      gender: value,
    );
  }

  AddUserState _mapTimeZoneChangedToState(
    TimeZoneChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      timeZone: value,
    );
  }

  AddUserState _mapEmailChangedToState(
    EmailChanged event,
    AddUserState state,
  ) {
    final value = Email.dirty(event.value);
    return state.copyWith(
      email: value,
    );
  }

  AddUserState _mapPhoneNumberChangedToState(
    PhoneNumberChanged event,
    AddUserState state,
  ) {
    final value = PhoneNumber.dirty(event.value);
    return state.copyWith(
      phoneNumber: value,
    );
  }

  AddUserState _mapAddressLine1ChangedToState(
    AddressLine1Changed event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      addressLine1: value,
    );
  }

  AddUserState _mapAddressLine2ChangedToState(
    AddressLine2Changed event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      addressLine2: value,
    );
  }

  AddUserState _mapCityChangedToState(
    CityChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      city: value,
    );
  }

  AddUserState _mapStateChangedToState(
    StateChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      state: value,
    );
  }

  AddUserState _mapCountryOfRegistrationChangedToState(
    CountryOfRegistrationChanged event,
    AddUserState state,
  ) {
    final value = OptionalName.dirty(event.value);
    return state.copyWith(
      countryOfRegistration: value,
    );
  }

  AddUserState _mapRegionChangedToState(
    RegionChanged event,
    AddUserState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
        // region: value,
        );
  }

  _mapFormSubmittedToState(
    AddUserEvent event,
    Emitter<AddUserState> emit,
  ) async {
    print(state.status.isValidated);
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.inProgress(),
        ),
      );

      try {
        final ParseCloudFunction function = ParseCloudFunction('register');
        var profileImage = getApiResponse<ParseFile>(
            await ParseFile(state.profile.value).save());
        final Map<String, dynamic> params = <String, dynamic>{
          'email': state.email.value,
          'username': state.email.value,
          'password': 'Pen!@123${Uuid().v4().toString()}',
          'firstName': state.firstName.value,
          'lastName': state.lastName.value,
          'profileID': profile?.profile?.objectId,
          'phoneNumber': state.phoneNumber.value,
          'addressLine1': state.addressLine1.value,
          'addressLine2': state.addressLine2.value,
          'city': state.city.value,
          'state': state.state.value,
          'country': state.countryOfRegistration.value,
          'gender': state.gender.value,
          'dateOfBirth': state.dateOfBirth.value.toString(),
          'parseFile': profileImage.result,
        };
        ApiResponse response =
            getApiResponse<User>(await function.execute(parameters: params));
        if (response.success) {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.success(
                success: User(null, null, null).fromJson(response.result),
              ),
              editable: false,
            ),
          );
        } else {
          throw response.error ?? 'unable to save';
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
