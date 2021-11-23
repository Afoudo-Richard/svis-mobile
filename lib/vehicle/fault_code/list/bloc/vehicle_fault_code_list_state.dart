part of 'vehicle_fault_code_list_bloc.dart';
enum VehicleFaultCodeListStatus { initial, success, failure }

class VehicleFaultCodeListState extends Equatable {

    final VehicleFaultCodeListStatus status;
  final List<TroubleCode> faultCodes;
  final bool hasReachedMax;
  final String searchText;

  const VehicleFaultCodeListState({
        this.status = VehicleFaultCodeListStatus.initial,
    this.faultCodes = const <TroubleCode>[],
    this.hasReachedMax = false,
    this.searchText = "",
  });

      VehicleFaultCodeListState copyWith({
    VehicleFaultCodeListStatus? status,
    List<TroubleCode>? faultCodes,
    bool? hasReachedMax,
    String? searchText,
  }) {
    return VehicleFaultCodeListState(
      status: status ?? this.status,
      faultCodes: faultCodes ?? this.faultCodes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchText:  searchText ?? this.searchText,
    );
  }
  
  @override
  List<Object> get props => [status, faultCodes, hasReachedMax];
}

