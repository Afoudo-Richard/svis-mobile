import 'dart:async';

import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'vehicle_group_event.dart';
part 'vehicle_group_state.dart';

class VehicleGroupBloc
    extends HydratedBloc<VehicleGroupEvent, VehicleGroupState> {
  VehicleGroupBloc() : super(VehicleGroupState()) {
    on<VehicleGroupFetch>(_mapVehicleGroupFetchToState);
  }

  Future<void> _mapVehicleGroupFetchToState(
    VehicleGroupFetch event,
    Emitter<VehicleGroupState> emit,
  ) async {
    if (state.hasReachedMax) return;
    if (state.status == VehicleGroupStatus.success) {
      emit(state);
    } else {
      try {
        if (state.status == VehicleGroupStatus.initial) {
          final items = await _fetchItems();
          return emit(state.copyWith(
            status: VehicleGroupStatus.success,
            items: items,
            hasReachedMax: true,
          ));
        }
        final posts = await _fetchItems(state.items.length);
        emit(posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: VehicleGroupStatus.success,
                items: List.of(state.items)..addAll(posts),
                hasReachedMax: false,
              ));
      } catch (_) {
        emit(state.copyWith(status: VehicleGroupStatus.failure));
      }
    }
  }

  Future<List<VehicleGroup>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<VehicleGroup> query =
        QueryBuilder<VehicleGroup>(VehicleGroup());
    query.setAmountToSkip(startIndex);
    return query.find();
  }

  @override
  VehicleGroupState? fromJson(Map<String, dynamic> json) {
    try {
      return VehicleGroupState.fromJson(json);
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError(e, s,
      //     reason: 'Unable to convert json to AuthenticationState');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(VehicleGroupState state) {
    try {
      return state.toJson();
    } catch (e, s) {
      // FirebaseCrashlytics.instance
      //     .recordError(e, s, reason: 'Unable to convert state to json');
      return null;
    }
  }
}
