part of 'vehicle_driver_assigned_bloc.dart';

abstract class VehicleDriverAssignedEvent extends Equatable {
  const VehicleDriverAssignedEvent();

  @override
  List<Object> get props => [];
}

class VehicleDriverAssigedListFetched extends VehicleDriverAssignedEvent {}