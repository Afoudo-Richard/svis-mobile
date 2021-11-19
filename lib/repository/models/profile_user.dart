import 'package:app/repository/models/group.dart';
import 'package:app/repository/models/permission.dart';
import 'package:app/repository/models/profile.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kProfileUser = 'ProfileUsers';

class ProfileUser extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
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

  ParseRelation<Group>? get group => this.getRelation('Groups');

  ParseRelation<ParseObject>? get role => this.getRelation('Roles');

  ParseRelation<Permission>? get permission => this.getRelation('Permissions');

  bool? get status => this.get('status');
  set status(bool? value) => this.set('status', value);

  DateTime? get expirationDate => this.get('expirationDate');
  set expirationDate(DateTime? value) => this.set('expirationDate', value);

  String? get accessMode => this.get('accessMode');
  set accessMode(String? value) => this.set('accessMode', value);

  @override
  List<Object?> get props => [
        objectId,
        name,
        profileUserType,
        user,
        profile,
        group,
        role,
        permission,
        status,
        expirationDate,
        accessMode,
      ];
}
