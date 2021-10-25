part of 'driver_dashboard_bloc.dart';

class DriverDashboardState extends Equatable {
  const DriverDashboardState(this.user);
  final ProfileUser user;

  @override
  List<Object> get props => [user];
}
