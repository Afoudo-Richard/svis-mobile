import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';


part 'fault_code_event.dart';
part 'fault_code_state.dart';
const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class FaultCodeBloc extends Bloc<FaultCodeEvent, FaultCodeState> {
  FaultCodeBloc() : super(FaultCodeState()) {
    on<FaultCodeFetch>(_onFaultCodeFetch);
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }


    void _onFaultCodeFetch(
      FaultCodeFetch event, Emitter<FaultCodeState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == FaultCodeListStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: FaultCodeListStatus.success,
          faultCodes: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.faultCodes.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: FaultCodeListStatus.success,
              faultCodes: List.of(state.faultCodes)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: FaultCodeListStatus.failure));
    }
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<FaultCodeState> emit,
  ) async {
    emit(state.copyWith(searchText: event.text));
    final searchTerm = event.text;
  }

  Future<List<TroubleCode>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<TroubleCode> query = QueryBuilder<TroubleCode>(TroubleCode());
    query.setAmountToSkip(startIndex);
    query.includeObject(['ProfileUserTypes', 'User']);
    query.setLimit(20);
    return query.find();
  }

    Future<List<TroubleCode>> _Search(String searchTerm) async {
    QueryBuilder<TroubleCode> query = QueryBuilder<TroubleCode>(TroubleCode());
    query.includeObject(['ProfileUserTypes', 'User']);
    query.setLimit(20);
    return query.find();
  }
}
