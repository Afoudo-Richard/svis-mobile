import 'package:app/repository/models/trouble_code.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'vehicle_fault_code_list_event.dart';
part 'vehicle_fault_code_list_state.dart';

class VehicleFaultCodeListBloc
    extends Bloc<VehicleFaultCodeEvent, VehicleFaultCodeListState> {
  VehicleFaultCodeListBloc() : super(VehicleFaultCodeListState()) {
    on<VehicleFaultCodeFetch>(_onFaultCodeFetch);
  }

  void _onFaultCodeFetch(
      VehicleFaultCodeFetch event, Emitter<VehicleFaultCodeListState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == VehicleFaultCodeListStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: VehicleFaultCodeListStatus.success,
          faultCodes: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.faultCodes.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleFaultCodeListStatus.success,
              faultCodes: List.of(state.faultCodes)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: VehicleFaultCodeListStatus.failure));
    }
  }

    Future<List<TroubleCode>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<TroubleCode> query = QueryBuilder<TroubleCode>(TroubleCode());
    query.setAmountToSkip(startIndex);
    query.includeObject(['ProfileUserTypes', 'User']);
    query.setLimit(20);
    return query.find();
  }
}
