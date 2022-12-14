import 'package:app/commons/multi_select_item.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';

part 'drivers_event.dart';
part 'drivers_state.dart';

const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class DriversBloc extends Bloc<DriversEvent, DriversState> {
  ProfileUserTypes type;
  final ProfileUser profile;

  DriversBloc({required this.type, required this.profile})
      : super(DriversState(isSelectingController: MultiSelectController())) {
    on<DriversFetch>(_onDriversFetched);
    on<DeleteSelected>(_onDeleteSected);
    on<ItemSelected>(_onItemSelected);
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  Future<void> _onDriversFetched(
      DriversEvent event, Emitter<DriversState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DriversStatus.initial) {
        final users = await _fetchUsers();
        state.isSelectingController.set(users.length);
        if (users.length < 20) {
          return emit(
            state.copyWith(
                status: DriversStatus.succes,
                drivers: users,
                hasReachedMax: true,
                isSelectingController: state.isSelectingController),
          );
        }
        return emit(
          state.copyWith(
              status: DriversStatus.succes,
              drivers: users,
              hasReachedMax: false,
              isSelectingController: state.isSelectingController),
        );
      }

      final users = await _fetchUsers(state.drivers.length);
      state.isSelectingController.set(state.drivers.length + users.length);
      emit(
        users.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: DriversStatus.succes,
                drivers: List.of(state.drivers)..addAll(users),
                hasReachedMax: false,
                isSelectingController: state.isSelectingController),
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

  void _onTextChanged(
    TextChanged event,
    Emitter<DriversState> emit,
  ) async {
    final searchTerm = event.text;
  }

  void _onDeleteSected(DeleteSelected event, Emitter<DriversState> emit) {
    print("deleting items selected");
  }

  void _onItemSelected(ItemSelected event, Emitter<DriversState> emit) {
    state.isSelectingController.toggle(event.index);

    //state.isSelectingController.isSelecting = true;
    emit(state.copyWith(isSelectingController: state.isSelectingController));

    print(state.isSelectingController.isSelecting);
    print(state.isSelectingController.selectedIndexes);
    print(state.isSelectingController.listLength);
    
  }

}
