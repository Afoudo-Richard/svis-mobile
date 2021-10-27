import 'package:app/repository/models/vehicle.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kEventLog = 'EventLog';

class EventLog extends ParseObject implements ParseCloneable {
  EventLog() : super(kEventLog);
  EventLog.clone() : this();

  @override
  EventLog clone(Map<String, dynamic> map) => EventLog.clone()..fromJson(map);

  User? get driver {
    return this.get('driver');
  }

  set driver(User? value) {
    set('driver', value);
  }

  String? get parameter {
    return get('parameter');
  }

  set parameter(String? value) {
    set('parameter', value);
  }

  String? get description {
    return get('Description');
  }

  set description(String? value) {
    set('Description', value);
  }

  Vehicle? get vehicle {
    return get('vehicle');
  }

  set vehicle(Vehicle? value) {
    set('vehicle', value);
  }

  DateTime? get createdAt {
    return get('createdAt');
  }

  set createdAt(DateTime? value) {
    set('createdAt', value);
  }
}
