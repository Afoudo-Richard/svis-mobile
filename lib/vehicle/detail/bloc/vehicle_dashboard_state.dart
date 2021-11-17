part of 'vehicle_dashboard_bloc.dart';

class VehicleDashboardState extends Equatable {
  Vehicle? vehicle;
  VehicleDashboardState({this.vehicle});

  VehicleDashboardState copyWith({Vehicle? vehicle}) {
    return VehicleDashboardState(
      vehicle: vehicle ?? this.vehicle,
    );
  }

  @override
  List<Object?> get props => [vehicle];
}
