import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_fault_code_detail_event.dart';
part 'vehicle_fault_code_detail_state.dart';

class VehicleFaultCodeDetailBloc extends Bloc<VehicleFaultCodeDetailEvent, VehicleFaultCodeDetailState> {
  VehicleFaultCodeDetailBloc() : super(VehicleFaultCodeDetailInitial()) {
    on<VehicleFaultCodeDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
