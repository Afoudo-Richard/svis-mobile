part of 'add_vehicle_bloc.dart';

abstract class AddVehicleEvent extends Equatable {
  const AddVehicleEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailorPhone extends AddVehicleEvent {}

class AssociateDeviceLater extends AddVehicleEvent {}

class ChangeSubmitedEmailOrPhone extends AddVehicleEvent {}

class SubmitDeviceAssociation extends AddVehicleEvent {}

class SkipDeviceAssociation extends AddVehicleEvent {}

class SubmitVerificationCode extends AddVehicleEvent {}

class SubmitVehicleInformation extends AddVehicleEvent {}
