import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/trackSetup.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kVehicleTrackSetup = 'VehicleTrackSetup';

class VehicleTrackSetup extends ParseObject implements ParseCloneable {
  VehicleTrackSetup() : super(kVehicleTrackSetup);
  VehicleTrackSetup.clone() : this();

  @override
  VehicleTrackSetup clone(Map<String, dynamic> map) =>
      VehicleTrackSetup.clone()..fromJson(map);

  ProfileUser? get profile => this.get('profile');
  set profile(ProfileUser? value) => set('profile', value);


  Vehicle ? get vehicle => this.get('vehicle');
  set vehicle(Vehicle? value) => set('vehicle', value);


  String ? get state => this.get('state');
  set state(String? value) => set('state', value);

  bool get status => this.get('status');
  set status(bool value) => set('status', value);

  TrackSetup ? get trackSetup => this.get('trackSetup');
  set trackSetup(TrackSetup? value) => set('trackSetup', value);

  User? get owner => this.get('owner');
  set owner(User? value) => set('owner', value);

  DateTime? get trackSetupUpdateAt => this.get('trackSetupUpdateAt');
  set trackSetupUpdateAt(DateTime? value) => set('trackSetupUpdateAt', value);

}
