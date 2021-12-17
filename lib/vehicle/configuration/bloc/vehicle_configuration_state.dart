part of 'vehicle_configuration_bloc.dart';

abstract class VehicleConfigurationState extends Equatable {
  const VehicleConfigurationState();
  
  @override
  List<Object> get props => [];
}

class VehicleConfigurationInitial extends VehicleConfigurationState {}
