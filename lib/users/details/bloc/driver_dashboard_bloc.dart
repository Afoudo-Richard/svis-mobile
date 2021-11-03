import 'package:app/repository/models/event_log.dart';
import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'driver_dashboard_event.dart';
part 'driver_dashboard_state.dart';

class DriverDashboardBloc
    extends Bloc<DriverDashboardEvent, DriverDashboardState> {
  final ProfileUser? user;
  DriverDashboardBloc({required this.user})
      : super(DriverDashboardState(user: user ?? ProfileUser())) {
    on<DriverDashboardInit>(_onInit);
    on<FilterEventLog>(_filterLog);
    on<FilterByDateTime>(_filterByDateTime);
  }

  void _onInit(DriverDashboardEvent event, Emitter emit) async {
    try {
      if (state.recentActionStatus == RecentActionStatus.loading) {
        final recentActions = await _fetchRecentActions();
        emit(state.copyWith(
            recentActionStatus: RecentActionStatus.success,
            recentActions: recentActions));
      }
    } catch (e) {
      emit(state.copyWith(recentActionStatus: RecentActionStatus.failure));
    }
  }

  void _filterLog(FilterEventLog event, Emitter emit) async {
    emit(state.copyWith(
      recentActionStatus: RecentActionStatus.loading,
    ));

    try {
      print(state.recentActionStatus);

      final filteredLog = await _filter(event.current, event.range);

      emit(state.copyWith(
          recentActionStatus: RecentActionStatus.success,
          recentActions: filteredLog));
    } catch (e) {
      emit(state.copyWith(
        recentActionStatus: RecentActionStatus.failure,
      ));
    }
  }

  void _filterByDateTime(FilterByDateTime event, Emitter emit) async {
    emit(state.copyWith(
      recentActionStatus: RecentActionStatus.loading,
    ));

    try {
      final filteredLog = await _dateTimeFilter(event);

      emit(state.copyWith(
          recentActionStatus: RecentActionStatus.success,
          recentActions: filteredLog));
    } catch (e) {
      emit(state.copyWith(
        recentActionStatus: RecentActionStatus.failure,
      ));
    }
  }

  Future<List<EventLog>> _fetchRecentActions() async {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final day = DateTime.now().day;

    final today = DateTime.parse("$year-$month-$day");
    final yerstday = today.subtract(Duration(hours: 72));

    print(today);
    print(yerstday);

    QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
    query.whereEqualTo('driver', user!.user);
    query.whereLessThanOrEqualTo('createAt', today);
    query.whereGreaterThanOrEqualsTo('createdAt', yerstday);

    
    return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
  }

  Future<List<EventLog>> _filter(String currentdate, String range) async {
    switch (range) {
      case "last 24 hours":
        final search =
            DateTime.parse(currentdate).subtract(Duration(hours: 24));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createdAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
      case "last week":
        final search = DateTime.parse(currentdate).subtract(Duration(days: 7));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createdAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
      case "last month":
        final search = DateTime.parse(currentdate).subtract(Duration(days: 30));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createdAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
      case "last year":
        final search = DateTime.parse(currentdate).subtract(Duration(days: 365));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createdAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
      default:
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
    }
  }

  Future<List<EventLog>> _dateTimeFilter(FilterByDateTime event) async {
    final dateTimeFrom =
        DateTime.parse('${event.dateFrom} ${event.timeFrom}'.trim()).toUtc();
    final dateTimeTo = DateTime.parse('${event.dateTo} ${event.timeTo}'.trim()).toUtc();


    print(dateTimeFrom);
    print(dateTimeTo);

    QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
    query.whereEqualTo('driver', user!.user);
    query.whereGreaterThanOrEqualsTo('createdAt', dateTimeFrom);
    query.whereLessThanOrEqualTo('createdAt', dateTimeTo);
    


    return (await query.find())
        .map((e) => EventLog().clone(e.toJson(full: true)))
        .toList();
  }


}
