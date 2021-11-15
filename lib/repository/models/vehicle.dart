import 'package:app/repository/models/profile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

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

  bool? get updating {
    return get('updating');
  }

  set updating(bool? value) {
    set('name', value);
  }

  int? get purchasedPrice {
    return get('PurchasedPrice');
  }

  set purchasedPrice(int? value) {
    set('PurchasedPrice', value);
  }

  ParseRelation<Profile>? get profile {
    return this.getRelation('Profile');
  }

  String? get model {
    return get('model');
  }

  set model(String? value) {
    set('model', value);
  }

  int? get mileage {
    return get('Mileage');
  }

  set mileage(int? value) {
    set('Mileage', value);
  }

  String? get name {
    return get('name');
  }

  set name(String? value) {
    set('name', value);
  }

  ParseRelation<User>? get user {
    return this.getRelation('User');
  }

  String? get trackDisplayColor {
    return get('trackDisplayColor');
  }

  set trackDisplayColor(String? value) {
    set('trackDisplayColor', value);
  }

  String? get bearerName {
    return get('bearerName');
  }

  set bearerName(String? value) {
    set('bearerName', value);
  }
  
}
