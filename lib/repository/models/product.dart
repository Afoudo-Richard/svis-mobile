import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/trackSetup.dart';
import 'package:app/repository/models/vehicle.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kProduct = 'Product';

class Product extends ParseObject implements ParseCloneable {
  Product() : super(kProduct);
  Product.clone() : this();

  @override
  Product clone(Map<String, dynamic> map) => Product.clone()..fromJson(map);

  String? get parameter => this.get('parameter');
  set parameter(String? value) => set('parameter', value);

  Vehicle? get name => this.get('Name');
  set name(Vehicle? value) => set('Name', value);

  User? get owner => this.get('owner');
  set owner(User? value) => set('owner', value);

  String? get lastUpdatedBy => this.get('LastUpdatedBy');
  set lastUpdatedBy(String? value) => set('LastUpdatedBy', value);

  int? get monthlyPrice => this.get('monthlyPrice');
  set monthlyPrice(int? value) => set('monthlyPrice', value);

  String? get description => this.get('Description');
  set description(String? value) => set('Description', value);

  String? get services => this.get('services');
  set services(String? value) => set('services', value);

  String? get yearlyPrice => this.get('yearlyPrice');
  set yearlyPrice(String? value) => set('yearlyPrice', value);

  User? get createdBy => this.get('createdBy');
  set createdBy(User? value) => set('createdBy', value);

}
