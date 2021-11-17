import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_dashboard_event.dart';
part 'vehicle_dashboard_state.dart';

class VehicleDashboardBloc extends Bloc<VehicleDashboardEvent, VehicleDashboardState> {

  Vehicle? vehicle;
  VehicleDashboardBloc({required this.vehicle}) : super(VehicleDashboardState(vehicle:vehicle)) {
    on<VehicleDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
