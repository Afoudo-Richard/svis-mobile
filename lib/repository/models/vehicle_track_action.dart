import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/trackSetup.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kVehicleTrackAction = 'VehicleTrackAction';

class VehicleTrackAction extends ParseObject implements ParseCloneable {
  VehicleTrackAction() : super(kVehicleTrackAction);
  VehicleTrackAction.clone() : this();

  @override
  VehicleTrackAction clone(Map<String, dynamic> map) =>
      VehicleTrackAction.clone()..fromJson(map);

  ProfileUser? get profile => this.get('profile');
  set profile(ProfileUser? value) => set('profile', value);


  Vehicle ? get vehicle => this.get('vehicle');
  set vehicle(Vehicle? value) => set('vehicle', value);


  String ? get state => this.get('state');
  set state(String? value) => set('state', value);

  bool get status => this.get('status');
  set status(bool value) => set('status', value);

  User? get owner => this.get('owner');
  set owner(User? value) => set('owner', value);

  DateTime? get trackSetupUpdateAt => this.get('trackSetupUpdateAt');
  set trackSetupUpdateAt(DateTime? value) => set('trackSetupUpdateAt', value);

}
