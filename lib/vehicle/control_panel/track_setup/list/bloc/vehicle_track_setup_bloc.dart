import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/repository/models/vehicle_track_setup.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'vehicle_track_setup_event.dart';
part 'vehicle_track_setup_state.dart';

const _duration = const Duration(milliseconds: 300);
const _querylimit = 8;

class VehicleTrackSetupBloc
    extends Bloc<VehicleTrackSetupEvent, VehicleTrackSetupState> {

      final Vehicle? vehicle;
      
  VehicleTrackSetupBloc(this.vehicle) : super(VehicleTrackSetupState()) {
    on<VehicleTrackSetupFetch>(_onVehiclesTrackSetupListFetch,
        transformer: droppable());
  }

  void _onVehiclesTrackSetupListFetch(VehicleTrackSetupFetch event,
      Emitter<VehicleTrackSetupState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == VehicleTrackSetupListStatus.initial ||
          state.status == VehicleTrackSetupListStatus.failure) {
        if (state.status == VehicleTrackSetupListStatus.failure) {
          emit(state.copyWith(
            status: VehicleTrackSetupListStatus.initial,
          ));
        }

        final items = await _fetchItems();

        if (items.length < _querylimit) {
          return emit(state.copyWith(
            status: VehicleTrackSetupListStatus.success,
            vehicleTrackSetups: items,
            hasReachedMax: true,
          ));
        }

        return emit(state.copyWith(
          status: VehicleTrackSetupListStatus.success,
          vehicleTrackSetups: items,
          hasReachedMax: false,
        ));
      }

      final items = await _fetchItems(state.vehicleTrackSetups.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleTrackSetupListStatus.success,
              vehicleTrackSetups: List.of(state.vehicleTrackSetups)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(status: VehicleTrackSetupListStatus.failure));
    }
  }

  Future<List<VehicleTrackSetup>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<VehicleTrackSetup> query = QueryBuilder<VehicleTrackSetup>(VehicleTrackSetup());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('vehicle', vehicle);
    query.includeObject(['vehicle', 'owner', 'profile', 'trackSetup', 'features']);
    query.setLimit(_querylimit);
    return query.find();
  }
}
