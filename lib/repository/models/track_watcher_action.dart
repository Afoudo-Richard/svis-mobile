import 'package:app/repository/models/product.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/trackWatcher.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:app/repository/models/vehicle_group.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kTrackWatcherAction = 'TrackWatcherAction';

class TrackWatcherAction extends ParseObject implements ParseCloneable {
  TrackWatcherAction() : super(kTrackWatcherAction);
  TrackWatcherAction.clone() : this();

  @override
  TrackWatcherAction clone(Map<String, dynamic> map) =>
      TrackWatcherAction.clone()..fromJson(map);

  ParseRelation<Vehicle>? get vehicle => this.getRelation('vehicle');

  String? get settings => this.get('setings');
  set settings(String? value) => set('settings', value);

  bool? get saveAsTemplate => this.get('saveAsTemplate');
  set saveAsTemplate(bool? value) => set('saveAsTemplate', value);

  Profile? get profile => this.get('profile');
  set profile(Profile? value) => set('profile', value);

  String? get name => this.get('name');
  set name(String? value) => set('name', value);

  bool? get applyToVehicles => this.get('applyToVehicles');
  set applyToVehicles(bool? value) => set('applyToVehicles', value);

  String? get state => this.get('state');
  set state(String? value) => set('state', value);

  bool? get status => this.get('status');
  set status(bool? value) => set('status', value);

  User? get owner => this.get('owner');
  set owner(User? value) => set('owner', value);

  String? get type => this.get('type');
  set type(String? value) => set('type', value);

  String? get updateStatus => this.get('updateStatus');
  set updateStatus(String? value) => set('updateStatus', value);

  ParseFile get file => this.get('file');
  set file(ParseFile? value) => set('file', value);

  TrackWatcher? get watcher => this.get('watcher');
  set watcher(TrackWatcher? value) => set('watcher', value);

  User? get createdBy => this.get('createdBy');
  set createdBy(User? value) => set('createdBy', value);
}
