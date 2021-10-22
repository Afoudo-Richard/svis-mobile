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

class IsSelectingDrivers extends DriversEvent {
  const IsSelectingDrivers(this.values);
  final List values;
  List<Object> get props => [values];
}

class DeleteUsers extends DriversEvent {
  @override
  String toString() => "Delete users activated";
}
