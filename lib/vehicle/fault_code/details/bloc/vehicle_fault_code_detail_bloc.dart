import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/vehicle_trouble_code.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_fault_code_detail_event.dart';
part 'vehicle_fault_code_detail_state.dart';

class VehicleFaultCodeDetailBloc
    extends Bloc<VehicleFaultCodeDetailEvent, VehicleFaultCodeDetailState> {
  Vehicle vehicle;
  VehicleTroubleCode vehicleTroubleCode;
  VehicleFaultCodeDetailBloc({required this.vehicle, required this.vehicleTroubleCode})
      : super(VehicleFaultCodeDetailState(
            vehicle: vehicle, vehicleTroubleCode: vehicleTroubleCode));
}
