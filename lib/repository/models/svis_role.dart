import 'package:app/repository/models/permission.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

const String kSVISRole = 'SVISRole';

class SvisRole extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  SvisRole() : super(kSVISRole);
  SvisRole.clone() : this();

  @override
  SvisRole clone(Map<String, dynamic> map) => SvisRole.clone()..fromJson(map);

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

  bool? get status {
    return this.get('Activate');
  }

  ParseRelation<Permission>? get permissions {
    return this.getRelation('Permissions');
  }
  ParseRelation<User>? get users {
    return this.getRelation('Users');
  }

  set status(bool? value) {
    this.set('Activate', value);
  }

  @override
  List<Object?> get props => [
        objectId,
      ];
}
