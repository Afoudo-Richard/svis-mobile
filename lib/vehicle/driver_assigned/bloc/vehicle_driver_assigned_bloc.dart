import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_driver_assigned_event.dart';
part 'vehicle_driver_assigned_state.dart';

class VehicleDriverAssignedBloc extends Bloc<VehicleDriverAssignedEvent, VehicleDriverAssignedState> {
  VehicleDriverAssignedBloc() : super(VehicleDriverAssignedInitial()) {
    on<VehicleDriverAssignedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
