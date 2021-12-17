import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/trackSetup.dart';
import 'package:app/repository/models/trackWatcher.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kVehicleTrackWatcher = 'VehicleTrackWatcher';

class VehicleTrackWatcher extends ParseObject implements ParseCloneable {
  VehicleTrackWatcher() : super(kVehicleTrackWatcher);
  VehicleTrackWatcher.clone() : this();

  @override
  VehicleTrackWatcher clone(Map<String, dynamic> map) =>
      VehicleTrackWatcher.clone()..fromJson(map);

  Vehicle? get vehicle => this.get('vehicle');
  set vehicle(Vehicle? value) => set('vehicle', value);

  String? get state => this.get('state');
  set state(String? value) => set('state', value);

  TrackWatcher? get trackWatcher => this.get('trackWatcher');
  set trackSetup(TrackWatcher? value) => set('trackWatcher', value);

  bool get status => this.get('status');
  set status(bool value) => set('status', value);

  User? get owner => this.get('owner');
  set owner(User? value) => set('owner', value);
}
