import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/trouble_code_type.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kVehicleTroubleCode = 'VehicleTroubleCode';

class VehicleTroubleCode extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  VehicleTroubleCode() : super(kVehicleTroubleCode);
  VehicleTroubleCode.clone() : this();

  @override
  VehicleTroubleCode clone(Map<String, dynamic> map) =>
      VehicleTroubleCode.clone()..fromJson(map);

  TroubleCode? get troubleCode => get<TroubleCode?>('troubleCode');
  set troubleCode(TroubleCode? value) =>
      set<TroubleCode?>('troubleCode', value);

  bool? get isErased => get<bool?>('isErased');
  set isErased(bool? value) => set<bool?>('isErased', value);

  // Track? get tracks => get<bool?>('Track');
  // set tracks(Track? value) => set<Track?>('Track', value);

  Vehicle? get vehicle => get<Vehicle?>('vehicle');
  set vehicle(Vehicle? value) => set<Vehicle?>('vehicle', value);

  DateTime? get dateErased => get<DateTime?>('dateErased');
  set dateErased(DateTime? value) => set<DateTime?>('dateErased', value);

  String? get status => get<String?>('status');
  set status(String? value) => set<String?>('status', value);

  String? get distanceTravelledWithMe =>
      get<String?>('distanceTravelledWithMe');
  set distanceTravelledWithMe(String? value) =>
      set<String?>('distanceTravelledWithMe', value);

  TroubleCodeType? get troubleCodeType => get<TroubleCodeType?>('troubleCodeType');
  set troubleCodeType(TroubleCodeType? value) => set<TroubleCodeType?>('troubleCodeType', value);

  @override
  List<Object?> get props => [
        objectId,
      ];
}
