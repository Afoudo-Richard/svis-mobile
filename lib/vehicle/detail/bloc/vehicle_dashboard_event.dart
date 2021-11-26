part of 'vehicle_dashboard_bloc.dart';

abstract class VehicleDashboardEvent extends Equatable {
  const VehicleDashboardEvent();

  @override
  List<Object> get props => [];
}

class FetchLastKnwonLocation extends VehicleDashboardEvent {}
