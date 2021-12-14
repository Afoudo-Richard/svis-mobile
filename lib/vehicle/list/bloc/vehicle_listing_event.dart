part of 'vehicle_listing_bloc.dart';

abstract class VehicleListingEvent extends Equatable {
  const VehicleListingEvent();

  @override
  List<Object?> get props => [];
}

class VehicleListFetched extends VehicleListingEvent {}

class TextChanged extends VehicleListingEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}

class UpdateVehicleList extends VehicleListingEvent {
  const UpdateVehicleList(this.value);
  final Vehicle? value;

  @override
  List<Object?> get props => [value];
}

class DeleteSelected extends VehicleListingEvent {}

class ItemSelected extends VehicleListingEvent {
  const ItemSelected({required this.id});
  final id;

  @override
  List<Object> get props => [id];
}


