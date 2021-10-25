part of 'driver_dashboard_bloc.dart';

abstract class DriverDashboardState extends Equatable {
  const DriverDashboardState();
  
  @override
  List<Object> get props => [];
}

class DriverDashboard extends DriverDashboardState {
  User? user;
}
