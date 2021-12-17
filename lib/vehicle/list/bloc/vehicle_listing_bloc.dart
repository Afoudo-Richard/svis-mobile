import 'dart:async';
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
const _querylimit = 8;

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class VehicleListingBloc
    extends Bloc<VehicleListingEvent, VehicleListingState> {
  final ProfileUser? profile;

  VehicleListingBloc(this.profile) : super(VehicleListingState()) {
    on<VehicleListFetched>(_onVehiclesListFetched, transformer: droppable());
    on<UpdateVehicleList>(_onUpdateVehicleList);
    on<TextChanged>(_onVehicleSearch, transformer: debounce(_duration));
    on<DeleteSelected>(_onDeleteItems);
    on<ArchiveSelected>(_onArchieveItems);
  }

  void _onVehiclesListFetched(
      VehicleListFetched event, Emitter<VehicleListingState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == VehicleListStatus.initial ||
          state.status == VehicleListStatus.failure) {
        if (state.status == VehicleListStatus.failure) {
          emit(state.copyWith(
            status: VehicleListStatus.initial,
          ));
        }

        final items = await _fetchItems();

        if (items.length < _querylimit) {
          return emit(state.copyWith(
            status: VehicleListStatus.success,
            vehicles: items,
            vehiclesCopy: items,
            hasReachedMax: true,
          ));
        }

        return emit(state.copyWith(
          status: VehicleListStatus.success,
          vehicles: items,
          vehiclesCopy: items,
          hasReachedMax: false,
        ));
      }

      final items = await _fetchItems(state.vehicles.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: VehicleListStatus.success,
              vehicles: List.of(state.vehicles)..addAll(items),
              vehiclesCopy: List.of(state.vehicles)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(status: VehicleListStatus.failure));
    }
  }

  Future<List<Vehicle>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('profile', profile?.profile);
    query.includeObject(['profile', 'user']);
    query.setLimit(_querylimit);
    return query.find();
  }

  void _onVehicleSearch(
      TextChanged event, Emitter<VehicleListingState> emit) async {
    try {
      emit(state.copyWith(
        isSearching: true,
      ));

      final items = await _searchItems(event.text);

      if (event.text == "") {
        return emit(state.copyWith(
            status: VehicleListStatus.success,
            vehicles: items,
            vehiclesCopy: items,
            hasReachedMax: false,
            isSearching: false));
      }
      return emit(state.copyWith(
        status: VehicleListStatus.success,
        vehicles: items,
        vehiclesCopy: items,
        hasReachedMax: true,
        isSearching: false,
      ));
    } catch (e) {
      emit(state.copyWith(status: VehicleListStatus.failure));
    }
  }

  Future<List<Vehicle>> _searchItems(String searchText) async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.whereEqualTo('profile', profile?.profile);
    query.whereContains('name', searchText);
    query.includeObject(['profile', 'user']);
    query.setLimit(_querylimit);
    return query.find();
  }

/*  
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
*/

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

  void _onDeleteItems(
    DeleteSelected event,
    Emitter<VehicleListingState> emit,
  ) async {
    emit(state.copyWith(
        status: VehicleListStatus.initial, hasReachedMax: false));
    var responses = await _deleteItems(event.items);

    List<ParseResponse> _success = [];
    List<ParseResponse> _failed = [];

    responses?.forEach((response) {
      if (response.success) {
        _success.add(response);
      } else {
        _failed.add(response);
      }
    });

    if (_success.isNotEmpty) {
      emit(state.copyWith(successResponses: _success));
    } else if (_failed.isNotEmpty) {
      emit(state.copyWith(failedResponses: _failed));
    }

    add(VehicleListFetched());
  }

  Future<List<ParseResponse>?> _deleteItems(List items) async {
    var _requests = items.map((item) {
      return (item as Vehicle).delete();
    }).toList();

    return await Future.wait(_requests);
  }

  void _onArchieveItems(
    ArchiveSelected event,
    Emitter<VehicleListingState> emit,
  ) async {
    emit(state.copyWith(
        status: VehicleListStatus.initial, hasReachedMax: false));

    var responses = await _archiveItems(event.items);
    List<ParseResponse> _success = [];
    List<ParseResponse> _failed = [];

    responses?.forEach((response) {
      if (response.success) {
        _success.add(response);
      } else {
        _failed.add(response);
      }
    });

    if (_success.isNotEmpty) {
      emit(state.copyWith(successResponses: _success));
    } else if (_failed.isNotEmpty) {
      emit(state.copyWith(failedResponses: _failed));
    }

    add(VehicleListFetched());
  }

  Future<List<ParseResponse>?> _archiveItems(List items) async {
    var _requests = items.map((item) {
      item..set('archiveStatus', 'ARCHIVED');
      return (item as Vehicle).save();
    });

    return await Future.wait(_requests);
  }
}
