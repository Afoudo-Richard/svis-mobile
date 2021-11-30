part of 'vehicle_fault_code_list_bloc.dart';

abstract class VehicleFaultCodeEvent extends Equatable {
  const VehicleFaultCodeEvent();

  @override
  List<Object> get props => [];
}

class VehicleFaultCodeFetch extends VehicleFaultCodeEvent {}

class TextChanged extends VehicleFaultCodeEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}