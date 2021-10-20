import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kProfileUserTypes = 'ProfileUserTypes';

class ProfileUserTypes extends ParseObject implements ParseCloneable {
  ProfileUserTypes() : super(kProfileUserTypes);
  ProfileUserTypes.clone() : this();

  @override
  ProfileUserTypes clone(Map<String, dynamic> map) =>
      ProfileUserTypes.clone()..fromJson(map);

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
}
