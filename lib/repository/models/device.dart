import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kDevice = 'Device';

class Device extends ParseObject implements ParseCloneable {
  Device() : super(kDevice);
  Device.clone() : this();

  @override
  Device clone(Map<String, dynamic> map) => Device.clone()..fromJson(map);

  String? get name {
    return this.get('Name');
  }

  set name(String? value) {
    set('Name', value);
  }

  String? get devicePin {
    return this.get('devicePIN');
  }

  set devicePin(String? value) {
    this.set('devicePIN', value);
  }

  String? get serialNumber {
    return this.get('serialNumber');
  }

  set serialNumber(String? value) {
    this.set('serialNumber', value);
  }

  bool? get updating {
    return this.get('updating');
  }

  set updating(bool? value) {
    this.set('updating', value);
  }

  bool? get immobilized {
    return this.get('immobilized');
  }

  set immobilized(bool? value) {
    this.set('immobilized', value);
  }

  String? get bearerEmailAddress {
    return this.get('bearerEmailAddress');
  }

  set bearerEmailAddress(String? value) {
    this.set('bearerEmailAddress', value);
  }

  DateTime? get lastConnected {
    return this.get('lastConnected');
  }

  set lastConnected(DateTime? value) {
    this.set('lastConnected', value);
  }
}
