import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';
part 'role_event.dart';
part 'role_state.dart';

const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  QueryBuilder<ParseObject>? query;
  RoleBloc({this.query}) : super(RoleState()) {
    on<FetchRoleEvent>(_onRoleListFetched);
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }
  void _onRoleListFetched(FetchRoleEvent event, Emitter<RoleState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == RoleStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: RoleStatus.success,
          items: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.items.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: RoleStatus.success,
              items: List.of(state.items)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: RoleStatus.failure));
    }
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<RoleState> emit,
  ) async {
    final searchTerm = event.text;
  }

  Future<List<SvisRole>> _fetchItems([int startIndex = 0]) async {
    return (await query?.find() ?? [])
        .map((e) => SvisRole().clone(e.toJson()))
        .toList();
  }
}
