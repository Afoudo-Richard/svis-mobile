import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';

part 'groups_event.dart';
part 'groups_state.dart';

const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  ProfileUser user;
  GroupsBloc({required this.user}) : super(GroupsState()) {
    on<FetchGroupsEvent>(_onGroupsListFetched);
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }
  void _onGroupsListFetched(
      FetchGroupsEvent event, Emitter<GroupsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == GroupsStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: GroupsStatus.success,
          items: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.items.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: GroupsStatus.success,
              items: List.of(state.items)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: GroupsStatus.failure));
    }
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<GroupsState> emit,
  ) async {
    final searchTerm = event.text;
  }

  Future<List<ProfileUserGroup>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<ProfileUserGroup> query =
        QueryBuilder<ProfileUserGroup>(ProfileUserGroup());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('profile', user.profile);
    query.whereEqualTo('user', await ParseUser.currentUser());
    query.includeObject(['group']);
    return query.find();
  }
}
