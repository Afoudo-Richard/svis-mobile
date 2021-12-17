import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_configuration_event.dart';
part 'vehicle_configuration_state.dart';

class VehicleConfigurationBloc extends Bloc<VehicleConfigurationEvent, VehicleConfigurationState> {
  VehicleConfigurationBloc() : super(VehicleConfigurationInitial()) {
    on<VehicleConfigurationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
