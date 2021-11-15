import 'package:app/commons/multi_select_item.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'vehicle_listing_event.dart';
part 'vehicle_listing_state.dart';

class VehicleListingBloc
    extends Bloc<VehicleListingEvent, VehicleListingState> {
  final User user;

  VehicleListingBloc(this.user) : super(VehicleListingState(isSelectingController: MultiSelectController())) {
    on<VehicleListFetched>(_onVehiclesListFetched, transformer: droppable());
  }

  void _onVehiclesListFetched(
      VehicleListFetched event, Emitter<VehicleListingState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == VehicleListStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: VehicleListStatus.success,
          vehicles: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.vehicles.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleListStatus.success,
              vehicles: List.of(state.vehicles)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: VehicleListStatus.failure));
    }
  }

  Future<List<Vehicle>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('user', user);
    query.includeObject(['profile']);
    query.setLimit(20);
    return query.find();
  }
}
