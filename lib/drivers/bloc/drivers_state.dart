part of 'drivers_bloc.dart';

enum DriversStatus { initial, succes, failure }

class DriversState extends Equatable {
  DriversState({
    this.drivers = const <User>[],
    this.hasReachedMax = false,
    this.status = DriversStatus.initial,
  }){
    isSelectingController.disableEditingWhenNoneSelected = true;
    isSelectingController.set(drivers.length);
  }

  final DriversStatus status;
  final List<User> drivers;
  final bool hasReachedMax;
  final MultiSelectController isSelectingController = MultiSelectController();



  DriversState copyWith({
    List<User>? drivers,
    bool? hasReachedMax,
    DriversStatus? status,
  }) {
    return DriversState(
      drivers: drivers ?? this.drivers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'DriversLoaded { drivers : ${drivers.length}, hasReachedMax: $hasReachedMax, status: $status';

  @override
  List<Object> get props => [status, drivers, hasReachedMax];
}

class DriverLoadingState extends DriversState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DriverLoadedState extends DriversState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
