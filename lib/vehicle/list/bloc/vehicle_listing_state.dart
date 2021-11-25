part of 'vehicle_listing_bloc.dart';

enum VehicleListStatus { initial, success, failure }

class VehicleListingState extends Equatable {
  VehicleListingState({
    required this.isSelectingController,
    this.status = VehicleListStatus.initial,
    this.vehicles = const <Vehicle>[],
    this.vehiclesCopy = const<Vehicle>[],
    this.hasReachedMax = false,
  }){
        isSelectingController.disableEditingWhenNoneSelected = true;
    //isSelectingController.set(drivers.length);
  }

  final VehicleListStatus status;
  final List<Vehicle> vehicles;
  final List<Vehicle> vehiclesCopy;
  final bool hasReachedMax;
  final MultiSelectController isSelectingController ;


    VehicleListingState copyWith({
    VehicleListStatus? status,
    List<Vehicle>? vehicles,
    List<Vehicle>? vehiclesCopy,
    bool? hasReachedMax,
    MultiSelectController? isSelectingController,

  }) {
    return VehicleListingState(
      status: status ?? this.status,
      vehicles: vehicles ?? this.vehicles,
      vehiclesCopy: vehiclesCopy ?? this.vehiclesCopy,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSelectingController : isSelectingController ?? this.isSelectingController

    );
  }

    @override
  String toString() {
    return '''VehicleListingState { status: $status, hasReachedMax: $hasReachedMax, vehicles: ${vehicles.length} } }''';
  }
  
  @override
  List<Object> get props => [status, vehicles, hasReachedMax];
}

