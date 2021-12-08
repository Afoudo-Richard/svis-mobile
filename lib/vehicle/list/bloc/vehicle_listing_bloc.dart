import 'dart:async';

import 'package:app/commons/multi_select_item.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:collection/collection.dart';

part 'vehicle_listing_event.dart';
part 'vehicle_listing_state.dart';

const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class VehicleListingBloc
    extends Bloc<VehicleListingEvent, VehicleListingState> {
  final ProfileUser? profile;

  VehicleListingBloc(this.profile)
      : super(VehicleListingState(
            isSelectingController: MultiSelectController())) {
    on<VehicleListFetched>(_onVehiclesListFetched, transformer: droppable());
    on<UpdateVehicleList>(_onUpdateVehicleList);
    on<TextChanged>(_onVehicleSearchChanged, transformer: debounce(_duration));
  }

  void _onVehiclesListFetched(
      VehicleListFetched event, Emitter<VehicleListingState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == VehicleListStatus.initial) {
        final items = await _fetchItems();
        print(items);
        return emit(state.copyWith(
          status: VehicleListStatus.success,
          vehicles: items,
          vehiclesCopy: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.vehicles.length);
      print(items);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleListStatus.success,
              vehicles: List.of(state.vehicles)..addAll(items),
              vehiclesCopy: List.of(state.vehicles)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: VehicleListStatus.failure));
    }
  }

  Future<List<Vehicle>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('profile', profile?.profile);
    query.includeObject(['profile', 'user']);
    query.setLimit(20);
    return query.find();
  }

  void _onVehicleSearchChanged(
      TextChanged event, Emitter<VehicleListingState> emit) {
    emit(state.copyWith(
      status: VehicleListStatus.initial,
    ));

    String searchTerm = event.text;
    List<Vehicle> items = state.vehiclesCopy.where((x) {
      return x.name!.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
    items = searchTerm.isEmpty ? state.vehiclesCopy : items;
    emit(state.copyWith(
      status: VehicleListStatus.success,
      vehicles: items,
    ));
  }

  Future<void> _onUpdateVehicleList(
    UpdateVehicleList event,
    Emitter<VehicleListingState> emit,
  ) async {
    var vehicle = state.vehicles.firstWhereOrNull((element) {
      return element.objectId == event.value?.objectId;
    });
    emit(state.copyWith(
      status: VehicleListStatus.success,
      vehicles: vehicle != null
          ? (List.of(state.vehicles).map((element) {
              if (element.objectId == event.value?.objectId) {
                return event.value as Vehicle;
              } else {
                return element;
              }
            }).toList())
          : (List.of(state.vehicles)..add(event.value as Vehicle)),
    ));
  }
}
