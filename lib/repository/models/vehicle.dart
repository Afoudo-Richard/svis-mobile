import 'package:app/repository/models/device.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/vehicle_group.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kVehicle = 'Vehicle';

class Vehicle extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
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

  Profile? get profile {
    return this.get('Profile');
  }

  set profile(Profile? value) {
    set('profile', value);
  }

  String? get model {
    return get('model');
  }

  set model(String? value) {
    set('model', value);
  }

  User? get driver {
    return get('driver');
  }

  set driver(User? value) {
    set('driver', value);
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

  User? get user {
    return this.get('user');
  }

  set user(User? value) {
    set('user', value);
  }

  set make(String? value) {
    set('make', value);
  }

  String? get make {
    return this.get('make');
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

  String? get secretKey {
    return get('secretKey');
  }

  set secretKey(String? value) {
    set('secretKey', value);
  }

  String? get fuelType {
    return get('fuelType');
  }

  set fuelType(String? value) {
    set('fuelType', value);
  }

  int? get currentMileage {
    return get('currentMileage');
  }

  set currentMileage(int? value) {
    set('currentMileage', value);
  }

  String? get manufacturer {
    return get('manufacturer');
  }

  set manufacturer(String? value) {
    set('manufacturer', value);
  }

  ParseFile? get photo {
    return get('photo');
  }

  set photo(ParseFile? value) {
    set('photo', value);
  }

  String? get status {
    return get('status');
  }

  set status(String? value) {
    set('status', value);
  }

  String? get bearerAddress {
    return get('bearerAddress');
  }

  set bearerAddress(String? value) {
    set('bearerAddress', value);
  }

  VehicleGroup? get vehicleGroup {
    return this.get('vehicleGroup');
  }

  set vehicleGroup(VehicleGroup? value) {
    set('vehicleGroup', value);
  }

  DateTime? get licensePlateDateOfRegistration {
    return get('licensePlateDateOfRegistration');
  }

  set licensePlateDateOfRegistration(DateTime? value) {
    set('licensePlateDateOfRegistration', value);
  }

  String? get achiveStatus {
    return get('achiveStatus');
  }

  set achiveStatus(String? value) {
    set('achiveStatus', value);
  }

  bool? get isPrivatmodus {
    return get('IsPrivatmodus');
  }

  set isPrivatmodus(bool? value) {
    set('IsPrivatmodus', value);
  }

  String? get registrationId {
    return get('registrationId');
  }

  set registrationId(String? value) {
    set('registrationId', value);
  }

  String? get insurancePolicyNumber {
    return get('insurancePolicyNumber');
  }

  set insurancePolicyNumber(String? value) {
    set('insurancePolicyNumber', value);
  }

  String? get licensePlate {
    return get('licensePlate');
  }

  set licensePlate(String? value) {
    set('licensePlate', value);
  }

  int? get bearerPhoneNumber {
    return get('bearerPhoneNumber');
  }

  set bearerPhoneNumber(int? value) {
    set('bearerPhoneNumber', value);
  }

/*   String? get timestamp {
    return get('timestamp');
  }

  set timestamp(String? value) {
    set('timestamp', value);
  } */

  //   Device? get device {
  //   return this.get('device');
  // }

  //   vehicleSpecification? get vehicleSpecification {
  //   return this.get('vehicleSpecification');
  // }

  DateTime? get licensePlateDateValidUntil {
    return get('licensePlateDateValidUntil');
  }

  set licensePlateDateValidUntil(DateTime? value) {
    set('licensePlateDateValidUntil', value);
  }

  List<ParseFile> get documents {
    return get('documents');
  }

  set documents(List<ParseFile>? value) {
    set('documents', value);
  }

  String? get bearerEmailAddress {
    return get('bearerEmailAddress');
  }

  set bearerEmailAddress(String? value) {
    set('bearerEmailAddress', value);
  }

  Device? get device {
    return get('device');
  }

  set device(Device? value) {
    set('device', value);
  }

  String? get vin {
    return get('vin');
  }

  set vin(String? value) {
    set('vin', value);
  }

  String? get bodyType {
    return get('bodyType');
  }

  set bodyType(String? value) {
    set('bodyType', value);
  }

  String? get region {
    return get('region');
  }

  set region(String? value) {
    set('region', value);
  }

  String? get registrationCountry {
    return get('registrationCountry');
  }

  set registrationCountry(String? value) {
    set('registrationCountry', value);
  }

  String? get bearerAddress2 {
    return get('bearerAddress2');
  }

  set bearerAddress2(String? value) {
    set('bearerAddress2', value);
  }

  int? get totalDistanceTravelled {
    return get('totalDistanceTravelled');
  }

  set totalDistanceTravelled(int? value) {
    set('totalDistanceTravelled', value);
  }

  ParseRelation<User>? get drivers => this.getRelation('drivers');

  @override
  List<Object?> get props => [
        objectId,
        geofence,
        countryCode,
        registrationCity,
        transmission,
        modelYear,
        updating,
        purchasedPrice,
        profile,
        model,
        mileage,
        name,
        user,
        trackDisplayColor,
        bearerName,
        secretKey,
        fuelType,
        currentMileage,
        manufacturer,
        photo,
        status,
        bearerAddress,
        vehicleGroup,
        licensePlateDateOfRegistration,
        achiveStatus,
        isPrivatmodus,
        registrationId,
        insurancePolicyNumber,
        licensePlate,
        bearerPhoneNumber,
        // timestamp,
      ];
}
