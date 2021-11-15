import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';
import 'package:app/commons/formz.dart' as fz;

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({User? user})
      : super(
          UserProfileState(
            //profile: OptionalFile.dirty(user.profile.),
            firstName: Name.dirty(user?.firstName ?? ''),
            lastName: Name.dirty(user?.lastName ?? ''),
            dateOfBirth: IDateTime.dirty(user?.dateOfBirth),
            gender: Name.dirty(user?.gender ?? ''),
            // timeZone: Name.dirty(user?.timeZone ?? ''),
            email: Name.dirty(user?.emailAddress ?? ''),
            phoneNumber: Name.dirty(user?.phoneNumber ?? ''),
            addressLine1: Name.dirty(user?.addressLine1 ?? ''),
            addressLine2: Name.dirty(user?.addressLine2 ?? ''),
            city: Name.dirty(user?.city ?? ''),
            state: Name.dirty(user?.state ?? ''),
            countryOfRegistration: Name.dirty(user?.country ?? ''),
            // region: Name.dirty(user?.region ?? ''),
          ),
        ) {
          //print(user!.profile!.file.toString());
    // on<UserProfileEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

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

  UserProfileState _mapEditChangedToState(
    EditChanged event,
    UserProfileState state,
  ) {
    return state.copyWith(
      editable: !state.editable,
    );
  }

  UserProfileState _mapFirstNameChangedToState(
    FirstNameChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      firstName: value,
    );
  }

  UserProfileState _mapLastNameChangedToState(
    LastNameChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      lastName: value,
    );
  }

  UserProfileState _mapDateOfBirthChangedToState(
    DateOfBirthChanged event,
    UserProfileState state,
  ) {
    final value = IDateTime.dirty(event.value);
    return state.copyWith(
      dateOfBirth: value,
    );
  }

  UserProfileState _mapGenderChangedToState(
    GenderChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      gender: value,
    );
  }

  UserProfileState _mapTimeZoneChangedToState(
    TimeZoneChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      // timeZone: value,
    );
  }

  UserProfileState _mapEmailChangedToState(
    EmailChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      email: value,
    );
  }

  UserProfileState _mapPhoneNumberChangedToState(
    PhoneNumberChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      phoneNumber: value,
    );
  }

  UserProfileState _mapAddressLine1ChangedToState(
    AddressLine1Changed event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      addressLine1: value,
    );
  }

  UserProfileState _mapAddressLine2ChangedToState(
    AddressLine2Changed event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      addressLine2: value,
    );
  }

  UserProfileState _mapCityChangedToState(
    CityChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      city: value,
    );
  }

  UserProfileState _mapStateChangedToState(
    StateChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      state: value,
    );
  }

  UserProfileState _mapCountryOfRegistrationChangedToState(
    CountryOfRegistrationChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      countryOfRegistration: value,
    );
  }

  UserProfileState _mapRegionChangedToState(
    RegionChanged event,
    UserProfileState state,
  ) {
    final value = Name.dirty(event.value);
    return state.copyWith(
      // region: value,
    );
  }

    Future<void> _mapProfileChangedToState(
    ProfileChanged event,
    Emitter<UserProfileState> emit,
  ) async {
    print(event.value.toString());
    emit(
      state.copyWith(
        profile: OptionalFile.dirty(event.value),
      ),
    );
  }


  _mapFormSubmittedToState(
    UserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    print(state.status.isValidated);
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.inProgress(),
        ),
      );

      try {
        print("Is trying to update");
        ParseFile profileImage = ParseFile(state.profile.value);
        //profileImage.save();
        print(state.profile.value.toString());
        ApiResponse response =
            getApiResponse<User>(await ((await ParseUser.currentUser() as User)
                  ..firstName = state.firstName.value
                  ..lastName = state.lastName.value
                  ..dateOfBirth = state.dateOfBirth.value
                  ..gender = state.gender.value
                  ..email = state.email.value
                  ..phoneNumber = state.phoneNumber.value
                  ..addressLine1 = state.addressLine1.value
                  ..addressLine2 = state.addressLine2.value
                  ..city = state.city.value
                  ..state = state.state.value
                  ..country = state.countryOfRegistration.value
                  ..profile = profileImage
                  /* ..region = state.region.value */)
                .save());
        if (response.success) {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.success(
                success: response.result,
              ),
              editable: false,
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
