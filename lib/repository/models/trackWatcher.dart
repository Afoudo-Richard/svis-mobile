import 'package:app/repository/models/product.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/trackSetup.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/repository/models/vehicle_group.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kTrackWatcher = 'TrackWatcher';

class TrackWatcher extends ParseObject implements ParseCloneable {
  TrackWatcher() : super(kTrackWatcher);
  TrackWatcher.clone() : this();

  @override
  TrackWatcher clone(Map<String, dynamic> map) =>
      TrackWatcher.clone()..fromJson(map);

  TrackSetup? get trackSetup => this.get('trackSetup');
  set trackSetup(TrackSetup? value) => set('trackSetup', value);

  ParseRelation<Vehicle>? get vehicle => this.getRelation('vehicle');

  String? get thresholds => this.get('thresholds');
  set thresholds(String? value) => set('thresholds', value);

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

  bool? get applyToVehicles => this.get('applyToVehicles');
  set applyToVehicles(bool? value) => set('applyToVehicles', value);

  DateTime? get startDate => this.get('startDate');
  set startDate(DateTime? value) => set('startDate', value);

  String? get state => this.get('state');
  set state(String? value) => set('state', value);

  bool? get status => this.get('status');
  set status(bool? value) => set('status', value);

  User? get owner => this.get('owner');
  set owner(User? value) => set('owner', value);

  String? get duration => this.get('duration');
  set duration(String? value) => set('duration', value);

  List? get days => this.get('days');
  set days(List? value) => set('days', value);

  bool? get isOrOutBound => this.get('isOrOutBound');
  set isOrOutBound(bool? value) => set('isOrOutBound', value);

  String? get updateStatus => this.get('updateStatus');
  set updateStatus(String? value) => set('updateStatus', value);

  String? get frequency => this.get('frequency');
  set frequency(String? value) => set('frequency', value);

  User? get createdBy => this.get('createdBy');
  set createdBy(User? value) => set('createdBy', value);

  //ParseRelation<Region>? get regions => this.getRelation('region');

}
