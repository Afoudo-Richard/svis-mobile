part of 'vehicle_listing_bloc.dart';

enum VehicleListStatus { initial, success, failure }

class VehicleListingState extends Equatable {
  VehicleListingState({
    this.status = VehicleListStatus.initial,
    this.vehicles = const <Vehicle>[],
    this.vehiclesCopy = const <Vehicle>[],
    this.hasReachedMax = false,
    this.isSearching = false,
    this.successResponses = const <ParseResponse>[],
    this.failedResponses = const <ParseResponse>[],

  });

  final VehicleListStatus status;
  final List<Vehicle> vehicles;
  final List<Vehicle> vehiclesCopy;
  final List<ParseResponse> successResponses;
  final List<ParseResponse> failedResponses;
  final bool hasReachedMax;
  final bool isSearching;

  VehicleListingState copyWith({
    VehicleListStatus? status,
    List<Vehicle>? vehicles,
    List<Vehicle>? vehiclesCopy,
    bool? hasReachedMax,
    bool? isSearching,
    List<ParseResponse>? successResponses,
    List<ParseResponse>? failedResponses
  }) {
    return VehicleListingState(
        status: status ?? this.status,
        vehicles: vehicles ?? this.vehicles,
        vehiclesCopy: vehiclesCopy ?? this.vehiclesCopy,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isSearching: isSearching ?? this.isSearching,
        successResponses: successResponses ?? this.successResponses,
        failedResponses: failedResponses ?? this.failedResponses
        );
  }

  @override
  String toString() {
    return '''VehicleListingState { status: $status, hasReachedMax: $hasReachedMax, vehicles: ${vehicles.length} } }''';
  }

  @override
  List<Object> get props =>
      [status, vehicles, hasReachedMax, isSearching, successResponses, failedResponses];
}
