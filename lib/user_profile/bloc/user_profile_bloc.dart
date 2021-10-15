import 'package:app/commons/forms/forms.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:app/commons/formz.dart' as fz;

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({User? user})
      : super(
          UserProfileState(
            firstName: Name.dirty(user?.firstName ?? ''),
            lastName: Name.dirty(user?.lastName ?? ''),
            dateOfBirth: Name.dirty(user?.dateOfBirth ?? ''),
            gender: Name.dirty(user?.gender ?? ''),
            timeZone: Name.dirty(user?.timeZone ?? ''),
            email: Name.dirty(user?.emailAddress ?? ''),
            phoneNumber: Name.dirty(user?.phoneNumber ?? ''),
            addressLine1: Name.dirty(user?.addressLine1 ?? ''),
            addressLine2: Name.dirty(user?.addressLine2 ?? ''),
            city: Name.dirty(user?.city ?? ''),
            state: Name.dirty(user?.state ?? ''),
            countryOfRegistration: Name.dirty(user?.country ?? ''),
            region: Name.dirty(user?.region ?? ''),
          ),
        ) {
    on<UserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
