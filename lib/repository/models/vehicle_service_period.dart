import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/trouble_code_type.dart';
import 'package:app/repository/models/vehicle_service_setup.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kVehicleServicePeriod = 'VehicleServicePeriod';

class VehicleServicePeriod extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  VehicleServicePeriod() : super(kVehicleServicePeriod);
  VehicleServicePeriod.clone() : this();

  @override
  VehicleServicePeriod clone(Map<String, dynamic> map) =>
      VehicleServicePeriod.clone()..fromJson(map);

  DateTime? get servicingDate => get<DateTime?>('servicingDate');
  set servicingDate(DateTime? value) => set<DateTime?>('servicingDate', value);

  bool? get saveAsTemplate => get<bool?>('saveAsTemplate');
  set saveAsTemplate(bool? value) => set<bool?>('saveAsTemplate', value);

  Profile? get profile => get<Profile?>('profile');
  set profile(Profile? value) => set<Profile?>('profile', value);

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  Vehicle? get vehicle => get<Vehicle?>('Vehicle');
  set vehicle(Vehicle? value) => set<Vehicle?>('Vehicle', value);

  String? get serviceType => get<String?>('serviceType');
  set serviceType(String? value) => set<String?>('serviceType', value);

  bool? get activate => get<bool?>('Activate');
  set activate(bool? value) => set<bool?>('Activate', value);

  User? get owner => get<User?>('owner');
  set owner(User? value) => set<User?>('owner', value);

  VehicleServiceSetup? get vehicleServiceSetup =>
      get<VehicleServiceSetup?>('vehicleServiceSetup');
  set vehicleServiceSetup(VehicleServiceSetup? value) =>
      set<VehicleServiceSetup?>('vehicleServiceSetup', value);

  String? get description => get<String?>('Description');
  set description(String? value) => set<String?>('Description', value);

  @override
  List<Object?> get props => [
        objectId,
      ];
}
