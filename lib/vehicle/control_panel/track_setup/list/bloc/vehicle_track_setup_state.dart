part of 'vehicle_track_setup_bloc.dart';

enum VehicleTrackSetupListStatus { initial, success, failure }

class VehicleTrackSetupState extends Equatable {
  VehicleTrackSetupState({
    this.status = VehicleTrackSetupListStatus.initial,
    this.vehicleTrackSetups = const <VehicleTrackSetup>[],
    this.hasReachedMax = false,
    this.isSearching = false,
  });

  final List<VehicleTrackSetup> vehicleTrackSetups;
  final VehicleTrackSetupListStatus status;
  final bool hasReachedMax;
  final bool isSearching;

  VehicleTrackSetupState copyWith({
    VehicleTrackSetupListStatus? status,
    List<VehicleTrackSetup>? vehicleTrackSetups,
    bool? hasReachedMax,
    bool? isSearching,
  }) {
    return VehicleTrackSetupState(
      status: status ?? this.status,
      vehicleTrackSetups: vehicleTrackSetups ?? this.vehicleTrackSetups,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object> get props =>
      [vehicleTrackSetups, status, hasReachedMax, isSearching];
}
