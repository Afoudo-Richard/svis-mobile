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

part 'device_dissociation_event.dart';
part 'device_dissociation_state.dart';

class DeviceDissociationBloc
    extends Bloc<DeviceDissociationEvent, DeviceDissociationState> {
  final Vehicle vehicle;

  DeviceDissociationBloc({required this.vehicle, String? email})
      : super(
          DeviceDissociationState(
            verificationEmail:
                Email.dirty(email ?? 'info@sumelongenterprise.com'),
          ),
        ) {
    on<FetchDeviceProperties>(_onFetchDeviceProperties);
    on<VerificationPinChanged>(_onVerificationPinChanged);
    on<SerialNumberChanged>(_onSerialNumberChanged);
    on<ChangeEmailorPhone>(_onChangeEmailorPhone);
    on<ChangeSubmitedEmailOrPhone>(_onChangeSubmitedEmailOrPhone);
    on<SubmitDeviceDissociation>(_onSubmitDeviceDissociation);
    on<SubmitVerificationCode>(_onSubmitVerificationCode);
    on<ResendVerificationCode>(_onResendVerificationCode);
    on<VerificationEmailChanged>(_onVerificationEmailChanged);
  }

  void _onChangeEmailorPhone(ChangeEmailorPhone event, Emitter emit) {
    emit(
      state.copyWith(
          pagestatus: DeviceDissociationPageStatus.changeEmailOrPhone),
    );
  }

  Future<void> _onChangeSubmitedEmailOrPhone(
    ChangeSubmitedEmailOrPhone event,
    Emitter<DeviceDissociationState> emit,
  ) async {
    emit(state.copyWith(pagestatus: DeviceDissociationPageStatus.initial));
  }

  Future<void> _onSubmitDeviceDissociation(
    SubmitDeviceDissociation event,
    Emitter<DeviceDissociationState> emit,
  ) async {
    if (state.deviceSerialNumber.valid) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        final _last5DigitsOfSerial = state.device!.serialNumber!.substring(
          state.device!.serialNumber!.length - 5,
        );
        if (_last5DigitsOfSerial == state.deviceSerialNumber.value) {
          var _vehicle =
              await _fetchVehicleIfExists(state.deviceSerialNumber.value);
          if (_vehicle?.isEmpty ?? false) {
            /// process device here
            var _verificationCode = generateRandomString(5);
            var _device = state.device as Device;
            _device.bearerEmailAddress = state.verificationEmail.value;
            _device.updating = true;
            _device.devicePin = _verificationCode;
            ApiResponse response = getApiResponse(await _device.update());
            if (response.success) {
              emit(
                state.copyWith(
                  submission: fz.FormzSubmission.pure(),
                  pagestatus: DeviceDissociationPageStatus.deviceVerification,
                  verificationCode: _verificationCode,
                  editable: true,
                  device: _device,
                ),
              );
            } else {
              throw response.error?.message ?? 'error';
            }
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
    Emitter<DeviceDissociationState> emit,
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
    Emitter<DeviceDissociationState> emit,
  ) async {
    if (state.deviceSerialNumber.valid) {
      emit(state.copyWith(
        submission: fz.FormzSubmission.inProgress(),
        editable: false,
      ));
      try {
        var _iDevice = await _fetchDevice(state.device?.serialNumber);
        var _device = _iDevice?.firstOrNull;
        if (_device != null) {
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
    Emitter<DeviceDissociationState> emit,
  ) async {
    emit(
      state.copyWith(verificationEmail: Email.dirty(event.value)),
    );
  }

  Future<void> _onSerialNumberChanged(
    SerialNumberChanged event,
    Emitter<DeviceDissociationState> emit,
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

  Future<List<Device?>>? _fetchDevice(String? serialNumber) async {
    QueryBuilder<Device> query = QueryBuilder<Device>(Device());
    query.whereEqualTo('serialNumber', serialNumber);
    return query.find();
  }

  Future<List<Vehicle?>>? _fetchVehicleIfExists(String? serialNumber) async {
    QueryBuilder<Device> vQuery = QueryBuilder<Device>(Device());
    vQuery.whereEqualTo('serialNumber', serialNumber);
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle());
    query.whereMatchesQuery('device', vQuery);
    return query.find();
  }

  Future<void> _onVerificationPinChanged(
    VerificationPinChanged event,
    Emitter<DeviceDissociationState> emit,
  ) async {
    var value = Name.dirty(event.value);
    emit(
      state.copyWith(
        verificationPin: value,
        verificationPinInputForm: fz.Formz.validate([value]),
      ),
    );
  }

  Future<void> _onFetchDeviceProperties(
    FetchDeviceProperties event,
    Emitter<DeviceDissociationState> emit,
  ) async {
    emit(state.copyWith(
      submission: fz.FormzSubmission.inProgress(),
      editable: false,
    ));
    ApiResponse response = getApiResponse<Device>(
      await Device().getObject(vehicle.device?.objectId ?? 'null'),
    );
    if (response.success) {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.pure(),
          device: response.result,
          editable: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          submission: fz.FormzSubmission.failure(
            response.error?.message ?? 'unable to fetch device',
          ),
          editable: true,
        ),
      );
    }
  }
}
