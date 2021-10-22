part of 'drivers_bloc.dart';

abstract class DriversEvent extends Equatable {
  const DriversEvent();

  @override
  List<Object> get props => [];
}

class DriversFetch extends DriversEvent {
  @override
  String toString() => "Fetch";
}


