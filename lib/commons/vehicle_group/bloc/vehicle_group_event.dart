part of 'vehicle_group_bloc.dart';

abstract class VehicleGroupEvent extends Equatable {
  const VehicleGroupEvent();

  @override
  List<Object> get props => [];
}

class VehicleGroupFetch extends VehicleGroupEvent {}
