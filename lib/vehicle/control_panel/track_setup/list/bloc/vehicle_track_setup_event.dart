part of 'vehicle_track_setup_bloc.dart';

abstract class VehicleTrackSetupEvent extends Equatable {
  const VehicleTrackSetupEvent();

  @override
  List<Object> get props => [];
}

class VehicleTrackSetupFetch extends VehicleTrackSetupEvent {}

class TextChanged extends VehicleTrackSetupEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}
