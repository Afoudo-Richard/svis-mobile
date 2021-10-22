import 'package:app/commons/multi_select_item.dart';
import 'package:app/driver_dashboard/models/driver_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'drivers_event.dart';
part 'drivers_state.dart';

class DriversBloc extends Bloc<DriversEvent, DriversState> {
  DriversBloc() : super(DriversState()) {
    on<DriversFetch>(_onDriversFetched);
    on<DeleteUsers>(_onDeleteUsers);
  }

  Future<void> _onDriversFetched(
      DriversEvent event, Emitter<DriversState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DriversStatus.initial) {
        final users = await _fetchUsers();
        return emit(
          state.copyWith(
            status: DriversStatus.succes,
            drivers: users,
            hasReachedMax: false,
          ),
        );
      }

      final users = await _fetchUsers();

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

  Future<List<User>> _fetchUsers([int startIndex = 0]) async {
    QueryBuilder<User> query = QueryBuilder<User>(User(null, null, null));
    query.setAmountToSkip(startIndex);
    return query.find();
  }

  _onDeleteUsers(DriversEvent event, Emitter<DriversState> emit) {
    var list = state.isSelectingController.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b)); //reoder from biggest number, so it wont error
    list.forEach((element) {
      state.drivers.removeAt(element);
    });

    state.isSelectingController.set(state.drivers.length);
  }
}
