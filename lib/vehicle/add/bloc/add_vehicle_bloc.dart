import 'dart:async';

import 'package:app/repository/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  ProfileUser? profile;

  AddVehicleBloc({this.profile}) : super(AddVehicleState()) {
    on<ChangeEmailorPhone>(_onChangeEmailorPhone);
    on<ChangeSubmitedEmailOrPhone>(_onChangeSubmitedEmailOrPhone);
    on<AssociateDeviceLater>(_onAssociateDeviceLater);
    on<SubmitDeviceAssociation>(_onSubmitDeviceAssociation);
    on<SkipDeviceAssociation>(_onSkipDeviceAssociation);
    on<SubmitVerificationCode>(_onSubmitVerificationCode);
    on<SubmitVehicleInformation>(_onSubmitVehicleInformation);
  }

  void _onChangeEmailorPhone(ChangeEmailorPhone event, Emitter emit) {
    emit(state.copyWith(pagestatus: SwitchPageStatus.changeEmailOrPhone));
  }

  Future<void> _onAssociateDeviceLater(
    AssociateDeviceLater event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onChangeSubmitedEmailOrPhone(
    ChangeSubmitedEmailOrPhone event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.initial));
  }

  Future<void> _onSubmitDeviceAssociation(
    SubmitDeviceAssociation event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.deviceVerification));
  }

  Future<void> _onSkipDeviceAssociation(
    SkipDeviceAssociation event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onSubmitVerificationCode(
    SubmitVerificationCode event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onSubmitVehicleInformation(
    SubmitVehicleInformation event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(pagestatus: SwitchPageStatus.registrationInformation));
  }
}
