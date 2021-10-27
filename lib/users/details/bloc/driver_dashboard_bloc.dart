import 'package:app/repository/models/event_log.dart';
import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'driver_dashboard_event.dart';
part 'driver_dashboard_state.dart';

class DriverDashboardBloc
    extends Bloc<DriverDashboardEvent, DriverDashboardState> {
  final ProfileUser? user;
  DriverDashboardBloc({required this.user})
      : super(DriverDashboardState(user: user ?? ProfileUser())) {
    on<DriverDashboardInit>(_onInit);
    on<FilterEventLog>(_filterLog);
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

  Future<List<EventLog>> _fetchRecentActions() async {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final day = DateTime.now().day;

    final today = DateTime.parse("$year-$month-$day");
    final yerstday = today.subtract(Duration(hours: 72));

    print(today);
    print(yerstday);

    //final yersterday = DateTime().now;
    QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
    query.whereEqualTo('driver', user!.user);
    query.whereLessThanOrEqualTo('createAt', today);
    query.whereGreaterThanOrEqualsTo('createdAt', yerstday);
    return await query.find();
  }

  Future<List<EventLog>> _filter(String currentdate, String range) async {
    switch (range) {
      case "last 24 hours":
        final search =
            DateTime.parse(currentdate).subtract(Duration(hours: 24));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return await query.find();
      case "last week":
        final search = DateTime.parse(currentdate).subtract(Duration(days: 7));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return await query.find();
      case "last month":
        final search = DateTime.parse(currentdate).subtract(Duration(days: 30));
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        query.whereLessThan('createAt', DateTime.parse(currentdate));
        query.whereGreaterThan('createdAt', search);
        return query.find();
      default:
        QueryBuilder<EventLog> query = QueryBuilder<EventLog>(EventLog());
        query.whereEqualTo('driver', user!.user);
        return await query.find();
    }
  }
}
