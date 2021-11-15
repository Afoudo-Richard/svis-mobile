part of 'add_vehicle_bloc.dart';

enum SwitchPageStatus {initial, changeEmailOrPhone}
class AddVehicleState extends Equatable {

  //final Name deviceSerialNumber;
  final SwitchPageStatus pagestatus;

  const AddVehicleState({
    this.pagestatus = SwitchPageStatus.initial,
  });

  AddVehicleState copyWith({
    SwitchPageStatus? pagestatus
  }){
    return AddVehicleState(pagestatus: pagestatus ?? this.pagestatus);
  }
  
  @override
  List<Object> get props => [pagestatus];
}

