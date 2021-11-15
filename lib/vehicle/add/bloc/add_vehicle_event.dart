part of 'add_vehicle_bloc.dart';

abstract class AddVehicleEvent extends Equatable {
  const AddVehicleEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailorPhone extends AddVehicleEvent{}
