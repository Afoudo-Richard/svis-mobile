import 'package:app/repository/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kVehicleServiceSetup = 'VehicleServiceSetup';

class VehicleServiceSetup extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  VehicleServiceSetup() : super(kVehicleServiceSetup);
  VehicleServiceSetup.clone() : this();

  @override
  VehicleServiceSetup clone(Map<String, dynamic> map) =>
      VehicleServiceSetup.clone()..fromJson(map);

  DateTime? get servicingDate => get<DateTime?>('servicingDate');
  set servicingDate(DateTime? value) => set<DateTime?>('servicingDate', value);

  bool? get saveAsTemplate => get<bool?>('saveAsTemplate');
  set saveAsTemplate(bool? value) => set<bool?>('saveAsTemplate', value);

  //ParseRelation<Profile>? get Profile => this.getRelation('Profile');

  Profile? get profile => get<Profile?>('profile');
  set profile(Profile? value) => set<Profile?>('profile', value);

  int? get mileage => get<int?>('mileage');
  set mileage(int? value) => set<int?>('mileage', value);

  String? get name => get<String?>('Name');
  set name(String? value) => set<String?>('Name', value);

  Vehicle? get vehicle => get<Vehicle?>('Vehicle');
  set vehicle(Vehicle? value) => set<Vehicle?>('Vehicle', value);

  String? get serviceType => get<String?>('serviceType');
  set serviceType(String? value) => set<String?>('serviceType', value);

  bool? get activate => get<bool?>('Activate');
  set activate(bool? value) => set<bool?>('Activate', value);

  User? get owner => get<User?>('owner');
  set owner(User? value) => set<User?>('owner', value);

  int? get duration => get<int?>('Duration');
  set duration(int? value) => set<int?>('Duration', value);

  DateTime? get lastInspectionDate => get<DateTime?>('LastInspectionDate');
  set lastInspectionDate(DateTime? value) =>
      set<DateTime?>('LastInspectionDate', value);

  bool? get validForAllVehicles => get<bool?>('ValidForAllVehicles');
  set validForAllVehicles(bool? value) =>
      set<bool?>('ValidForAllVehicles', value);

  String? get description => get<String?>('Description');
  set description(String? value) => set<String?>('Description', value);

  //ParseRelation<GeneralVehicleServices>? get services => this.getRelation('Services');

  int? get lastMileageByInspection => get<int?>('LastMileageByInspection');
  set lastMileageByInspection(int? value) =>
      set<int?>('LastMileageByInspection', value);

  // ServiceMaintainanceSetup? get serviceMaintenanceSetup =>
  //     get<ServiceMaintainanceSetup?>('ServiceMaintenanceSetup');
  // set serviceMaintenanceSetup(ServiceMaintainanceSetup? value) =>
  //     set<ServiceMaintainanceSetup?>('ServiceMaintenanceSetup', value);

  @override
  List<Object?> get props => [
        objectId,
      ];
}
