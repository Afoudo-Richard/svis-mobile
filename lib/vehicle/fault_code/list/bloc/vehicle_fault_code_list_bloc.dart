import 'package:app/repository/models/trouble_code.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/repository/models/vehicle_trouble_code.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'vehicle_fault_code_list_event.dart';
part 'vehicle_fault_code_list_state.dart';

class VehicleFaultCodeListBloc
    extends Bloc<VehicleFaultCodeEvent, VehicleFaultCodeListState> {
      final Vehicle? vehicle;
  VehicleFaultCodeListBloc({required this.vehicle}) : super(VehicleFaultCodeListState(vehicle: vehicle ?? Vehicle())) {
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
          vehicleTroubleCodes: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.vehicleTroubleCodes.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleFaultCodeListStatus.success,
              vehicleTroubleCodes: List.of(state.vehicleTroubleCodes)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: VehicleFaultCodeListStatus.failure));
    }
  }

    Future<List<VehicleTroubleCode>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<VehicleTroubleCode> query = QueryBuilder<VehicleTroubleCode>(VehicleTroubleCode());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('vehicle', vehicle );
    query.includeObject(['troubleCode', 'troubleCodeType']);
    query.setLimit(20);
    return query.find();
  }
}
