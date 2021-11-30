part of 'vehicle_dashboard_bloc.dart';

class VehicleDashboardState extends Equatable {
  final Vehicle? vehicle;
  final FormzStatus? lastKnwonStatus;
  final DateTime? lastConnected;
  final Track? lastKnwon;
  final FormzStatus? driverStatus;
  VehicleDashboardState({
    this.vehicle,
    this.lastKnwonStatus,
    this.lastConnected,
    this.driverStatus,
    this.lastKnwon,
  });

  VehicleDashboardState copyWith({
    Vehicle? vehicle,
    FormzStatus? lastKnwonStatus,
    DateTime? lastConnected,
    FormzStatus? driverStatus,
    Track? lastKnwon,
  }) {
    return VehicleDashboardState(
      vehicle: vehicle ?? this.vehicle,
      lastKnwonStatus: lastKnwonStatus ?? this.lastKnwonStatus,
      lastConnected: lastConnected ?? this.lastConnected,
      driverStatus: driverStatus ?? this.driverStatus,
      lastKnwon: lastKnwon ?? this.lastKnwon,
    );
  }

  @override
  List<Object?> get props =>
      [vehicle, lastKnwonStatus, lastConnected, driverStatus, lastKnwon];
}
