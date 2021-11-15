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


class DeleteSelected extends DriversEvent{}

class TextChanged extends DriversEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}

class ItemSelected extends DriversEvent {
  const ItemSelected({required this.index});
  final int index;

  @override
  List<Object> get props => [index];
}
