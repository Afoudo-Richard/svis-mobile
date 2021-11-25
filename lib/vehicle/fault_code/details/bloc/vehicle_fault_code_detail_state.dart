part of 'vehicle_fault_code_detail_bloc.dart';

class VehicleFaultCodeDetailState extends Equatable {
  final VehicleTroubleCode vehicleTroubleCode;

  const VehicleFaultCodeDetailState({
    required this.vehicleTroubleCode,
  });

  @override
  List<Object> get props => [vehicleTroubleCode];
}
