part of 'vehicle_fault_code_list_bloc.dart';

enum VehicleFaultCodeListStatus { initial, success, failure }

class VehicleFaultCodeListState extends Equatable {
  final Vehicle vehicle;
  final VehicleFaultCodeListStatus status;
  final List<VehicleTroubleCode> vehicleTroubleCodes;
  final bool hasReachedMax;
  final String searchText;

  const VehicleFaultCodeListState({
    required this.vehicle,
    this.status = VehicleFaultCodeListStatus.initial,
    this.vehicleTroubleCodes = const <VehicleTroubleCode>[],
    this.hasReachedMax = false,
    this.searchText = "",
  });

  VehicleFaultCodeListState copyWith({
    VehicleFaultCodeListStatus? status,
    List<VehicleTroubleCode>? vehicleTroubleCodes,
    bool? hasReachedMax,
    String? searchText,
  }) {
    return VehicleFaultCodeListState(
      vehicle: this.vehicle,
      status: status ?? this.status,
      vehicleTroubleCodes: vehicleTroubleCodes ?? this.vehicleTroubleCodes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object> get props => [vehicle,status, vehicleTroubleCodes, hasReachedMax];
}
