import 'package:app/repository/models/product.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/repository/models/vehicle_group.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kTrackSetup = 'TrackSetup';

class TrackSetup extends ParseObject implements ParseCloneable {
  TrackSetup() : super(kTrackSetup);
  TrackSetup.clone() : this();

  @override
  TrackSetup clone(Map<String, dynamic> map) =>
      TrackSetup.clone()..fromJson(map);

  // License? get license => this.get('license');
  // set license (License? value) => set('license', value);

  ParseRelation<Vehicle>? get vehicle => this.getRelation('vehicle');

  String? get endTime => this.get('endTime');
  set endTime(String? value) => set('endTime', value);

  int? get transRate => this.get('transRate');
  set transRate(int? value) => set('transRate', value);

  bool? get saveAsTemplate => this.get('saveAsTemplate');
  set saveAsTemplate(bool? value) => set('saveAsTemplate', value);

  Profile? get profile => this.get('profile');
  set profile(Profile? value) => set('profile', value);

  DateTime? get endDate => this.get('endDate');
  set endDate(DateTime? value) => set('endDate', value);

  int? get trackRate => this.get('trackRate');
  set trackRate(int? value) => set('trackRate', value);

  String? get name => this.get('name');
  set name(String? value) => set('name', value);

  String? get startTime => this.get('startTime');
  set startTime(String? value) => set('startTime', value);

  String? get state => this.get('state');
  set state(String? value) => set('state', value);

  bool? get status => this.get('status');
  set status(bool? value) => set('status', value);

  VehicleGroup? get vehicleGroup => this.get('VehicleGroup');
  set vehicleGroup(VehicleGroup? value) => set('VehicleGroup', value);

  String? get duration => this.get('duration');
  set duration(String? value) => set('duration', value);

  ParseRelation<ParseObject> get features => this.getRelation('features');

  User? get createdBy => this.get('createdBy');
  set createdBy(User? value) => set('createdBy', value);

}
