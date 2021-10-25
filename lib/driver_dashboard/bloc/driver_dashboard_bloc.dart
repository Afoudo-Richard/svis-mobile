import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'driver_dashboard_event.dart';
part 'driver_dashboard_state.dart';

class DriverDashboardBloc extends Bloc<DriverDashboardEvent, DriverDashboardState> {
  DriverDashboardBloc() : super(DriverDashboardInitial()) {
    on<DriverDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
