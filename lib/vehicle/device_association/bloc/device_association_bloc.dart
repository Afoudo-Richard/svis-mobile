import 'dart:math';

import 'package:app/commons/commons.dart';
import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/device.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;

import 'package:collection/collection.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'device_association_event.dart';
part 'device_association_state.dart';

class DeviceAssociationBloc
    extends Bloc<DeviceAssociationEvent, DeviceAssociationState> {
  final Vehicle vehicle;

  DeviceAssociationBloc({required this.vehicle, String? email})
      : super(
          DeviceAssociationState(
            verificationEmail:
                Email.dirty(email ?? 'info@sumelongenterprise.com'),
          ),
        ) {
    on<VerificationPinChanged>(_onVerificationPinChanged);
    on<SerialNumberChanged>(_onSerialNumberChanged);
    on<ChangeEmailorPhone>(_onChangeEmailorPhone);
    on<ChangeSubmitedEmailOrPhone>(_onChangeSubmitedEmailOrPhone);
    on<SubmitDeviceAssociation>(_onSubmitDeviceAssociation);
    on<SubmitVerificationCode>(_onSubmitVerificationCode);
    on<ResendVerificationCode>(_onResendVerificationCode);
    on<VerificationEmailChanged>(_onVerificationEmailChanged);
  }

  void _onChangeEmailorPhone(ChangeEmailorPhone event, Emitter emit) {
    emit(
      state.copyWith(
          pagestatus: DeviceAssociationPageStatus.changeEmailOrPhone),
    );
  }

  Future<void> _onChangeSubmitedEmailOrPhone(
    ChangeSubmitedEmailOrPhone event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    emit(state.copyWith(pagestatus: DeviceAssociationPageStatus.initial));
  }

  Future<void> _onSubmitDeviceAssociation(
    SubmitDeviceAssociation event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    if (state.deviceSerialNumber.valid) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        var _iDevice = await _fetchDevice(state.deviceSerialNumber.value);
        var _device = _iDevice?.firstOrNull;
        if (_device != null) {
          var _vehicle =
              await _fetchVehicleIfExists(state.deviceSerialNumber.value);
          if (_vehicle?.isEmpty ?? false) {
            /// process device here
            _device.bearerEmailAddress = state.verificationEmail.value;
            _device.updating = true;
            var _verificationCode = generateRandomString(5);
            _device.devicePin = _verificationCode;
            await _device.update();
            emit(
              state.copyWith(
                submission: fz.FormzSubmission.pure(),
                pagestatus: DeviceAssociationPageStatus.deviceVerification,
                verificationCode: _verificationCode,
                editable: true,
              ),
            );
          } else {
            throw 'device is mapped';
          }
        } else {
          throw 'device not found';
        }
      } catch (e) {
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.failure(
              e.toString(),
            ),
            editable: true,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            'unable to process device',
          ),
          editable: true,
        ),
      );
    }
  }

  Future<void> _onSubmitVerificationCode(
    SubmitVerificationCode event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    emit(state.copyWith(
      submission: fz.FormzSubmission.inProgress(),
      editable: false,
    ));
    try {
      if (state.verificationPin.value == state.verificationCode) {
        var device =
            (await _fetchDevice(state.deviceSerialNumber.value))?.firstOrNull;
        ApiResponse response = getApiResponse<Vehicle>(
          await (vehicle..device = device).update(),
        );
        if (response.success) {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.success(success: response.result),
              editable: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              submission: fz.FormzSubmission.failure(
                response.error?.message ?? 'unable to save',
              ),
              editable: true,
            ),
          );
        }
      } else {
        throw 'code verification failed';
      }
    } catch (e) {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            e.toString(),
          ),
          editable: true,
        ),
      );
    }
    // emit(state.copyWith(pagestatus: SwitchPageStatus.vehicleInformation));
  }

  Future<void> _onResendVerificationCode(
    ResendVerificationCode event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    if (state.deviceSerialNumber.valid) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        var _iDevice = await _fetchDevice(state.deviceSerialNumber.value);
        var _device = _iDevice?.firstOrNull;
        if (_device != null) {
          var _vehicle =
              await _fetchVehicleIfExists(state.deviceSerialNumber.value);
          if (_vehicle?.isEmpty ?? false) {
            /// process device here
            _device.bearerEmailAddress = state.verificationEmail.value;
            _device.updating = true;
            var _verificationCode = state.verificationCode;
            _device.devicePin = _verificationCode;
            await _device.update();
            emit(
              state.copyWith(
                submission: fz.FormzSubmission.pure(),
                verificationCode: _verificationCode,
                editable: true,
              ),
            );
          } else {
            throw 'device is mapped';
          }
        } else {
          throw 'device not found';
        }
      } catch (e) {
        emit(
          state.copyWith(
            submission: fz.FormzSubmission.failure(
              e.toString(),
            ),
            editable: true,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            'unable to process device',
          ),
          editable: true,
        ),
      );
    }
  }

  Future<void> _onVerificationEmailChanged(
    VerificationEmailChanged event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    emit(
      state.copyWith(verificationEmail: Email.dirty(event.value)),
    );
  }

  Future<void> _onSerialNumberChanged(
    SerialNumberChanged event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    var serialNumber = Name.dirty(event.value);
    emit(
      state.copyWith(
        deviceSerialNumber: serialNumber,
        serialInputForm: fz.Formz.validate([serialNumber]),
        submission: fz.FormzSubmission.pure(),
      ),
    );
  }

  Future<List<Device?>>? _fetchDevice(String serialNumber) async {
    QueryBuilder<Device> query = QueryBuilder<Device>(Device());
    query.whereEqualTo('serialNumber', serialNumber);
    return query.find();
  }

  Future<List<Vehicle?>>? _fetchVehicleIfExists(String serialNumber) async {
    QueryBuilder<Device> vQuery = QueryBuilder<Device>(Device());
    vQuery.whereEqualTo('serialNumber', serialNumber);
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.whereMatchesQuery('device', vQuery);
    return query.find();
  }

  Future<void> _onVerificationPinChanged(
    VerificationPinChanged event,
    Emitter<DeviceAssociationState> emit,
  ) async {
    var value = Name.dirty(event.value);
    emit(
      state.copyWith(
        verificationPin: value,
        verificationPinInputForm: fz.Formz.validate([value]),
      ),
    );
  }
}
