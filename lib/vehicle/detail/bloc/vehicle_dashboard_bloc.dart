import 'dart:async';

import 'package:app/commons/formz.dart';
import 'package:app/repository/models/device.dart';
import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'vehicle_dashboard_event.dart';
part 'vehicle_dashboard_state.dart';

class VehicleDashboardBloc
    extends Bloc<VehicleDashboardEvent, VehicleDashboardState> {
  Vehicle? vehicle;
  VehicleDashboardBloc({required this.vehicle})
      : super(VehicleDashboardState(vehicle: vehicle)) {
    on<FetchLastKnwonLocation>(_onMapFetchLastKnwonLocationToState);
  }

  Future<void> _onMapFetchLastKnwonLocationToState(
    FetchLastKnwonLocation event,
    Emitter<VehicleDashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        lastKnwonStatus: FormzStatus.submissionInProgress,
      ),
    );
    try {
      final lastKnownLocation = await _lastKnown(vehicle: this.vehicle);

      if (lastKnownLocation != null) {
        emit(
          state.copyWith(
            lastKnwonStatus: FormzStatus.submissionSuccess,
            lastKnwon: lastKnownLocation,
            lastConnected: lastKnownLocation.device?.lastConnected,
          ),
        );

        final LiveQuery dLiveQuery = LiveQuery();

        QueryBuilder<Device> dQuery = QueryBuilder<Device>(Device())
          ..whereEqualTo('objectId', lastKnownLocation.device?.objectId);

        Subscription dSubscription = await dLiveQuery.client.subscribe(dQuery);

        dSubscription.on(LiveQueryEvent.update, (Device value) {
          emit(
            state.copyWith(
              lastKnwonStatus: FormzStatus.submissionSuccess,
              lastConnected: value.lastConnected,
            ),
          );
        });

        final LiveQuery tLiveQuery = LiveQuery();

        QueryBuilder<Track> tQuery = QueryBuilder<Track>(Track())
          ..whereEqualTo('asset', vehicle);

        Subscription tSubscription = await tLiveQuery.client.subscribe(tQuery);

        tSubscription.on(LiveQueryEvent.create, (Track? value) {
          emit(
            state.copyWith(
              lastKnwonStatus: FormzStatus.submissionSuccess,
              lastKnwon: value,
              lastConnected: value?.device?.lastConnected,
            ),
          );
        });
      } else {
        throw 'no last known';
      }
    } catch (e) {
      emit(
        state.copyWith(
          lastKnwonStatus: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  Future<Track?>? _lastKnown({Vehicle? vehicle}) async {
    QueryBuilder<Track> tQuery = QueryBuilder<Track>(Track());
    tQuery.orderByDescending('createdAt');
    tQuery.whereNotEqualTo('geoCoordinate', null);
    tQuery.includeObject(['device']);
    tQuery.whereEqualTo('asset', vehicle);
    tQuery.setLimit(1);
    return (await tQuery.find()).first;
  }
}
