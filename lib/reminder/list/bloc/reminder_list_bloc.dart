import 'package:app/repository/models/reminder.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/repository/models/vehicle_service_period.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'reminder_list_event.dart';
part 'reminder_list_state.dart';

class ReminderListBloc extends Bloc<ReminderListEvent, ReminderListState> {
  final Vehicle? vehicle;
  ReminderListBloc(this.vehicle) : super(ReminderListState()) {

    on<ReminderListFetched>(_onReminderListFetched);
  }



  void _onReminderListFetched(ReminderListFetched event, Emitter<ReminderListState> emit) async{
    if (state.hasReachedMax) return;
        try {
      if (state.status == ReminderListStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: ReminderListStatus.success,
          reminders: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.reminders.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ReminderListStatus.success,
              reminders: List.of(state.reminders)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(status: ReminderListStatus.failure));
    }
  }

    Future<List<VehicleServicePeriod>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<VehicleServicePeriod> query = QueryBuilder<VehicleServicePeriod>(VehicleServicePeriod());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('Vehicle', vehicle);
    query.includeObject(['profile', 'user']);
    query.setLimit(20);
    return query.find();
  }

}
