import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kProfile = 'Profile';

class Profile extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  Profile() : super(kProfile);
  Profile.clone() : this();

  @override
  Profile clone(Map<String, dynamic> map) => Profile.clone()..fromJson(map);

  String? get name {
    return this.get('name');
  }

  set name(String? value) {
    this.set('name', value);
  }

  String? get firstName {
    return this.get('firstName');
  }

  set firstName(String? value) {
    this.set('firstName', value);
  }

  String? get lastName {
    return this.get('lastName');
  }

  set lastName(String? value) {
    this.set('lastName', value);
  }

  String? get address {
    return this.get('address');
  }

  set address(String? value) {
    this.set('address', value);
  }

  String? get country {
    return this.get('country');
  }

  set country(String? value) {
    this.set('country', value);
  }

  String? get description {
    return this.get('description');
  }

  set description(String? value) {
    this.set('description', value);
  }

  String? get phoneNumber {
    return this.get('phoneNumber');
  }

  set phoneNumber(String? value) {
    this.set('phoneNumber', value);
  }

  String? get fullName {
    return this.get('companyName');
  }

  set fullName(String? value) {
    this.set('companyName', value);
  }

  String? get addressLine2 {
    return this.get('addressLine2');
  }

  set addressLine2(String? value) {
    this.set('addressLine2', value);
  }

  String? get postalCode {
    return this.get('postalCode');
  }

  set postalCode(String? value) {
    this.set('postalCode', value);
  }

  String? get countryCode {
    return this.get('countryCode');
  }

  set countryCode(String? value) {
    this.set('countryCode', value);
  }

  User? get owner {
    return this.get('owner');
  }

  set owner(User? value) {
    this.set('owner', value);
  }

  ParseFile? get profileImage {
    return this.get('profileLogo');
  }

  set profileImage(ParseFile? value) {
    this.set('profileLogo', value);
  }

  String? get companyName {
    return this.get('companyName');
  }

  set companyName(String? value) {
    this.set('companyName', value);
  }

  String? get state {
    return this.get('state');
  }

  set state(String? value) {
    this.set('state', value);
  }

  String? get email {
    return this.get('email');
  }

  set email(String? value) {
    this.set('email', value);
  }

  String? get username {
    return this.get('email');
  }

  set username(String? value) {
    this.set('email', value);
  }

  @override
  List<Object?> get props => [];
}
