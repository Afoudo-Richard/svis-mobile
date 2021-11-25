import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'vehicle_driver_assigned_event.dart';
part 'vehicle_driver_assigned_state.dart';

class VehicleDriverAssignedBloc
    extends Bloc<VehicleDriverAssignedEvent, VehicleDriverAssignedState> {
      ProfileUser? profile;
  VehicleDriverAssignedBloc(this.profile): super(VehicleDriverAssignedState()) {
    on<VehicleDriverAssigedListFetched>(_onVehicleDriverAssigedListFetched);
  }

  void _onVehicleDriverAssigedListFetched(
      VehicleDriverAssigedListFetched event, Emitter<VehicleDriverAssignedState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == VehicleDriverAssignedListStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: VehicleDriverAssignedListStatus.success,
          profileUsers: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.profileUsers.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleDriverAssignedListStatus.success,
              profileUsers: List.of(state.profileUsers)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: VehicleDriverAssignedListStatus.failure));
    }
  }

  Future<List<ProfileUser>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<ProfileUser> query = QueryBuilder<ProfileUser>(ProfileUser());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('profile', profile!.profile);
    query.includeObject(['profile']);
    query.setLimit(20);
    return query.find();
  }
}
