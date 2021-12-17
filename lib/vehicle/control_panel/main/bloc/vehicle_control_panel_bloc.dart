import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_control_panel_event.dart';
part 'vehicle_control_panel_state.dart';

class VehicleControlPanelBloc extends Bloc<VehicleControlPanelEvent, VehicleControlPanelState> {
  VehicleControlPanelBloc() : super(VehicleControlPanelInitial()) {
    on<VehicleControlPanelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
