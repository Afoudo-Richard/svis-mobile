import 'package:app/repository/models/permission.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  QueryBuilder<ParseObject>? query;

  PermissionsBloc({this.query, ProfileUser? user}) : super(PermissionsState()) {
    on<FetchPermissionsEvent>(_onPermissionsListFetched);
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }
  void _onPermissionsListFetched(
      FetchPermissionsEvent event, Emitter<PermissionsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PermissionsStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: PermissionsStatus.success,
          items: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.items.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PermissionsStatus.success,
              items: List.of(state.items)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: PermissionsStatus.failure));
    }
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<PermissionsState> emit,
  ) async {
    final searchTerm = event.text;
  }

  Future<List<Permission>> _fetchItems([int startIndex = 0]) async {
    return (await query?.find() ?? <ParseObject>[])
        .map((e) => Permission().clone(e.toJson(full: true)))
        .toList();
  }
}
