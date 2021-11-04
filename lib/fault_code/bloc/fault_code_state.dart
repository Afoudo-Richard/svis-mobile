part of 'fault_code_bloc.dart';

enum FaultCodeListStatus { initial, success, failure }

class FaultCodeState extends Equatable {
  const FaultCodeState({
    this.status = FaultCodeListStatus.initial,
    this.faultCodes = const <TroubleCode>[],
    this.hasReachedMax = false,
    this.searchText = "",
  }
  );

  final FaultCodeListStatus status;
  final List<TroubleCode> faultCodes;
  final bool hasReachedMax;
  final String searchText;

    FaultCodeState copyWith({
    FaultCodeListStatus? status,
    List<TroubleCode>? faultCodes,
    bool? hasReachedMax,
    String? searchText,
  }) {
    return FaultCodeState(
      status: status ?? this.status,
      faultCodes: faultCodes ?? this.faultCodes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchText:  searchText ?? this.searchText,
    );
  }


  
  @override
  List<Object> get props => [status, faultCodes, hasReachedMax];
}


