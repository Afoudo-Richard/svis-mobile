import 'package:app/commons/multi_select_item.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'drivers_event.dart';
part 'drivers_state.dart';

class DriversBloc extends Bloc<DriversEvent, DriversState> {
  ProfileUserTypes type;
  final ProfileUser profile;

  DriversBloc({required this.type, required this.profile})
      : super(DriversState()) {
    on<DriversFetch>(_onDriversFetched);
  }

  Future<void> _onDriversFetched(
      DriversEvent event, Emitter<DriversState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DriversStatus.initial) {
        final users = await _fetchUsers();
        if (users.length < 20) {
          return emit(
            state.copyWith(
              status: DriversStatus.succes,
              drivers: users,
              hasReachedMax: true,
            ),
          );
        }
        return emit(
          state.copyWith(
            status: DriversStatus.succes,
            drivers: users,
            hasReachedMax: false,
          ),
        );
      }

      final users = await _fetchUsers(state.drivers.length);

      emit(
        users.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: DriversStatus.succes,
                drivers: List.of(state.drivers)..addAll(users),
                hasReachedMax: false),
      );
    } catch (_) {
      emit(state.copyWith(status: DriversStatus.failure));
    }
  }

  Future<List<ProfileUser?>> _fetchUsers([int startIndex = 0]) async {
    QueryBuilder<ProfileUser> query = QueryBuilder<ProfileUser>(ProfileUser());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('Profile', profile.profile);
    query.whereEqualTo('ProfileUserTypes', type);
    query.includeObject(['ProfileUserTypes', 'User']);
    query.setLimit(20);
    return (await query.find());
  }
}
