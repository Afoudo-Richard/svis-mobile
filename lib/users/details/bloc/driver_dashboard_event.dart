part of 'driver_dashboard_bloc.dart';

abstract class DriverDashboardEvent extends Equatable {
  const DriverDashboardEvent();

  @override
  List<Object> get props => [];
}

class DriverDashboardInit extends DriverDashboardEvent {
  ProfileUser? user;
  DriverDashboardInit({required this.user});
}

class FilterEventLog extends DriverDashboardEvent {
  FilterEventLog(this.current, this.range);
  final String current;
  final String range;

    @override
  List<Object> get props => [current];
}


class FilterByDateTime extends DriverDashboardEvent {
  FilterByDateTime({required this.dateFrom, required this.dateTo, required this.timeFrom, required this.timeTo});
  
  final String dateFrom;
  final String dateTo;
  final String timeFrom;
  final String timeTo;

    @override
  List<Object> get props => [dateFrom, dateTo, timeFrom, timeTo];
}