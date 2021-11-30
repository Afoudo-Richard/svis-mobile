import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/vehicle_trouble_code.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_fault_code_detail_event.dart';
part 'vehicle_fault_code_detail_state.dart';

class VehicleFaultCodeDetailBloc
    extends Bloc<VehicleFaultCodeDetailEvent, VehicleFaultCodeDetailState> {
  VehicleTroubleCode vehicleTroubleCode;
  VehicleFaultCodeDetailBloc({required this.vehicleTroubleCode})
      : super(VehicleFaultCodeDetailState(
             vehicleTroubleCode: vehicleTroubleCode));
}
