part of 'drivers_bloc.dart';

enum DriversStatus { initial, succes, failure }

class DriversState extends Equatable {
  DriversState({
    this.drivers = const <ProfileUser>[],
    this.hasReachedMax = false,
    this.status = DriversStatus.initial,
  }){
    isSelectingController.disableEditingWhenNoneSelected = true;
    isSelectingController.set(drivers.length);
  }

  final DriversStatus status;
  final List<ProfileUser?> drivers;
  final bool hasReachedMax;
  final MultiSelectController isSelectingController = MultiSelectController();



  DriversState copyWith({
    List<ProfileUser?>? drivers,
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
  List<Object> get props => [status, drivers, hasReachedMax];
}

