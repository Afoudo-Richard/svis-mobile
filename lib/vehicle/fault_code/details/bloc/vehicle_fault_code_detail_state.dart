part of 'vehicle_fault_code_detail_bloc.dart';

class VehicleFaultCodeDetailState extends Equatable {

  final Vehicle vehicle;
  final VehicleTroubleCode vehicleTroubleCode;


  const VehicleFaultCodeDetailState({
    required this.vehicleTroubleCode,
    required this.vehicle,
  });
  
  @override
  List<Object> get props => [vehicle, vehicleTroubleCode];
}

