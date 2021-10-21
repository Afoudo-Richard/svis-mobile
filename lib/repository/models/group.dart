import 'package:app/repository/models/profile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kGroup = 'Group';

class Group extends ParseObject implements ParseCloneable {
  Group() : super(kGroup);
  Group.clone() : this();

  @override
  Group clone(Map<String, dynamic> map) => Group.clone()..fromJson(map);

  String? get name {
    return this.get('Name');
  }

  set name(String? value) {
    set('Name', value);
  }

  String? get description {
    return get('Description');
  }

  set description(String? value) {
    set('Description', value);
  }

  ParseFile? get photo {
    return get('Photo');
  }

  set photo(ParseFile? value) {
    set('Photo', value);
  }

  ParseFile? get activationStatus {
    return get('Activate');
  }

  set activationStatus(ParseFile? value) {
    set('Activate', value);
  }

  ParseUser? get owner {
    return get('owner');
  }

  set owner(ParseUser? value) {
    set('owner', value);
  }

  Profile? get profile {
    return get('profile');
  }

  set profile(Profile? value) {
    set('profile', value);
  }
}
