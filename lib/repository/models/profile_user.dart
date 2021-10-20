import 'package:app/repository/models/group.dart';
import 'package:app/repository/models/permission.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kProfileUser = 'ProfileUsers';

class ProfileUser extends ParseObject implements ParseCloneable {
  ProfileUser() : super(kProfileUser);
  ProfileUser.clone() : this();

  @override
  ProfileUser clone(Map<String, dynamic> map) =>
      ProfileUser.clone()..fromJson(map);

  String? get name => get<String?>('Name');
  set name(String? value) => set<String?>('Name', value);

  ProfileUserTypes? get profileUserType =>
      get<ProfileUserTypes>('ProfileUserTypes');
  set profileUserType(ProfileUserTypes? value) =>
      set<ProfileUserTypes?>('ProfileUserTypes', value);

  User? get user => get<User?>('User');
  set user(User? value) => set<User?>('User', value);

  Profile? get profile => get<Profile?>('Profile');
  set profile(Profile? value) => set<Profile?>('Profile', value);

  Group? get group => this.get('Groups');
  set group(Group? value) => this.set('Groups', value);

  SvisRole? get role => this.get('Roles');
  set role(SvisRole? value) => this.set('Roles', value);

  Permission? get permission => this.get('Permissions');
  set permission(Permission? value) => this.set('Permissions', value);

  bool get status => this.get('status');
  set status(bool value) => this.set('status', value);

  DateTime? get expirationDate => this.get('expirationDate');
  set expirationDate(DateTime? value) => this.set('expirationDate', value);

  String? get accessMode => this.get('accessMode');
  set accessMode(String? value) => this.set('accessMode', value);
}
