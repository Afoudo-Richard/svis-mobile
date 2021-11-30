import 'package:app/repository/models/device.dart';
import 'package:app/repository/models/models.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kTrack = 'Track';

class Track extends ParseObject implements ParseCloneable {
  Track() : super(kTrack);
  Track.clone() : this();

  @override
  Track clone(Map<String, dynamic> map) => Track.clone()..fromJson(map);

  ParseGeoPoint? get geoCoordinate {
    return this.get('geoCoordinate');
  }

  set geoCoordinate(ParseGeoPoint? value) {
    set('geoCoordinate', value);
  }

  dynamic get engine {
    return this.get('engine');
  }

  set engine(dynamic value) {
    set('engine', value);
  }

  dynamic get miscellaneous {
    return this.get('miscellaneous');
  }

  set miscellaneous(dynamic value) {
    set('miscellaneous', value);
  }

  DateTime? get trackTimestamp {
    return this.get('trackTimestamp');
  }

  set trackTimestamp(DateTime? value) {
    set('trackTimestamp', value);
  }

  Vehicle? get asset {
    return this.get('asset');
  }

  set asset(Vehicle? value) {
    set('asset', value);
  }

  Device? get device {
    return this.get('device');
  }

  set device(Device? value) {
    set('device', value);
  }
}
