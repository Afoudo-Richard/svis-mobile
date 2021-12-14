part of 'vehicle_listing_bloc.dart';

enum VehicleListStatus { initial, success, failure }

class VehicleListingState extends Equatable {
  VehicleListingState({
    this.status = VehicleListStatus.initial,
    this.vehicles = const <Vehicle>[],
    this.vehiclesCopy = const <Vehicle>[],
    this.hasReachedMax = false,
  });

  final VehicleListStatus status;
  final List<Vehicle> vehicles;
  final List<Vehicle> vehiclesCopy;
  final bool hasReachedMax;

  VehicleListingState copyWith({
    VehicleListStatus? status,
    List<Vehicle>? vehicles,
    List<Vehicle>? vehiclesCopy,
    bool? hasReachedMax,
    MultiSelectController? multiselectController,
    bool? isSelecting,
  }) {
    return VehicleListingState(
        status: status ?? this.status,
        vehicles: vehicles ?? this.vehicles,
        vehiclesCopy: vehiclesCopy ?? this.vehiclesCopy,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,

        );
  }

  @override
  String toString() {
    return '''VehicleListingState { status: $status, hasReachedMax: $hasReachedMax, vehicles: ${vehicles.length} } }''';
  }

  @override
  List<Object> get props =>
      [status, vehicles, hasReachedMax];
}
