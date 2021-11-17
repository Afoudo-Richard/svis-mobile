import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kVehicleGroup = 'VehicleGroup';

class VehicleGroup extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  VehicleGroup() : super(kVehicleGroup);
  VehicleGroup.clone() : this();

  @override
  VehicleGroup clone(Map<String, dynamic> map) =>
      VehicleGroup.clone()..fromJson(map);

  String? get name => get<String?>('Name');
  set name(String? value) => set<String?>('Name', value);

  String? get description => get<String?>('Description');
  set description(String? value) => set<String?>('Description', value);



  @override
  List<Object?> get props => [
        objectId,
        name,
        description,
      ];
}
