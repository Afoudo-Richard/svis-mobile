import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kVehicle = 'Vehicle';

class Vehicle extends ParseObject implements ParseCloneable {
  Vehicle() : super(kVehicle);
  Vehicle.clone() : this();

  @override
  Vehicle clone(Map<String, dynamic> map) => Vehicle.clone()..fromJson(map);

  List? get geofence {
    return this.get('geofence');
  }

  set geofence(List? value) {
    set('geofence', value);
  }

  String? get countryCode {
    return get('countryCode');
  }

  set countryCode(String? value) {
    set('countryCode', value);
  }

  String? get registrationCity {
    return get('registrationCity');
  }

  set registrationCity(String? value) {
    set('registrationCity', value);
  }

  String? get transmission {
    return get('transmission');
  }

  set transmission(String? value) {
    set('transmission', value);
  }

  String? get modelYear {
    return get('modelYear');
  }

  set modelYear(String? value) {
    set('modelYear', value);
  }

  String? get name {
    return get('name');
  }

  set name(String? value) {
    set('name', value);
  }
}
