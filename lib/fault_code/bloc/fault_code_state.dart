part of 'fault_code_bloc.dart';

enum FaultCodeListStatus { initial, success, failure }

class FaultCodeState extends Equatable {
  const FaultCodeState({
    required this.vehicles,
    this.status = FaultCodeListStatus.initial,
    this.vehicleTroubleCodes = const <VehicleTroubleCode>[],
    this.hasReachedMax = false,
    this.searchText = "",
  }
  );
  final List<Vehicle> vehicles;
  final FaultCodeListStatus status;
  final List<VehicleTroubleCode> vehicleTroubleCodes;
  final bool hasReachedMax;
  final String searchText;

    FaultCodeState copyWith({
    FaultCodeListStatus? status,
    List<VehicleTroubleCode>? vehicleTroubleCodes,
    bool? hasReachedMax,
    String? searchText,
  }) {
    return FaultCodeState(
      vehicles: this.vehicles,
      status: status ?? this.status,
      vehicleTroubleCodes: vehicleTroubleCodes ?? this.vehicleTroubleCodes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchText:  searchText ?? this.searchText,
    );
  }


  
  @override
  List<Object> get props => [status, vehicleTroubleCodes, hasReachedMax];
}


