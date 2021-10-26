import 'package:app/repository/models/group.dart';
import 'package:app/repository/models/profile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kProfileUserGroup = 'ProfileUserGroup';

class ProfileUserGroup extends ParseObject implements ParseCloneable {
  ProfileUserGroup() : super(kProfileUserGroup);
  ProfileUserGroup.clone() : this();

  @override
  ProfileUserGroup clone(Map<String, dynamic> map) =>
      ProfileUserGroup.clone()..fromJson(map);

  String? get name {
    return this.get('name');
  }

  set name(String? value) {
    set('name', value);
  }

  Group? get group {
    return Group().clone(get<ParseObject?>('group')?.toJson(full: true) ?? {});
  }

  set group(Group? value) {
    set('group', value);
  }

  Profile? get profile {
    return get('profile');
  }

  set profile(Profile? value) {
    set('profile', value);
  }
}
