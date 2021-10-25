import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'driver_dashboard_event.dart';
part 'driver_dashboard_state.dart';

class DriverDashboardBloc
    extends Bloc<DriverDashboardEvent, DriverDashboardState> {
  DriverDashboardBloc({required User user})
      : super(DriverDashboardState(user)) {
    on<DriverDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
